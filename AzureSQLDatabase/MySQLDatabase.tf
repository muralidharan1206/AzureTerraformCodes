# Create a MySQL Database
resource "azurerm_mysql_database" "mysql_db" {
  name                = "prod12db"
  resource_group_name = azurerm_resource_group.demoRG.name
  server_name         = azurerm_mysql_server.mysql_server.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

resource "azurerm_mysql_firewall_rule" "ae4firewall" {
  name                = "ae4firewallrule"
  resource_group_name = azurerm_resource_group.demoRG.name
  server_name         = azurerm_mysql_server.sql_server.name
  start_ip_address    = "115.97.89.21"
  end_ip_address      = "115.97.89.21"
}

output "server_name" {
	value = "${azurerm_mysql_server.mysql_server.id}"
}

