resource "azurerm_virtual_network_gateway" "VNG1_example" {
  name                = "VN_GW1"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "VpnGw1"

  ip_configuration {
    name                          = "vnetGatewayConfig1"
    public_ip_address_id          = azurerm_public_ip.NVG_pip1.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway_subnet1.id
  }
}

//public address for NVG
resource "azurerm_public_ip" "NVG_pip1" {
    name                         = "NVG_pip1"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.example.name
    allocation_method            = "Dynamic"
}

//gateway connection 1
resource "azurerm_virtual_network_gateway_connection" "east_to_west" {
  name                = "east_to_west"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  type                            = "Vnet2Vnet"
  virtual_network_gateway_id      = azurerm_virtual_network_gateway.VNG1_example.id
  peer_virtual_network_gateway_id = azurerm_virtual_network_gateway.VNG2_example.id

  shared_key = "abc123"
}


