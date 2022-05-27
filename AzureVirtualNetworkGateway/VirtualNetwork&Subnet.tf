//Virtual Network 1
resource "azurerm_virtual_network" "Vnet1_example" {
    name                = "Vnet1"
    address_space       = ["10.1.0.0/16"]
    location            = "eastus"
    resource_group_name = azurerm_resource_group.example.name
}

//subnet1
resource "azurerm_subnet" "Subnet1_example" {
    name                 = "subnet1"
    resource_group_name  = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.Vnet1_example.name
    address_prefixes       = ["10.1.0.0/24"]
}

//Virtual Network 2
resource "azurerm_virtual_network" "Vnet2_example" {
    name                = "Vnet2"
    address_space       = ["10.41.0.0/16"]
    location            = "westus"
    resource_group_name = azurerm_resource_group.example1.name
}

//subnet2
resource "azurerm_subnet" "Subnet2_example" {
    name                 = "subnet2"
    resource_group_name  = azurerm_resource_group.example1.name
    virtual_network_name = azurerm_virtual_network.Vnet2_example.name
    address_prefixes       = ["10.41.0.0/24"]
}