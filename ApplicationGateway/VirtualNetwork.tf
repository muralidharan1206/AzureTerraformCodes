//Virtual network
resource "azurerm_virtual_network" "vnet" {
    name                = "Vnet1"
    location            = azurerm_resource_group.demoRG.location
    address_space       = ["10.254.0.0/16"]
    resource_group_name = azurerm_resource_group.demoRG.name
}

//Subnet1
resource "azurerm_subnet" "subnet1" {
    name                 = "subnet1"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.demoRG.name
    address_prefixes       = ["10.254.0.0/24"]
}

//Subnet2
resource "azurerm_subnet" "subnet2" {
    name                 = "subnet2"
    virtual_network_name = azurerm_virtual_network.vnet.name
    resource_group_name  = azurerm_resource_group.demoRG.name
    address_prefixes       = ["10.254.1.0/24"]
}