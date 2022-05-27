//storage accont
resource "azurerm_storage_account" "demoSA" {
  name                     = "demostorageaccount1698"
  resource_group_name      = azurerm_resource_group.demoRG.name
  location                 = azurerm_resource_group.demoRG.location
  account_tier             = "Standard"
  account_replication_type = "LRS" //("Local redundant storage" , we can give GRS or ZRS for replication across zones and regions)
  allow_blob_public_access = "true" //(allowing to access public)
}