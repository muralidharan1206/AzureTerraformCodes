//virtual machine for subnet1 on Vnet1
resource "azurerm_virtual_machine" "VM1_example" {
    name                  = "VM1"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.example.name
    network_interface_ids = [azurerm_network_interface.NI1_example.id]
    vm_size                  = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk { 
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "VM01"
    admin_username = "azureuser"
    admin_password = "admin@123qwe"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

//virtual machine for subnet1 on Vnet2
resource "azurerm_virtual_machine" "VM2_example" {
    name                  = "VM2"
    location              = "westus"
    resource_group_name   = azurerm_resource_group.example1.name
    network_interface_ids = [azurerm_network_interface.NI2_example.id]
    vm_size                  = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk2"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "VM02"
    admin_username = "azureuser"
    admin_password = "admin@123qwe"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}