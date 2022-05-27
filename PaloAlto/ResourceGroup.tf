# Resource group for all network related resources
resource "azurerm_resource_group" "demoRG" {
  name     = "RG1"
  location = "eastus"
}
