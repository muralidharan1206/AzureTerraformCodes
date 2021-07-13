//Network Interface for public subnet
resource "azurerm_network_interface" "NI1_example" {
    name                        = "NI1"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.example.name

    ip_configuration {
        name                          = "PublicNicConfiguration"
        subnet_id                     = azurerm_subnet.Public_example.id
        private_ip_address_allocation = "Static"
        public_ip_address_id          = azurerm_public_ip.example.id
		private_ip_address			  = "10.0.0.4"
    }
}

//public address
resource "azurerm_public_ip" "example" {
    name                         = "PubIP1"
    location                     = "eastus"
    resource_group_name          = azurerm_resource_group.example.name
    allocation_method            = "Static"
}

//Network Interface for private subnet
resource "azurerm_network_interface" "NI2_example" {
    name                        = "NI2"
    location                    = "eastus"
    resource_group_name         = azurerm_resource_group.example.name

    ip_configuration {
        name                          = "PrivateNicConfiguration"
        subnet_id                     = azurerm_subnet.Private_example.id
        private_ip_address_allocation = "Static"
		private_ip_address 			  = "10.0.16.4"
    }
}

resource "azurerm_network_interface" "NI_nva_example" {
  name                 = "nva"
  location             = azurerm_resource_group.example.location
  resource_group_name  = azurerm_resource_group.example.name
  enable_ip_forwarding = true

  ip_configuration {
    name                          = "nvaConfiguration"
    subnet_id                     = azurerm_subnet.NVA_example.id
    private_ip_address_allocation = "Static"
	private_ip_address 			  = "10.0.32.4"
  }
}