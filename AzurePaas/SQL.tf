resource "azurerm_sql_server" "example" {
  name                         = var.SQL_Server_name
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.SQL_admin_username
  administrator_login_password = var.SQL_admin_password
}

resource "azurerm_sql_database" "example" {
  name                = var.SQL_database
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = azurerm_sql_server.example.name
}