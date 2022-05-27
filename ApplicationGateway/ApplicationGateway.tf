//Application Gateway
resource "azurerm_application_gateway" "network" {
    name                = "ap_gw"
    location            = azurerm_resource_group.demoRG.location
    resource_group_name = azurerm_resource_group.demoRG.name
    sku {
        name           = "Standard_Small"
        tier           = "Standard"
        capacity       = 2
    }
    gateway_ip_configuration {
        name         = "gwip-config"
        subnet_id    = azurerm_subnet.subnet1.id
    }
    frontend_port {
        name         = local.frontend_port_name
        port         = 80
    }
    frontend_ip_configuration {
        name         = local.frontend_ip_configuration_name  
        public_ip_address_id = azurerm_public_ip.pip.id
    }
    backend_address_pool {
        name = local.backend_address_pool_name
    }

    backend_http_settings {
        name                  = local.http_setting_name 
        cookie_based_affinity = "Disabled"
        port                  = 80
        protocol              = "Http"
        request_timeout        = 1
    }

    http_listener {
        name                                  = local.listener_name 
        frontend_ip_configuration_name        = local.frontend_ip_configuration_name  
        frontend_port_name                    = local.frontend_port_name
        protocol                              = "Http"
    }

    request_routing_rule {
        name                       = local.request_routing_rule_name
        rule_type                  = "Basic"
        http_listener_name         = local.listener_name 
        backend_address_pool_name  = local.backend_address_pool_name
        backend_http_settings_name = local.http_setting_name
    }
}

//PublicIP for Application Gateway
resource "azurerm_public_ip" "pip" {
    name                         = "pip"
    location                     = azurerm_resource_group.demoRG.location
    resource_group_name          = azurerm_resource_group.demoRG.name
    allocation_method            = "Dynamic"
}

//Local variables
locals {
  backend_address_pool_name      = "${azurerm_virtual_network.vnet.name}-beap"
  frontend_port_name             = "${azurerm_virtual_network.vnet.name}-feport"
  frontend_ip_configuration_name = "${azurerm_virtual_network.vnet.name}-feip"
  http_setting_name              = "${azurerm_virtual_network.vnet.name}-be-htst"
  listener_name                  = "${azurerm_virtual_network.vnet.name}-httplstn"
  request_routing_rule_name      = "${azurerm_virtual_network.vnet.name}-rqrt"
}

