//Virtual Network
resource "azurerm_virtual_network" "Vnet" {
    name                = var.virtual_network_name
    address_space       = [var.virtual_network_address]
    location            = azurerm_resource_group.PaloAlto.location
    resource_group_name = azurerm_resource_group.PaloAlto.name
}

//Management Subnet
resource "azurerm_subnet" "Mgmt" {
    name                 = var.Mgmt_subnet_name
    resource_group_name  = azurerm_resource_group.PaloAlto.name
    virtual_network_name = azurerm_virtual_network.Vnet.name
    address_prefixes       = [var.Mgmt_subnet_address]
}

//Internet Subnet
resource "azurerm_subnet" "Internet" {
    name                 = var.Internet_subnet_name
    resource_group_name  = azurerm_resource_group.PaloAlto.name
    virtual_network_name = azurerm_virtual_network.Vnet.name
    address_prefixes       = [var.Internet_subnet_address]
}

//Trust Subnet
resource "azurerm_subnet" "Trust" {
    name                 = var.Trust_subnet_name
    resource_group_name  = azurerm_resource_group.PaloAlto.name
    virtual_network_name = azurerm_virtual_network.Vnet.name
    address_prefixes       = [var.Trust_subnet_address]
}