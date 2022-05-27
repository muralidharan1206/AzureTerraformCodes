# Bind route table to subnets
# In only the VDI and server subnet will be forced to route Internet traffic to the PAN
resource "azurerm_subnet_route_table_association" "server_fw1_map" {
  subnet_id      = azurerm_subnet.private.id
  route_table_id = azurerm_route_table.pan_fw1.id
}

resource "azurerm_subnet_route_table_association" "vdesktop_fw1_map" {
  subnet_id      =  azurerm_subnet.vdesktop.id
  route_table_id = azurerm_route_table.pan_fw1.id
}

