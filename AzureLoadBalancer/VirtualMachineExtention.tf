//virtual machine extension for vm-1
resource "azurerm_virtual_machine_extension" "vm_extension" {
  name = "vm_extension"
  virtual_machine_id = azurerm_linux_virtual_machine.demoVM-1.id
  publisher = "Microsoft.Azure.Extensions"
  type = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
        {
          "commandToExecute" : "apt-get -y update && apt-get install -y apache2" 
        }
        SETTINGS
}

//virtaual machine extension for vm-2
resource "azurerm_virtual_machine_extension" "vm_extension-1" {
  name = "vm_extension-1"
  virtual_machine_id = azurerm_linux_virtual_machine.demoVM-2.id
  publisher = "Microsoft.Azure.Extensions"
  type = "CustomScript"
  type_handler_version = "2.0"

  settings = <<SETTINGS
        {
          "commandToExecute" : "apt-get -y update && apt-get install -y apache2" 
        }
        SETTINGS
}