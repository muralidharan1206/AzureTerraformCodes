resource "azurerm_route_table" "route_table" {
  name                          = "hub-gateway-rt"
  location                      = azurerm_resource_group.example.location
  resource_group_name           = azurerm_resource_group.example.name
  disable_bgp_route_propagation = false

  route {
    name                   = "publictoprivate"
    address_prefix         = "10.0.16.0/20"  //subnet to which the traffic has to be sent
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.32.4" // target to which the traffic should go (here thr target is virtual machine)
  }
}

resource "azurerm_subnet_route_table_association" "Association" {
  subnet_id      = azurerm_subnet.Public_example.id
  route_table_id = azurerm_route_table.route_table.id
  depends_on = [azurerm_subnet.Public_example]
}
