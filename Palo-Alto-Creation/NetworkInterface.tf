//Network Interface for Management PaloAlto 1
resource "azurerm_network_interface" "PAmgmt1" {
    name                        = var.PA_Mgmt_NI1_name
    location                    = azurerm_resource_group.PaloAlto.location
    resource_group_name         = azurerm_resource_group.PaloAlto.name

    ip_configuration {
        name                          = var.mgmt1_ip_config_name
        subnet_id                     = azurerm_subnet.Mgmt.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.MgmtIP1.id
    }
}

//Network Interface for Management PaloAlto 2 
resource "azurerm_network_interface" "PAmgmt2" {
    name                        = var.PA_Mgmt_NI2_name
    location                    = azurerm_resource_group.PaloAlto.location
    resource_group_name         = azurerm_resource_group.PaloAlto.name

    ip_configuration {
        name                          = var.mgmt2_ip_config_name
        subnet_id                     = azurerm_subnet.Mgmt.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.MgmtIP2.id
    }
}


//Network Interface for Internet PaloAlto 1
resource "azurerm_network_interface" "PAInternet1" {
    name                        = var.PA_Internet_NI1_name
    location                    = azurerm_resource_group.PaloAlto.location
    resource_group_name         = azurerm_resource_group.PaloAlto.name

    ip_configuration {
        name                          = var.internet1_ip_config_name
        subnet_id                     = azurerm_subnet.Internet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.Internet1.id
    }
}

//Network Interface for Internet PaloAlto 2 
resource "azurerm_network_interface" "PAInternet2" {
    name                        = var.PA_Internet_NI2_name
    location                    = azurerm_resource_group.PaloAlto.location
    resource_group_name         = azurerm_resource_group.PaloAlto.name

    ip_configuration {
        name                          = var.internet2_ip_config_name
        subnet_id                     = azurerm_subnet.Internet.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.Internet2.id
    }
}

//Network Interface for Trust subnet Private Ip
resource "azurerm_network_interface" "PATrustLB" {
  name                = "PrivateTrust_NI"
  location            = azurerm_resource_group.PaloAlto.location
  resource_group_name = azurerm_resource_group.PaloAlto.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Trust.id
    private_ip_address_allocation = "Static"
    private_ip_address = "172.16.2.6"
    
  }
}