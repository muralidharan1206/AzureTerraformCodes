# Create route table and bind to required to subnets

# This table sends all non-vnet local traffic to the PAN firewall
resource "azurerm_route_table" "pan_fw1" {
  name                          = "pan_fw1"
  location                      = azurerm_resource_group.demoRG.location
  resource_group_name           = azurerm_resource_group.vnet.name
  disable_bgp_route_propagation = false

  route {
    name           = "to-inet-pan"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VirtualAppliance"
    # Nexthop is the PAN virtual appliance VNIC2 aka the trust interface
    next_hop_in_ip_address = azurerm_network_interface.FW_VNIC2.private_ip_address
  }
}