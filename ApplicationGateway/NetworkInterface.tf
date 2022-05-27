//Network interface for VM in private subnet
resource "azurerm_network_interface" "nic" {
    name                = "nic"
    location            = azurerm_resource_group.demoRG.location
    resource_group_name = azurerm_resource_group.demoRG.name

    ip_configuration {
        name                          = "ipconfig"
        subnet_id                     = azurerm_subnet.subnet2.id
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.254.1.4"
    }
}

//Network interface for Bastion VM

resource "azurerm_network_interface" "bastion_nic" {
    name                      = "bastion-nic"
    location                  = "eastus"
    resource_group_name       = azurerm_resource_group.demoRG.name

    ip_configuration {
        name                          = "bastion-ipconfig"
        subnet_id                     = azurerm_subnet.subnet2.id
        private_ip_address_allocation = "Static"
        private_ip_address            = "10.254.1.5"
        public_ip_address_id          = azurerm_public_ip.bastion_pip.id
    }
}

//publicIP for bastion network interface

# Bastion Host
resource "azurerm_public_ip" "bastion_pip" {
    name                         = "bastion-pip"
    resource_group_name          = azurerm_resource_group.demoRG.name
    location                     = azurerm_resource_group.demoRG.location
    allocation_method            = "Dynamic"
}