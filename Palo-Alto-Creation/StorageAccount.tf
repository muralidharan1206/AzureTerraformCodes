//storage accont
resource "azurerm_storage_account" "SA" {
  name                     = var.Storage_account_name
  resource_group_name      = azurerm_resource_group.PaloAlto.name
  location                 = azurerm_resource_group.PaloAlto.location
  account_tier             = var.Storage_account_tier
  account_replication_type = var.Storage_account_type //("Local redundant storage" , we can give GRS or ZRS for replication across zones and regions)
  allow_blob_public_access = var.Storage_account_access //(allowing to access public)
}