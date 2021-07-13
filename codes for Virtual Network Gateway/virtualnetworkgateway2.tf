//Resource Group
resource "azurerm_resource_group" "example1" {
  name     = "demoRG-1"
  location = "westus"
}

//Virtual Network 2
resource "azurerm_virtual_network" "Vnet2_example" {
    name                = "Vnet2"
    address_space       = ["10.41.0.0/16"]
    location            = "westus"
    resource_group_name = azurerm_resource_group.example1.name
}

//subnet2
resource "azurerm_subnet" "Subnet2_example" {
    name                 = "subnet2"
    resource_group_name  = azurerm_resource_group.example1.name
    virtual_network_name = azurerm_virtual_network.Vnet2_example.name
    address_prefixes       = ["10.41.0.0/24"]
}

//Gateway Subnet1 for Vnet2
resource "azurerm_subnet" "gateway_subnet2" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.example1.name
  virtual_network_name = azurerm_virtual_network.Vnet2_example.name
  address_prefixes     = ["10.41.255.0/27"]
}

//Network Interface for subnet2
resource "azurerm_network_interface" "NI2_example" {
    name                        = "NI2"
    location                    = "westus"
    resource_group_name         = azurerm_resource_group.example1.name

    ip_configuration {
        name                          = "PublicNicConfiguration1"
        subnet_id                     = azurerm_subnet.Subnet2_example.id
        private_ip_address_allocation = "Static"
        public_ip_address_id          = azurerm_public_ip.pip2_example.id
		private_ip_address			  = "10.41.0.4"
    }
}

//public address
resource "azurerm_public_ip" "pip2_example" {
    name                         = "pip2"
    location                     = "westus"
    resource_group_name          = azurerm_resource_group.example1.name
    allocation_method            = "Static"
}

//virtual machine for subnet1 on Vnet2
resource "azurerm_virtual_machine" "VM2_example" {
    name                  = "VM2"
    location              = "westus"
    resource_group_name   = azurerm_resource_group.example1.name
    network_interface_ids = [azurerm_network_interface.NI2_example.id]
    vm_size                  = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "VM02"
    admin_username = "azureuser"
    admin_password = "admin@123qwe"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

//public address for NVG
resource "azurerm_public_ip" "NVG_pip2" {
    name                         = "NVG_pip2"
    location                     = "westus"
    resource_group_name          = azurerm_resource_group.example1.name
    allocation_method            = "Dynamic"
}

resource "azurerm_virtual_network_gateway" "VNG2_example" {
  name                = "VN_GW2"
  location            = azurerm_resource_group.example1.location
  resource_group_name = azurerm_resource_group.example1.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig2"
    public_ip_address_id          = azurerm_public_ip.NVG_pip2.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet2.id
  }
}

//gateway connection 2
resource "azurerm_virtual_network_gateway_connection" "west_to_east" {
  name                = "west_to_east"
  location            = azurerm_resource_group.example1.location
  resource_group_name = azurerm_resource_group.example1.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.VNG2_example.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.VNG1_example.id

  shared_key = "abc123"
}