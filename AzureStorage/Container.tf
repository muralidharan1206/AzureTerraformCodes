//container 
resource "azurerm_storage_container" "democontainer" {
  name                  = "container1"
  storage_account_name  = azurerm_storage_account.demoSA.name
  container_access_type = "private"
}
