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

//public address for NVG
resource "azurerm_public_ip" "NVG_pip2" {
    name                         = "NVG_pip2"
    location                     = "westus"
    resource_group_name          = azurerm_resource_group.example1.name
    allocation_method            = "Dynamic"
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