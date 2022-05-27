###########################
# NSG For public subnet 
###########################
resource "azurerm_network_security_group" "public" {
  name                = join("", list(var.prefix, "-publicdmz"))
  location            = azurerm_resource_group.demoRG.location
  resource_group_name = azurerm_resource_group.demoRG.name
  
  # Allow traffic from the Internet to port 443 
  security_rule {
    name                       = "Allow-Internet"
    priority                   = 500
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"                               
    destination_address_prefix = "*"
  }

  # Restrict access to the rest of the subnets in the VNET
  security_rule {
    name                       = "Block-VNET"
    priority                   = 1000
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = join("", list(var.IPAddressPrefix, ".0.0/16"))
  }
} 