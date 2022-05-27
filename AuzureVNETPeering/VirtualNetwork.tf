//Virtual Network
resource "azurerm_virtual_network" "Vnet1" {
  name                = "MyVnet1"
  resource_group_name = azurerm_resource_group.demoRG.name
  address_space       = ["10.0.1.0/24"]
  location            = "eastus"
}

resource "azurerm_subnet" "demosubnet-Vnet1" {
    name                 = "subnet1"
    resource_group_name  = azurerm_resource_group.demoRG.name
    virtual_network_name = azurerm_virtual_network.Vnet1.name
    address_prefixes       = ["10.0.1.1/24"]
}

resource "azurerm_virtual_network" "Vnet2" {
  name                = "MyVnet2"
  resource_group_name = azurerm_resource_group.demoRG.name
  address_space       = ["10.0.2.0/24"]
  location            = "eastus"
}

resource "azurerm_subnet" "demosubnet-Vnet2" {
    name                 = "subnet2"
    resource_group_name  = azurerm_resource_group.demoRG.name
    virtual_network_name = azurerm_virtual_network.Vnet2.name
    address_prefixes       = ["10.0.2.1/24"]
}