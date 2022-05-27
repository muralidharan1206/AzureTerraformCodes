# PAN mgmt interface
resource "azurerm_subnet" "fwmgmt" {
  name                 = "fwmgmt"
  resource_group_name  = azurerm_resource_group.demoRG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = "10.0.1.0/24"
}

# PAN FW outside
resource "azurerm_subnet" "fwuntrust" {
  name                 = "fwuntrust"
  resource_group_name  = azurerm_resource_group.demoRG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = "10.0.2.0/24"
}

# PAN FW inside
resource "azurerm_subnet" "fwtrust" {
  name                 = "fwtrust"
  resource_group_name  = azurerm_resource_group.demoRG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = "10.0.3.0/24"
}

# private server subnet
# All Internet outbound traffic will be routed to the PAN FW
resource "azurerm_subnet" "private" {
  name                 = "private"
  resource_group_name  = azurerm_resource_group.demoRG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = "10.0.4.0/24"
# Add Azure service endpoints needed in this subnet
  service_endpoints    = [ "Microsoft.Storage" ]
}

# Will be configured with a route table that does not use the PAN FW
# For VMs directly accessed from the Internet
resource "azurerm_subnet" "public" {
  name                 = "public"
  resource_group_name  = azurerm_resource_group.demoRG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = "10.0.5.0/24"
  # Add Azure service endpoints needed in this subnet
  service_endpoints    = [ "Microsoft.Storage" ]

}

# Workstations subnet
# All Internet outbound traffic will be routed to the PAN FW
resource "azurerm_subnet" "vdesktop" {
  name                 = "vdesktop"
  resource_group_name  = azurerm_resource_group.demoRG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = "10.0.6.0/24"
  # Add Azure service endpoints needed in this subnet
  service_endpoints    = [ "Microsoft.Storage" ]
}

# Required by Azure Basiton service
resource "azurerm_subnet" "bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.dmeoRG.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = "10.0.7.0/24"
}

