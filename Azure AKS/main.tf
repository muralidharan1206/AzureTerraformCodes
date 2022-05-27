resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.cluster_name
  kubernetes_version  = var.kubernetes_version
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.cluster_name
  node_resource_group = var.node_resource_group

  default_node_pool {
    name                = "system"
    node_count          = var.system_node_count
    os_type             = "linux"
    vm_size             = "Standard_D8S_v4"
    os_disk_size_gb     = var.os_disk_size_gb
    type                = "VirtualMachineScaleSets"
    max_count           = var.agents_max_count
    min_count           = var.agents_min_count
    enable_auto_scaling = true
  }

identity {
    type = "SystemAssigned"
  }

network_profile {
    load_balancer_sku = "Standard"
    network_plugin    = "kubenet"
  }
}