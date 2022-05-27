//Virtual machine in private subnet
resource "azurerm_linux_virtual_machine" "vm" {
    name                  = "VM1"
    location              = azurerm_resource_group.demoRG.location
    resource_group_name   = azurerm_resource_group.demoRG.name
    size               = "Standard_DS1_v2"
    network_interface_ids = [azurerm_network_interface.nic.id]
    admin_username      = "adminuser"
    admin_password      = "Password1234!"
    disable_password_authentication = false

    connection {
        type                = "ssh"
        bastion_host        = azurerm_public_ip.bastion_pip.fqdn
        bastion_user        = "admin"
        bastion_private_key = "/home/ubuntu/.ssh/id_rsa"
        host                = "${element(azurerm_network_interface.nic.*.private_ip_address,1)}"
        user                = "ubuntu"
        private_key         = "/home/ubuntu/.ssh/id_rsa"
    }

    os_disk {
        name              = "osdisk1"
        storage_account_type = "Standard_LRS"
        caching           = "ReadWrite"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    provisioner "remote-exec" {
        inline = ["sudo apt-get update && sudo apt-get install nginx -y"]
    }
}

//Virtual machine for Bastion Host
resource "azurerm_linux_virtual_machine" "bastion" {
    name                  = "bastion"
    location              = azurerm_resource_group.demoRG.location
    resource_group_name   = azurerm_resource_group.demoRG.name
    size               = "Standard_DS1_v2"
    network_interface_ids = [azurerm_network_interface.bastion_nic.id]
    admin_username      = "adminuser"
    admin_password      = "Password1234!"
    disable_password_authentication = false

    os_disk {
        name              = "bastion-osdisk"
        caching           = "ReadWrite"
        storage_account_type = "StandardSSD_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }
}