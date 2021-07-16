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

//Virtual Network
resource "azurerm_virtual_network" "Vnet1" {
  name                = "MyVnet1"
  resource_group_name = azurerm_resource_group.demoRG.name
  address_space       = ["10.0.0.0/16"]
  location            = "eastus"
}

//Subnet
resource "azurerm_subnet" "demosubnet_Vnet1" {
    name                 = "subnet1"
    resource_group_name  = azurerm_resource_group.demoRG.name
    virtual_network_name = azurerm_virtual_network.Vnet1.name
    address_prefixes       = ["10.0.64.0/18"]
}

resource "azurerm_subnet" "bastion_subnet" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.demoRG.name
  virtual_network_name = azurerm_virtual_network.Vnet1.name
  address_prefixes     = ["10.0.0.0/20"]
}

resource "azurerm_public_ip" "pip" {
  name                = "pip"
  location            = azurerm_resource_group.demoRG.location
  resource_group_name = azurerm_resource_group.demoRG.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion_host" {
  name                = "bastion"
  location            = azurerm_resource_group.demoRG.location
  resource_group_name = azurerm_resource_group.demoRG.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_subnet.id
    public_ip_address_id = azurerm_public_ip.pip.id
  }
}

//Network interface card
resource "azurerm_network_interface" "demoNI_1" {
    name                        = "NI1"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.demoRG.name

    ip_configuration {
        name                          = "myNicConfiguration-1"
        subnet_id                     = azurerm_subnet.demosubnet_Vnet1.id
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.0.127.254"
    }
}

//VM
resource "azurerm_linux_virtual_machine" "demoVM" {
    name                  = "VM"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.demoRG.name
    network_interface_ids = [azurerm_network_interface.demoNI_1.id]
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

resource "azurerm_virtual_machine_extension" "vm_extension" {
  name = "vm_extension"
  virtual_machine_id = azurerm_linux_virtual_machine.demoVM.id
  publisher = "Microsoft.Azure.Extensions"
  type = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
        {
          "commandToExecute" : "apt-get -y update && apt-get install -y apache2" 
        }
        SETTINGS
}