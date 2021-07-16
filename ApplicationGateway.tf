//provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}

//Resource Group
resource "azurerm_resource_group" "demoRG" {
    name     = "RG1"
    location = "eastus"
}

resource "azurerm_virtual_network" "vnet" {
    name                = "Vnet1"
    location            = azurerm_resource_group.demoRG.location
    address_space       = ["10.254.0.0/16"]
    resource_group_name = azurerm_resource_group.demoRG.name
}

resource "azurerm_subnet" "subnet1" {
    name                 = "subnet1"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.demoRG.name
    address_prefixes       = ["10.254.0.0/24"]
}

resource "azurerm_subnet" "subnet2" {
    name                 = "subnet2"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.demoRG.name
    address_prefixes       = ["10.254.1.0/24"]
}

resource "azurerm_public_ip" "pip" {
    name                         = "pip"
    location                     = azurerm_resource_group.demoRG.location
    resource_group_name          = azurerm_resource_group.demoRG.name
    allocation_method            = "Dynamic"
}

locals {
  backend_address_pool_name      = "${azurerm_virtual_network.vnet.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.vnet.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.vnet.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.vnet.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.vnet.name}-rqrt"
}

resource "azurerm_application_gateway" "network" {
    name                = "ap_gw"
    location            = azurerm_resource_group.demoRG.location
    resource_group_name = azurerm_resource_group.demoRG.name
    sku {
        name           = "Standard_Small"
        tier           = "Standard"
        capacity       = 2
    }
    gateway_ip_configuration {
        name         = "gwip-config"
        subnet_id    = azurerm_subnet.subnet1.id
    }
    frontend_port {
        name         = local.frontend_port_name
        port         = 80
    }
    frontend_ip_configuration {
        name         = local.frontend_ip_configuration_name  
        public_ip_address_id = azurerm_public_ip.pip.id
    }
    backend_address_pool {
        name = local.backend_address_pool_name
    }

    backend_http_settings {
        name                  = local.http_setting_name 
        cookie_based_affinity = "Disabled"
        port                  = 80
        protocol              = "Http"
        request_timeout        = 1
    }

    http_listener {
        name                                  = local.listener_name 
        frontend_ip_configuration_name        = local.frontend_ip_configuration_name  
        frontend_port_name                    = local.frontend_port_name
        protocol                              = "Http"
    }

    request_routing_rule {
        name                       = local.request_routing_rule_name
        rule_type                  = "Basic"
        http_listener_name         = local.listener_name 
        backend_address_pool_name  = local.backend_address_pool_name
        backend_http_settings_name = local.http_setting_name
    }
}

resource "azurerm_network_interface" "nic" {
    name                = "nic"
    location            = azurerm_resource_group.demoRG.location
    resource_group_name = azurerm_resource_group.demoRG.name

    ip_configuration {
        name                          = "ipconfig"
        subnet_id                     = azurerm_subnet.subnet2.id
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.254.1.4"
    }
}

#
# Subnet VM

resource "azurerm_linux_virtual_machine" "vm" {
    name                  = "VM1"
    location              = azurerm_resource_group.demoRG.location
    resource_group_name   = azurerm_resource_group.demoRG.name
    size               = "Standard_DS1_v2"
    network_interface_ids = [azurerm_network_interface.nic.id]
    admin_username      = "adminuser"
    admin_password      = "Password1234!"
    disable_password_authentication = false

    connection {
        type                = "ssh"
        bastion_host        = azurerm_public_ip.bastion_pip.fqdn
        bastion_user        = "admin"
        bastion_private_key = "/home/ubuntu/.ssh/id_rsa"
        host                = "${element(azurerm_network_interface.nic.*.private_ip_address,1)}"
        user                = "ubuntu"
        private_key         = "/home/ubuntu/.ssh/id_rsa"
    }

    os_disk {
        name              = "osdisk1"
        storage_account_type = "Standard_LRS"
        caching           = "ReadWrite"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    provisioner "remote-exec" {
        inline = ["sudo apt-get update && sudo apt-get install nginx -y"]
    }
}


# Bastion Host
resource "azurerm_public_ip" "bastion_pip" {
    name                         = "bastion-pip"
    resource_group_name          = azurerm_resource_group.demoRG.name
    location                     = azurerm_resource_group.demoRG.location
    allocation_method            = "Dynamic"
}

resource "azurerm_network_security_group" "bastion_nsg" {
    name                = "bastion-nsg"
    location            = azurerm_resource_group.demoRG.location
    resource_group_name = azurerm_resource_group.demoRG.name

    security_rule {
        name                       = "allow_SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

resource "azurerm_network_interface" "bastion_nic" {
    name                      = "bastion-nic"
    location                  = "eastus"
    resource_group_name       = azurerm_resource_group.demoRG.name

    ip_configuration {
        name                          = "bastion-ipconfig"
        subnet_id                     = azurerm_subnet.subnet2.id
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.254.1.5"
        public_ip_address_id          = azurerm_public_ip.bastion_pip.id
    }
}


resource "azurerm_linux_virtual_machine" "bastion" {
    name                  = "bastion"
    location              = azurerm_resource_group.demoRG.location
    resource_group_name   = azurerm_resource_group.demoRG.name
    size               = "Standard_DS1_v2"
    network_interface_ids = [azurerm_network_interface.bastion_nic.id]
    admin_username      = "adminuser"
    admin_password      = "Password1234!"
    disable_password_authentication = false

    os_disk {
        name              = "bastion-osdisk"
        caching           = "ReadWrite"
        storage_account_type = "StandardSSD_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
}