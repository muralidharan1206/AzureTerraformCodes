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