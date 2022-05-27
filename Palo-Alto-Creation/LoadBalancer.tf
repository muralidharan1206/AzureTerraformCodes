//Front End LoadBalancer for Inbound
resource "azurerm_lb" "FeLB" {
  name                = var.Fe_LoadBalancer_name
  resource_group_name = azurerm_resource_group.PaloAlto.name
  location            = azurerm_resource_group.PaloAlto.location
  sku                 = "Basic"

  frontend_ip_configuration {
    name                          = var.Fe_IP_config_name
    public_ip_address_id          = azurerm_public_ip.LBIP.id
  }
}

//Backend Pool
resource "azurerm_lb_backend_address_pool" "FeBP" {
  name                = var.Fe_BP_name
  loadbalancer_id     = azurerm_lb.FeLB.id
}

//Health Probe
resource "azurerm_lb_probe" "FeHP" {
  name                = var.Fe_HP_name
  resource_group_name = azurerm_resource_group.PaloAlto.name
  loadbalancer_id     = azurerm_lb.FeLB.id
  protocol            = "Tcp"
  port                = "80"
  interval_in_seconds = "5"
  number_of_probes    = "2"
}

//Load balancing rule
resource "azurerm_lb_rule" "FeLB-R" {
  name                           = var.Fe_LB_Rule_name
  resource_group_name            = azurerm_resource_group.PaloAlto.name
  loadbalancer_id                = azurerm_lb.FeLB.id
  protocol                       = "tcp"
  frontend_port                  = "80"
  backend_port                   = "80"
  frontend_ip_configuration_name = var.Fe_IP_config_name
  enable_floating_ip             = false
  backend_address_pool_id        = azurerm_lb_backend_address_pool.FeBP.id
  idle_timeout_in_minutes        = 5
  probe_id                       = azurerm_lb_probe.FeHP.id
}


//To associate Internet Network Interface and Backend addres pool
resource "azurerm_network_interface_backend_address_pool_association" "FeLB_Asso1" {
      network_interface_id    = azurerm_network_interface.PAInternet1.id
      ip_configuration_name   = var.internet1_ip_config_name
      backend_address_pool_id = azurerm_lb_backend_address_pool.FeBP.id
    }


//To associate Internet Network Interface and Backend addres pool
resource "azurerm_network_interface_backend_address_pool_association" "FeLB_Asso2" {
      network_interface_id    = azurerm_network_interface.PAInternet2.id
      ip_configuration_name   = var.internet2_ip_config_name
      backend_address_pool_id = azurerm_lb_backend_address_pool.FeBP.id
    }



//Back End LoadBalancer for Outbound
resource "azurerm_lb" "BeLB" {
  name                = var.Be_LoadBalancer_name
  resource_group_name = azurerm_resource_group.PaloAlto.name
  location            = azurerm_resource_group.PaloAlto.location
  sku                 = "Basic"

  frontend_ip_configuration {
    name                = var.Be_IP_config_name
    subnet_id = azurerm_subnet.Trust.id
  }
}

//Backend Pool
resource "azurerm_lb_backend_address_pool" "BeBP" {
  name                = var.Be_BP_name
  loadbalancer_id     = azurerm_lb.BeLB.id
}

//Health Probe
resource "azurerm_lb_probe" "BeHP" {
  name                = var.Be_HP_name
  resource_group_name = azurerm_resource_group.PaloAlto.name
  loadbalancer_id     = azurerm_lb.BeLB.id
  protocol            = "Tcp"
  port                = "80"
  interval_in_seconds = "5"
  number_of_probes    = "2"
}

//Load balancing rule
resource "azurerm_lb_rule" "BeLB-R" {
  name                           = var.Be_LB_Rule_name
  resource_group_name            = azurerm_resource_group.PaloAlto.name
  loadbalancer_id                = azurerm_lb.BeLB.id
  protocol                       = "tcp"
  frontend_port                  = "80"
  backend_port                   = "80"
  frontend_ip_configuration_name = var.Be_IP_config_name
  enable_floating_ip             = false
  backend_address_pool_id        = azurerm_lb_backend_address_pool.BeBP.id
  idle_timeout_in_minutes        = 5
  probe_id                       = azurerm_lb_probe.BeHP.id
}

//To associate Management Network Interface and Backend addres pool
resource "azurerm_network_interface_backend_address_pool_association" "BeLB_Asso1" {
      network_interface_id    = azurerm_network_interface.PAmgmt1.id
      ip_configuration_name   = var.mgmt1_ip_config_name
      backend_address_pool_id = azurerm_lb_backend_address_pool.BeBP.id
    }

//To associate Management Network Interface and Backend addres pool
resource "azurerm_network_interface_backend_address_pool_association" "BeLB_Asso2" {
      network_interface_id    = azurerm_network_interface.PAmgmt2.id
      ip_configuration_name   = var.mgmt2_ip_config_name
      backend_address_pool_id = azurerm_lb_backend_address_pool.BeBP.id
    }

