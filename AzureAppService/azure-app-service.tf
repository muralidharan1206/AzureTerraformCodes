# Create the App Service Plan
resource "azurerm_app_service_plan" "demo_service_plan" {
  name                = "webapp_plan"
  location            = azurerm_resource_group.demoRG.location
  resource_group_name = azurerm_resource_group.demoRG.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# Create the App Service
resource "azurerm_app_service" "demo_app_service" {
  name                = "mobilewebapp2021"
  location            = azurerm_resource_group.demoRG.location
  resource_group_name = azurerm_resource_group.demoRG.name
  app_service_plan_id = azurerm_app_service_plan.demo_service_plan.id

  site_config {
	linux_fx_version = "TOMCAT|8.5-java11"
  }
}


