//Network Interface for subnet1
resource "azurerm_network_interface" "NI1_example" {
    name                        = "NI1"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.example.name

    ip_configuration {
        name                          = "PublicNicConfiguration"
        subnet_id                     = azurerm_subnet.Subnet1_example.id
        private_ip_address_allocation = "Static"
        public_ip_address_id          = azurerm_public_ip.pip1_example.id
		private_ip_address			  = "10.1.0.4"
    }
}

//public address
resource "azurerm_public_ip" "pip1_example" {
    name                         = "pip1"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.example.name
    allocation_method            = "Static"
}

//Network Interface for subnet2
resource "azurerm_network_interface" "NI2_example" {
    name                        = "NI2"
    location                    = "westus"
    resource_group_name         = azurerm_resource_group.example1.name

    ip_configuration {
        name                          = "PublicNicConfiguration1"
        subnet_id                     = azurerm_subnet.Subnet2_example.id
        private_ip_address_allocation = "Static"
        public_ip_address_id          = azurerm_public_ip.pip2_example.id
		private_ip_address			  = "10.41.0.4"
    }
}

//public address
resource "azurerm_public_ip" "pip2_example" {
    name                         = "pip2"
    location                     = "westus"
    resource_group_name          = azurerm_resource_group.example1.name
    allocation_method            = "Static"
}