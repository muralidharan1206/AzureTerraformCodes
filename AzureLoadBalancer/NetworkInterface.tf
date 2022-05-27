//Network interface for virtual machine-1
resource "azurerm_network_interface" "demoNI_1" {
    name                        = "NI1"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.demoRG.name

    ip_configuration {
        name                          = "myNicConfiguration-1"
        subnet_id                     = azurerm_subnet.demosubnet_Vnet1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.demo_pub_ip_NI1.id
    }
}


//Network Interface for virtual machine-2
resource "azurerm_network_interface" "demoNI_2" {
    name                        = "NI2"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.demoRG.name

    ip_configuration {
        name                          = "myNicConfiguration-2"
        subnet_id                     = azurerm_subnet.demosubnet_Vnet1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.demo_pub_ip_NI2.id
    }
}