//NSG for Internet/Trust Subnet
resource "azurerm_network_security_group" "PaloAlto1" {
    name                = var.PermitAll_NSG_name
    location            = azurerm_resource_group.PaloAlto.location
    resource_group_name = azurerm_resource_group.PaloAlto.name
//Any to Any [This is for Frontend loadbalancer]
    security_rule {
        name                       = "AllowAllInbound"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

//Associate Internet IP for paloalto1 to the Network Security group
resource "azurerm_network_interface_security_group_association" "NSG_mgmt_association1" {
  network_interface_id      = azurerm_network_interface.PAInternet1.id
  network_security_group_id = azurerm_network_security_group.PaloAlto2.id
}

//Associate Internet IP for paloalto1 to the Network Security group
resource "azurerm_network_interface_security_group_association" "NSG_mgmt_association2" {
  network_interface_id      = azurerm_network_interface.PAInternet2.id
  network_security_group_id = azurerm_network_security_group.PaloAlto2.id
}

//Associate Trust IP to the Network Security group
resource "azurerm_network_interface_security_group_association" "NSG_mgmt_association3" {
  network_interface_id      = azurerm_network_interface.PATrustLB.id
  network_security_group_id = azurerm_network_security_group.PaloAlto1.id
}

//NSG for Management Subnet
resource "azurerm_network_security_group" "PaloAlto2" {
    name                = var.Mgmt_NSG_name
    location            = azurerm_resource_group.PaloAlto.location
    resource_group_name = azurerm_resource_group.PaloAlto.name

//Allowing the Incomming traffic to the management subnet
//The person who is in the management subnet and he's accessing the paloalto virtual machine via HTTPS & SSH
    security_rule {
        name                       = "AllowHTTPSInbound"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "443"
        destination_port_range     = "443"
        source_address_prefix      = "172.16.0.0/24"
        destination_address_prefix = "*"
    }

        security_rule {
        name                       = "AllowSSHInbound"
        priority                   = 110
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "TCP"
        source_port_range          = "22"
        destination_port_range     = "22"
        source_address_prefix      = "172.16.0.0/24"
        destination_address_prefix = "*"
    }

        security_rule {
        name                       = "AllowAllInbound"
        priority                   = 120
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        destination_port_range     = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

//Associate management IP for paloalto1 to the Network Security group
resource "azurerm_network_interface_security_group_association" "NSG_mgmt_association11" {
  network_interface_id      = azurerm_network_interface.PAmgmt1.id
  network_security_group_id = azurerm_network_security_group.PaloAlto2.id
}
//Associate management IP for paloalto2 to the Network Security group
resource "azurerm_network_interface_security_group_association" "NSG_mgmt_association12" {
  network_interface_id      = azurerm_network_interface.PAmgmt2.id
  network_security_group_id = azurerm_network_security_group.PaloAlto2.id
}