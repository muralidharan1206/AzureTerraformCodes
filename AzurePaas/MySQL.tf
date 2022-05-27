resource "azurerm_mysql_server" "example" {
  name = var.MySQL_Server_name
  location = var.location
  resource_group_name = var.resource_group_name

//MySQL server credentials 
  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password
 
  sku_name = var.MySQL_Server_sku
  version  = "8.0"
 
  storage_mb        = var.MySQL_Server_storage
  auto_grow_enabled = true
  
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "example" {
  name                = var.MySQL_database
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.example.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}