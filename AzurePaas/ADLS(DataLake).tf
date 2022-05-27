resource "azurerm_storage_account" "example" {
  name                     = var.Storage_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.Storage_Account_Tier
  account_replication_type = var.Storage_Replication_Type
  account_kind             = var.Storage_Account_Kind
  is_hns_enabled           = "true"
}

resource "azurerm_storage_data_lake_gen2_filesystem" "example" {
  name               = var.DataLake_name
  storage_account_id = azurerm_storage_account.example.id

  properties = {
    hello = "aGVsbG8="
  }
}