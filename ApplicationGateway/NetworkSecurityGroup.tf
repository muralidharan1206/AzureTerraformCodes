//Network security group for Bastion VM
resource "azurerm_network_security_group" "bastion_nsg" {
    name                = "bastion-nsg"
    location            = azurerm_resource_group.demoRG.location
    resource_group_name = azurerm_resource_group.demoRG.name

    security_rule {
        name                       = "allow_SSH"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}