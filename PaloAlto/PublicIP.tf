# Create a public IP address for the bastion service
resource "azurerm_public_ip" "bastion" {
  name                = "bastionPubIp"
  resource_group_name = azurerm_resource_group.demoRG.name
  location            = azurerm_resource_group.vnet.location
  allocation_method   = "Static"
  sku                 = "Standard"
}