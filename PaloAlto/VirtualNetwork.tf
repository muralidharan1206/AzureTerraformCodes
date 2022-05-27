resource "azurerm_virtual_network" "vnet" {
  name                = "vnet"
  address_space       = "10.0.0.0/16"
  location            = azurerm_resource_group.demoRG.location
  resource_group_name = azurerm_resource_group.demoRG.name
}