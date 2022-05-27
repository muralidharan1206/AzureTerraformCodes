
//Virtual Network
resource "azurerm_virtual_network" "example" {
    name                = "Vnet1"
    address_space       = ["10.0.0.0/18"]
    location            = "eastus"
    resource_group_name = azurerm_resource_group.example.name
}

//Public subnet
resource "azurerm_subnet" "Public_example" {
    name                 = "Public_subnet"
    resource_group_name  = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.example.name
    address_prefixes       = ["10.0.0.0/24"]
}

//Private subnet
resource "azurerm_subnet" "Private_example" {
    name                 = "Private_subnet"
    resource_group_name  = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.example.name
    address_prefixes       = ["10.0.16.0/20"]
}

//NVA subnet
resource "azurerm_subnet" "NVA_example" {
    name                 = "NVA_subnet"
    resource_group_name  = azurerm_resource_group.example.name
    virtual_network_name = azurerm_virtual_network.example.name
    address_prefixes       = ["10.0.32.0/24"]
}
