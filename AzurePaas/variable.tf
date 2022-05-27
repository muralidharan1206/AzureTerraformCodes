variable "resource_group_name" {
  type        = string
  default     = "Paas_rg"
}

variable "location" {
  type        = string
  default     = "eastus"
}

variable "Redis_name" {
  type        = string
  default     = "redis-2021"
}

variable "Redis_capacity" {
  type        = number
  default     = 2
}

variable "Redis_family" {
  type        = string
  default     = "C"
}

variable "Redis_sku" {
  type = string
  default = "Standard"
}

variable "Storage_name" {
  type        = string
  default     = "terraformstorage2022"
}

variable "Storage_Account_Tier" {
  type        = string
  default     = "Standard"
}

variable "Storage_Replication_Type" {
  type        = string
  default     = "LRS"
}

variable "Storage_Account_Kind" {
  type        = string
  default     = "StorageV2"
}

variable "DataLake_name" {
  type        = string
  default     = "example"
}

variable "MySQL_Server_name" {
  type        = string
  default     = "mysql-server-2021"
}

variable "admin_username" {
  type = string
  default = "ae4admin12qwe"
}

variable "admin_password" {
  type = string
  default = "Admin@123qwe"
}

variable "MySQL_Server_sku" {
  type = string
  default = "B_Gen5_1"
}

variable "MySQL_Server_storage" {
  type = number
  default = 102400
}

variable "MySQL_database" {
  type        = string
  default     = "mysql-database-2021"
}

variable "SQL_Server_name" {
  type        = string
  default     = "sql-server-2022"
}

variable "SQL_database" {
  type        = string
  default     = "sql-database-2022"
}

variable "SQL_admin_username" {
  type = string
  default = "ae4admin12qwe"
}

variable "SQL_admin_password" {
  type = string
  default = "j64'9fSZS.)E9X!"
}