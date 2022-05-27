//Virtual Network Peering
resource "azurerm_virtual_network_peering" "peering1" {
  name                      = "peer1to2"
  resource_group_name       = azurerm_resource_group.demoRG.name
  virtual_network_name      = azurerm_virtual_network.Vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.Vnet2.id
}

resource "azurerm_virtual_network_peering" "peering2" {
  name                      = "peer2to1"
  resource_group_name       = azurerm_resource_group.demoRG.name
  virtual_network_name      = azurerm_virtual_network.Vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.Vnet1.id
}
