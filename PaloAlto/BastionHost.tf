# Create the bastion service
resource "azurerm_bastion_host" "bastion" {
  name                = "bastionHost"
  resource_group_name = azurerm_resource_group.demoRG.name
  location            = azurerm_resource_group.vnet.location
    
  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion.id
    public_ip_address_id = azurerm_public_ip.bastion.id
  }
}