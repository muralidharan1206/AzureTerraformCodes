//To associate Network Interface and Backend addres poll
resource "azurerm_network_interface_backend_address_pool_association" "test_1" {
      network_interface_id    = azurerm_network_interface.demoNI_1.id
      ip_configuration_name   = "myNicConfiguration-1"
      backend_address_pool_id = azurerm_lb_backend_address_pool.demoBP.id
    }

resource "azurerm_network_interface_backend_address_pool_association" "test_2" {
      network_interface_id    = azurerm_network_interface.demoNI_2.id
      ip_configuration_name   = "myNicConfiguration-2"
      backend_address_pool_id = azurerm_lb_backend_address_pool.demoBP.id
    }