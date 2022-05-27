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