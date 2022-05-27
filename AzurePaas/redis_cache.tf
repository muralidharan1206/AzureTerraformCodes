
resource "azurerm_redis_cache" "example" {
  name                = var.Redis_name
  location            = var.location
  resource_group_name = var.resource_group_name
  capacity            = var.Redis_capacity
  family              = var.Redis_family
  sku_name            = var.Redis_sku
  enable_non_ssl_port = false
  minimum_tls_version = "1.2"

  redis_configuration {
  }
}