//Resource Group
resource "azurerm_resource_group" "demoRG" {
  name     = "RG1"
  location = "eastus"
}