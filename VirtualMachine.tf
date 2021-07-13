//VM-1
resource "azurerm_linux_virtual_machine" "demoVM-1" {
    name                  = "VM1"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.demoRG.name
    network_interface_ids = [azurerm_network_interface.demoNI-1.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "StandardSSD_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "myvm"
    admin_username = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "azureuser"
        public_key     = file("~/.ssh/id_rsa.pub")
    }
}

//VM-2
resource "azurerm_linux_virtual_machine" "demoVM-2" {
    name                  = "VM2"
    location              = "eastus"
    resource_group_name   = azurerm_resource_group.demoRG.name
    network_interface_ids = [azurerm_network_interface.demoNI-2.id]
    size                  = "Standard_DS1_v2"

    os_disk {
        name              = "myOsDisk"
        caching           = "ReadWrite"
        storage_account_type = "StandardSSD_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name  = "myvm"
    admin_username = "azureuser"
    disable_password_authentication = true

    admin_ssh_key {
        username       = "azureuser"
        public_key     = file("~/.ssh/id_rsa.pub")
    }
}