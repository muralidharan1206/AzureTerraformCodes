
resource "azurerm_public_ip" "PIP" {
  name                = "nat-gateway-publicIP"
  location            = azurerm_resource_group.demoRG.location
  resource_group_name = azurerm_resource_group.demoRG.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway" "NAT" {
  name                    = "nat-Gateway"
  location                = azurerm_resource_group.demoRG.location
  resource_group_name     = azurerm_resource_group.demoRG.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
}

resource "azurerm_nat_gateway_public_ip_association" "Ip_association" {
  nat_gateway_id       = azurerm_nat_gateway.NAT.id
  public_ip_address_id = azurerm_public_ip.PIP.id
}
