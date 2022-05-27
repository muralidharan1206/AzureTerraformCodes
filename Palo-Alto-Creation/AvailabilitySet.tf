resource "azurerm_availability_set" "PaloAlto" {
  name                = var.Availability_set_name
  location            = azurerm_resource_group.PaloAlto.location
  resource_group_name = azurerm_resource_group.PaloAlto.name
}