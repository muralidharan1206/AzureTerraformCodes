//Network Interface -1

resource "azurerm_network_interface" "demoNI-1" {
    name                        = "NI1"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.demoRG.name

    ip_configuration {
        name                          = "myNicConfiguration-1"
        subnet_id                     = azurerm_subnet.demosubnet-Vnet1.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.demoPubIP-1.id
    }
}

//Network Interface -2

resource "azurerm_network_interface" "demoNI-2" {
    name                        = "NI2"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.demoRG.name

    ip_configuration {
        name                          = "myNicConfiguration-2"
        subnet_id                     = azurerm_subnet.demosubnet-Vnet2.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.demoPubIP-2.id
    }
}

//publicIP-1
resource "azurerm_public_ip" "demoPubIP-1" {
    name                         = "PubIP1"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.demoRG.name
    allocation_method            = "Dynamic"
}

//publicIP-2
resource "azurerm_public_ip" "demoPubIP-2" {
    name                         = "PubIP2"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.demoRG.name
    allocation_method            = "Dynamic"
}