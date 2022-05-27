//To associate Network Interface and Security group
resource "azurerm_network_interface_security_group_association" "NSG_asso1" {
  network_interface_id      = azurerm_network_interface.demoNI_1.id
  network_security_group_id = azurerm_network_security_group.demoNSG.id
}

  resource "azurerm_network_interface_security_group_association" "NSG_asso2" {
  network_interface_id      = azurerm_network_interface.demoNI_2.id
  network_security_group_id = azurerm_network_security_group.demoNSG.id
}