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

//Virtual Network Peering

resource "azurerm_virtual_network" "Vnet1" {
  name                = "MyVnet1"
  resource_group_name = azurerm_resource_group.demoRG.name
  address_space       = ["10.0.1.0/24"]
  location            = "eastus"
}

resource "azurerm_subnet" "demosubnet-Vnet1" {
    name                 = "subnet1"
    resource_group_name  = azurerm_resource_group.demoRG.name
    virtual_network_name = azurerm_virtual_network.Vnet1.name
    address_prefixes       = ["10.0.1.1/24"]
}

resource "azurerm_virtual_network" "Vnet2" {
  name                = "MyVnet2"
  resource_group_name = azurerm_resource_group.demoRG.name
  address_space       = ["10.0.2.0/24"]
  location            = "eastus"
}

resource "azurerm_subnet" "demosubnet-Vnet2" {
    name                 = "subnet2"
    resource_group_name  = azurerm_resource_group.demoRG.name
    virtual_network_name = azurerm_virtual_network.Vnet2.name
    address_prefixes       = ["10.0.2.1/24"]
}

resource "azurerm_virtual_network_peering" "peering1" {
  name                      = "peer1to2"
  resource_group_name       = azurerm_resource_group.demoRG.name
  virtual_network_name      = azurerm_virtual_network.Vnet1.name
  remote_virtual_network_id = azurerm_virtual_network.Vnet2.id
}

resource "azurerm_virtual_network_peering" "peering2" {
  name                      = "peer2to1"
  resource_group_name       = azurerm_resource_group.demoRG.name
  virtual_network_name      = azurerm_virtual_network.Vnet2.name
  remote_virtual_network_id = azurerm_virtual_network.Vnet1.id
}
