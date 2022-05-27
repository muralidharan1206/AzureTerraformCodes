//Gateway Subnet1 for Vnet1
resource "azurerm_subnet" "gateway_subnet1" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.Vnet1_example.name
  address_prefixes     = ["10.1.255.0/27"]
}

//Gateway Subnet1 for Vnet2
resource "azurerm_subnet" "gateway_subnet2" {
  name                 = "GatewaySubnet"
  resource_group_name  = azurerm_resource_group.example1.name
  virtual_network_name = azurerm_virtual_network.Vnet2_example.name
  address_prefixes     = ["10.41.255.0/27"]
}
