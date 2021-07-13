//provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "demoRG" {
    name     = "RG1"
    location = "eastus"
}

# Create a MySQL Server
resource "azurerm_mysql_server" "mysql_server" {
  name = "demo-mysql-server-2021"
  location = azurerm_resource_group.demoRG.location
  resource_group_name = azurerm_resource_group.demoRG.name

//MySQL server credentials 
  administrator_login          = "ae4admin12qwe"
  administrator_login_password = "Admin321ewqasd"
 
  sku_name = "B_Gen5_1"
  version  = "8.0"
 
  storage_mb        = "5120"
  auto_grow_enabled = true
  
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false

  public_network_access_enabled     = true
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

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

