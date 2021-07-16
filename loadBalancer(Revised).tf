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

//LoadBalancer Public IP
resource "azurerm_public_ip" "demo_pub_ip" {
  name                = "Pub_ip"
  resource_group_name = azurerm_resource_group.demoRG.name
  location            = azurerm_resource_group.demoRG.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

//Load Balancer
resource "azurerm_lb" "demolb" {
  name                = "LB1"
  resource_group_name = azurerm_resource_group.demoRG.name
  location            = azurerm_resource_group.demoRG.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "mypubip"
    public_ip_address_id          = azurerm_public_ip.demo_pub_ip.id
  }
}

//Backend Pool
resource "azurerm_lb_backend_address_pool" "demoBP" {
  name                = "BackEndAddressPool_12"
  loadbalancer_id     = azurerm_lb.demolb.id
}

//To associate Network Interface and Backend addres poll
resource "azurerm_network_interface_backend_address_pool_association" "test_1" {
      network_interface_id    = azurerm_network_interface.demoNI_1.id
      ip_configuration_name   = "myNicConfiguration-1"
      backend_address_pool_id = azurerm_lb_backend_address_pool.demoBP.id
    }

resource "azurerm_network_interface_backend_address_pool_association" "test_2" {
      network_interface_id    = azurerm_network_interface.demoNI_2.id
      ip_configuration_name   = "myNicConfiguration-2"
      backend_address_pool_id = azurerm_lb_backend_address_pool.demoBP.id
    }

//Health Probe
resource "azurerm_lb_probe" "demoprobe" {
  name                = "health_probe"
  resource_group_name = azurerm_resource_group.demoRG.name
  loadbalancer_id     = azurerm_lb.demolb.id
  protocol            = "Tcp"
  port                = "80"
  interval_in_seconds = "5"
  number_of_probes    = "2"
}

//Load balancing rule-1
resource "azurerm_lb_rule" "demo_lb_rule_1" {
  name                           = "lb_rule1"
  resource_group_name            = azurerm_resource_group.demoRG.name
  loadbalancer_id                = azurerm_lb.demolb.id
  protocol                       = "tcp"
  frontend_port                  = "80"
  backend_port                   = "80"
  frontend_ip_configuration_name = "mypubip"
  enable_floating_ip             = false
  backend_address_pool_id        = azurerm_lb_backend_address_pool.demoBP.id
  idle_timeout_in_minutes        = 5
  probe_id                       = azurerm_lb_probe.demoprobe.id
}

//Load balancing rule-2
resource "azurerm_lb_rule" "demo_lb_rule_2" {
  name                           = "lb_rule2"
  resource_group_name            = azurerm_resource_group.demoRG.name
  loadbalancer_id                = azurerm_lb.demolb.id
  protocol                       = "tcp"
  frontend_port                  = "5000"
  backend_port                   = "22"
  frontend_ip_configuration_name = "mypubip"
  enable_floating_ip             = false
  backend_address_pool_id        = azurerm_lb_backend_address_pool.demoBP.id
  idle_timeout_in_minutes        = 5
  probe_id                       = azurerm_lb_probe.demoprobe.id
}

//Virtual Network
resource "azurerm_virtual_network" "Vnet1" {
  name                = "MyVnet1"
  resource_group_name = azurerm_resource_group.demoRG.name
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
}

//Subnet for virtual machine
resource "azurerm_subnet" "demosubnet_Vnet1" {
    name                 = "subnet1"
    resource_group_name  = azurerm_resource_group.demoRG.name
    virtual_network_name = azurerm_virtual_network.Vnet1.name
    address_prefixes       = ["10.0.64.0/18"]
}

//Network security group
resource "azurerm_network_security_group" "demoNSG" {
        name                            = "NSG1"
        resource_group_name = azurerm_resource_group.demoRG.name
        location                        = azurerm_resource_group.demoRG.location

        security_rule {
        name                       = "HTTP"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
	
	    security_rule {
        name                       = "SSH"
        priority                   = 1010
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }


        security_rule {
        name                       = "Any"
        priority                   = 100
        direction                  = "Outbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

//To associate Network Interface and Security group
resource "azurerm_network_interface_security_group_association" "NSG_asso1" {
  network_interface_id      = azurerm_network_interface.demoNI_1.id
  network_security_group_id = azurerm_network_security_group.demoNSG.id
}

  resource "azurerm_network_interface_security_group_association" "NSG_asso2" {
  network_interface_id      = azurerm_network_interface.demoNI_2.id
  network_security_group_id = azurerm_network_security_group.demoNSG.id
}

//Network interface for virtual machine-1
resource "azurerm_network_interface" "demoNI_1" {
    name                        = "NI1"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.demoRG.name

    ip_configuration {
        name                          = "myNicConfiguration-1"
        subnet_id                     = azurerm_subnet.demosubnet_Vnet1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.demo_pub_ip_NI1.id
    }
}

//Public IP for Network interface -1
resource "azurerm_public_ip" "demo_pub_ip_NI1" {
  name                = "Pub_ip_NI1"
  resource_group_name = azurerm_resource_group.demoRG.name
  location            = azurerm_resource_group.demoRG.location
  allocation_method   = "Static"
  sku                 = "Standard"
}
 
//Network Interface for virtual machine-2
resource "azurerm_network_interface" "demoNI_2" {
    name                        = "NI2"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.demoRG.name

    ip_configuration {
        name                          = "myNicConfiguration-2"
        subnet_id                     = azurerm_subnet.demosubnet_Vnet1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.demo_pub_ip_NI2.id
    }
}

//Public IP for Network Interface-2
resource "azurerm_public_ip" "demo_pub_ip_NI2" {
  name                = "Pub_ip_NI2"
  resource_group_name = azurerm_resource_group.demoRG.name
  location            = azurerm_resource_group.demoRG.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

//VM-1
resource "azurerm_linux_virtual_machine" "demoVM-1" {
    name                  = "VM1"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.demoRG.name
    network_interface_ids = [azurerm_network_interface.demoNI_1.id]
    size                  = "Standard_DS1_v2"
    admin_username      = "adminuser"
    admin_password      = "Password1234!"
    disable_password_authentication = false

    os_disk {
        name              = "myOsDisk1"
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

//virtual machine extension for vm-1
resource "azurerm_virtual_machine_extension" "vm_extension" {
  name = "vm_extension"
  virtual_machine_id = azurerm_linux_virtual_machine.demoVM-1.id
  publisher = "Microsoft.Azure.Extensions"
  type = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
        {
          "commandToExecute" : "apt-get -y update && apt-get install -y apache2" 
        }
        SETTINGS
}

//VM-2
resource "azurerm_linux_virtual_machine" "demoVM-2" {
    name                  = "VM2"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.demoRG.name
    network_interface_ids = [azurerm_network_interface.demoNI_2.id]
    size                  = "Standard_DS1_v2"
    admin_username      = "adminuser"
    admin_password      = "Password1234!"
    disable_password_authentication = false

    os_disk {
        name              = "myOsDisk"
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

//virtaual machine extension for vm-2
resource "azurerm_virtual_machine_extension" "vm_extension-1" {
  name = "vm_extension-1"
  virtual_machine_id = azurerm_linux_virtual_machine.demoVM-2.id
  publisher = "Microsoft.Azure.Extensions"
  type = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
        {
          "commandToExecute" : "apt-get -y update && apt-get install -y apache2" 
        }
        SETTINGS
}