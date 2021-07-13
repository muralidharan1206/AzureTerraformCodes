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
resource "azurerm_resource_group" "example" {
  name     = "demoRG"
  location = "eastus"
}

//Virtual Network 1
resource "azurerm_virtual_network" "Vnet1_example" {
    name                = "Vnet1"
    address_space       = ["10.1.0.0/16"]
    location            = "eastus"
    resource_group_name = azurerm_resource_group.example.name
}

//subnet1
resource "azurerm_subnet" "Subnet1_example" {
    name                 = "subnet1"
    resource_group_name  = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.Vnet1_example.name
    address_prefixes       = ["10.1.0.0/24"]
}

//Gateway Subnet1 for Vnet1
resource "azurerm_subnet" "gateway_subnet1" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.Vnet1_example.name
  address_prefixes     = ["10.1.255.0/27"]
}

//Network Interface for subnet1
resource "azurerm_network_interface" "NI1_example" {
    name                        = "NI1"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.example.name

    ip_configuration {
        name                          = "PublicNicConfiguration"
        subnet_id                     = azurerm_subnet.Subnet1_example.id
        private_ip_address_allocation = "Static"
        public_ip_address_id          = azurerm_public_ip.pip1_example.id
		private_ip_address			  = "10.1.0.4"
    }
}

//public address
resource "azurerm_public_ip" "pip1_example" {
    name                         = "pip1"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.example.name
    allocation_method            = "Static"
}


//virtual machine for subnet1 on Vnet1
resource "azurerm_virtual_machine" "VM1_example" {
    name                  = "VM1"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.example.name
    network_interface_ids = [azurerm_network_interface.NI1_example.id]
    vm_size                  = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk { 
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "VM01"
    admin_username = "azureuser"
    admin_password = "admin@123qwe"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}


//public address for NVG
resource "azurerm_public_ip" "NVG_pip1" {
    name                         = "NVG_pip1"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.example.name
    allocation_method            = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "VNG1_example" {
  name                = "VN_GW1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig1"
    public_ip_address_id          = azurerm_public_ip.NVG_pip1.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet1.id
  }
}

//gateway connection 1
resource "azurerm_virtual_network_gateway_connection" "east_to_west" {
  name                = "east_to_west"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.VNG1_example.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.VNG2_example.id

  shared_key = "abc123"
}


