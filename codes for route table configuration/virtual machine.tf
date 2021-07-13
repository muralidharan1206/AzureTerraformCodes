//Virtual machine in Public subnet

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
    computer_name  = "publicVM"
    admin_username = "azureuser"
    admin_password = "admin@123qwe"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

//Virtual machine in Private subnet

resource "azurerm_virtual_machine" "VM2_example" {
    name                  = "VM2"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.example.name
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
    computer_name  = "privateVM"
    admin_username = "azureuser"
    admin_password = "admin@123qwe"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

//Virtual machine for NVA

resource "azurerm_virtual_machine" "VMnva_example" {
  name                  = "VM_nva"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  network_interface_ids = [azurerm_network_interface.NI_nva_example.id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "myosdisk3"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "mynvavm"
    admin_username = "azureuser"
    admin_password = "admin@123qwe"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

}

resource "azurerm_virtual_machine_extension" "enable_routes" {
  name                 = "enable-iptables-routes"
  virtual_machine_id   = azurerm_virtual_machine.VMnva_example.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"


  settings = <<SETTINGS
    {
        "fileUris": [
        "https://raw.githubusercontent.com/mspnp/reference-architectures/master/scripts/linux/enable-ip-forwarding.sh"
        ],
        "commandToExecute": "bash enable-ip-forwarding.sh"
    }
SETTINGS
}