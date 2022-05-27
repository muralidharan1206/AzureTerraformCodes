variable "resource_group_name" {
  type        = string
  default     = "aks_terraform_rg"
}

variable "location" {
  type        = string
  default     = "eastus"
}

variable "cluster_name" {
  type        = string
  default     = "terraform-aks"
}

variable "node_resource_group" {
  type        = string
  default     = "aks_terraform_resources_rg"
}

variable "os_disk_size_gb" {
  description = "Disk size of nodes in GBs."
  type        = number
  default     = 32
}

variable "agents_max_count" {
  type        = number
  description = "Maximum number of nodes in a pool"
  default     = 3
}

variable "agents_min_count" {
  type        = number
  description = "Minimum number of nodes in a pool"
  default     = 1
}

variable "kubernetes_version" {
  type        = string
  default     = "1.22.2"
}

variable "system_node_count" {
  type        = number
  default     = 4
}