//provider
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}
provider "azurerm" {
  features {}
}
 
//Resource Group

resource "azurerm_resource_group" "demoRG" {
    name     = "RG1"
    location = "eastus"
}

//storage accont

resource "azurerm_storage_account" "demoSA" {
  name                     = "demostorageaccount1698"
  resource_group_name      = azurerm_resource_group.demoRG.name
  location                 = azurerm_resource_group.demoRG.location
  account_tier             = "Standard"
  account_replication_type = "LRS" //("Local redundant storage" , we can give GRS or ZRS for replication across zones and regions)
  allow_blob_public_access = "true" //(allowing to access public)
}

//container 

resource "azurerm_storage_container" "democontainer" {
  name                  = "container1"
  storage_account_name  = azurerm_storage_account.demoSA.name
  container_access_type = "private"
}

