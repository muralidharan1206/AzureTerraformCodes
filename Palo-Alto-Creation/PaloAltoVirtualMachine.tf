//PaloALto 1
resource "azurerm_virtual_machine" "PAN_FW_FW_1" {
  name                  = var.PA1_VM_name
  location              = azurerm_resource_group.PaloAlto.location
  resource_group_name   = azurerm_resource_group.PaloAlto.name
  primary_network_interface_id = azurerm_network_interface.PAInternet1.id
  network_interface_ids = [azurerm_network_interface.PAmgmt1.id] 
  # The ARM templates for PAN OS VM use specific machine size - using same here
  vm_size               = var.PA_VM_Size
  availability_set_id = azurerm_availability_set.PaloAlto.id
  
  plan {
    # Using a pay as you go license set sku to "bundle2"
    # To use a purchased license change sku to "byol"
    name      = var.PA_License_name
    publisher = var.PA_Publisher
    product   = var.PA_Product
  }

  storage_image_reference {
    publisher = var.PA_Publisher
    offer     = var.Offer
    # Using a pay as you go license set sku to "bundle2"
    # To use a purchased license change sku to "byol"
    sku       = var.sku
    version   = var.StorageReffVersion
  }

  storage_os_disk {
    name          = var.Disk1_name
    caching       = "ReadWrite" 
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = var.Firewall01VmName
    admin_username = var.username
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}


//PaloALto 2
resource "azurerm_virtual_machine" "PAN_FW_FW_2" {
  name                  = var.PA2_VM_name
  location              = azurerm_resource_group.PaloAlto.location
  resource_group_name   = azurerm_resource_group.PaloAlto.name
  primary_network_interface_id = azurerm_network_interface.PAInternet2.id
  network_interface_ids = [azurerm_network_interface.PAmgmt2.id] 
  # The ARM templates for PAN OS VM use specific machine size - using same here
  vm_size               = var.PA_VM_Size
  availability_set_id = azurerm_availability_set.PaloAlto.id
  
  plan {
    # Using a pay as you go license set sku to "bundle2"
    # To use a purchased license change sku to "byol"
    name      = var.PA_License_name
    publisher = var.PA_Publisher
    product   = var.PA_Product
  }

  storage_image_reference {
    publisher = var.PA_Publisher
    offer     = var.Offer
    # Using a pay as you go license set sku to "bundle2"
    # To use a purchased license change sku to "byol"
    sku       = var.sku
    version   = var.StorageReffVersion
  }

  storage_os_disk {
    name          = var.Disk2_name
    caching       = "ReadWrite" 
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = var.Firewall02VmName
    admin_username = var.username
    admin_password = var.password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}
