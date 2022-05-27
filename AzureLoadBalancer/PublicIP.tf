//LoadBalancer Public IP
resource "azurerm_public_ip" "demo_pub_ip" {
  name                = "Pub_ip"
  resource_group_name = azurerm_resource_group.demoRG.name
  location            = azurerm_resource_group.demoRG.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

//Public IP for Network interface -1
resource "azurerm_public_ip" "demo_pub_ip_NI1" {
  name                = "Pub_ip_NI1"
  resource_group_name = azurerm_resource_group.demoRG.name
  location            = azurerm_resource_group.demoRG.location
  allocation_method   = "Static"
  sku                 = "Standard"
}

//Public IP for Network Interface-2
resource "azurerm_public_ip" "demo_pub_ip_NI2" {
  name                = "Pub_ip_NI2"
  resource_group_name = azurerm_resource_group.demoRG.name
  location            = azurerm_resource_group.demoRG.location
  allocation_method   = "Static"
  sku                 = "Standard"
}
