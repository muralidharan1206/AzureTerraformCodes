//Load Balancer
resource "azurerm_lb" "demolb" {
  name                = "LB1"
  resource_group_name = azurerm_resource_group.demoRG.name
  location            = azurerm_resource_group.demoRG.location
  sku                 = "Standard"

  frontend_ip_configuration {
    name                          = "mypubip"
    public_ip_address_id          = azurerm_public_ip.demo_pub_ip.id
  }
}

//Backend Pool
resource "azurerm_lb_backend_address_pool" "demoBP" {
  name                = "BackEndAddressPool_12"
  loadbalancer_id     = azurerm_lb.demolb.id
}

//Health Probe
resource "azurerm_lb_probe" "demoprobe" {
  name                = "health_probe"
  resource_group_name = azurerm_resource_group.demoRG.name
  loadbalancer_id     = azurerm_lb.demolb.id
  protocol            = "Tcp"
  port                = "80"
  interval_in_seconds = "5"
  number_of_probes    = "2"
}

//Load balancing rule-1
resource "azurerm_lb_rule" "demo_lb_rule_1" {
  name                           = "lb_rule1"
  resource_group_name            = azurerm_resource_group.demoRG.name
  loadbalancer_id                = azurerm_lb.demolb.id
  protocol                       = "tcp"
  frontend_port                  = "80"
  backend_port                   = "80"
  frontend_ip_configuration_name = "mypubip"
  enable_floating_ip             = false
  backend_address_pool_id        = azurerm_lb_backend_address_pool.demoBP.id
  idle_timeout_in_minutes        = 5
  probe_id                       = azurerm_lb_probe.demoprobe.id
}

//Load balancing rule-2
resource "azurerm_lb_rule" "demo_lb_rule_2" {
  name                           = "lb_rule2"
  resource_group_name            = azurerm_resource_group.demoRG.name
  loadbalancer_id                = azurerm_lb.demolb.id
  protocol                       = "tcp"
  frontend_port                  = "5000"
  backend_port                   = "22"
  frontend_ip_configuration_name = "mypubip"
  enable_floating_ip             = false
  backend_address_pool_id        = azurerm_lb_backend_address_pool.demoBP.id
  idle_timeout_in_minutes        = 5
  probe_id                       = azurerm_lb_probe.demoprobe.id
}



