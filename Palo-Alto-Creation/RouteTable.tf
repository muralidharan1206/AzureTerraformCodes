//UDR for Management Subnet
resource "azurerm_route_table" "RT-1" {
  name                          = var.RT1_name
  location                      = azurerm_resource_group.PaloAlto.location
  resource_group_name           = azurerm_resource_group.PaloAlto.name
  disable_bgp_route_propagation = false

  route {
    name                   = "RouteToMgmt"
    address_prefix         = "172.16.0.0/24"  //Management subnet to which the traffic has to be sent
    next_hop_type          = "None"
    /*next_hop_in_ip_address = None // Loadbalancer is the target to which the traffic should go*/
  }

    route {
    name                   = "RouteToInternet"
    address_prefix         = "0.0.0.0/0"  //Management subnet to which the traffic has to be sent
    next_hop_type          = "Internet"
   /*next_hop_in_ip_address = None // Loadbalancer is the target to which the traffic should go*/
  }
}

//UDR for Internet Subnet
resource "azurerm_route_table" "RT-2" {
  name                          = var.RT2_name
  location                      = azurerm_resource_group.PaloAlto.location
  resource_group_name           = azurerm_resource_group.PaloAlto.name
  disable_bgp_route_propagation = false

  route {
    name                   = "RouteToMgmt"
    address_prefix         = "172.16.0.0/24"  //Internet subnet to which the traffic has to be sent
    next_hop_type          = "None"
    /*next_hop_in_ip_address = azurerm_public_ip.LBIP.id // Loadbalancer is target to which the traffic should go */
  }
}

//UDR for Trust Subnet
resource "azurerm_route_table" "RT-3" {
  name                          = var.RT3_name
  location                      = azurerm_resource_group.PaloAlto.location
  resource_group_name           = azurerm_resource_group.PaloAlto.name
  disable_bgp_route_propagation = false

  route {
    name                   = "RouteToMgmt"
    address_prefix         = "172.16.0.0/24"  //subnet to which the traffic has to be sent
    next_hop_type          = "None"
    /*next_hop_in_ip_address = azurerm_public_ip.LBIP.id // Loadbalancer is target to which the traffic should go*/
  }
}

//Route Table Association for Management Subnet
resource "azurerm_subnet_route_table_association" "MgmtAsso" {
  subnet_id      = azurerm_subnet.Mgmt.id
  route_table_id = azurerm_route_table.RT-1.id
  depends_on = [azurerm_subnet.Mgmt]
}

//Route Table Association for Internet Subnet
resource "azurerm_subnet_route_table_association" "InternetAsso" {
  subnet_id      = azurerm_subnet.Internet.id
  route_table_id = azurerm_route_table.RT-2.id
  depends_on = [azurerm_subnet.Internet]
}

//Route Table Association for Trust Subnet
resource "azurerm_subnet_route_table_association" "TrustAsso" {
  subnet_id      = azurerm_subnet.Trust.id
  route_table_id = azurerm_route_table.RT-3.id
  depends_on = [azurerm_subnet.Trust]
}