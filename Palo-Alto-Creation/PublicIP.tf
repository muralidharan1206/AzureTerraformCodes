//Management Address for Palo#1 (LEUWELIPA01)
resource "azurerm_public_ip" "MgmtIP1" {
    name                         = var.Mgmt_IP1_name
    location                     = azurerm_resource_group.PaloAlto.location
    resource_group_name          = azurerm_resource_group.PaloAlto.name
    allocation_method            = var.IP_allocation_method
}

//Management Address for Palo#2 (LEUWELIPA02)
resource "azurerm_public_ip" "MgmtIP2" {
    name                         = var.Mgmt_IP2_name
    location                     = azurerm_resource_group.PaloAlto.location
    resource_group_name          = azurerm_resource_group.PaloAlto.name
    allocation_method            = var.IP_allocation_method
}

//Internet Address for Palo#1 (LEUWELIPA01)
resource "azurerm_public_ip" "Internet1" {
    name                         = var.Internet_IP1_name
    location                     = azurerm_resource_group.PaloAlto.location
    resource_group_name          = azurerm_resource_group.PaloAlto.name
    allocation_method            = var.IP_allocation_method
}

//Internet Address for Palo#2 (LEUWELIPA02)
resource "azurerm_public_ip" "Internet2" {
    name                         = var.Internet_IP2_name
    location                     = azurerm_resource_group.PaloAlto.location
    resource_group_name          = azurerm_resource_group.PaloAlto.name
    allocation_method            = var.IP_allocation_method
}

//Internet Address for FrontEnd LoadBalancer
resource "azurerm_public_ip" "LBIP" {
    name                         = var.LoadBalancer_IP_name
    location                     = azurerm_resource_group.PaloAlto.location
    resource_group_name          = azurerm_resource_group.PaloAlto.name
    allocation_method            = "Static"
    
}
