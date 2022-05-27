//Resource Group Name
variable "resource_group_name" {
  default = "LAB-DaaS-EUWE-PaloAlto-RG"
}

//Resource Group Location
variable "resource_group_location" {
  default = "West Europe"
}

//Availability Set Name
variable "Availability_set_name" {
  default = "LAB-DaaS-EUWE-Front-FWL-AS"
}

//Virtual Network Name
variable "virtual_network_name" {
  default = "LAB-DaaS-EUWE-PaloAlto-vNET"
}

//Virtual Network Address
variable "virtual_network_address" {
  default = "172.16.0.0/22"
}

//Management Subnet
variable "Mgmt_subnet_name" {
  default = "LAB-DaaS-EUWE-Management-172.16.0.0_24_sNet"
}

//Management Subnet Address
variable "Mgmt_subnet_address" {
  default = "172.16.0.0/24"
}

//Internet Subnet
variable "Internet_subnet_name" {
  default = "LAB-DaaS-EUWE-Internet-172.16.1.0_24_sNet"
}

//Internet Subnet Address
variable "Internet_subnet_address" {
  default = "172.16.1.0/24"
}

//Trust Subnet name
variable "Trust_subnet_name" {
  default = "LAB-DaaS-EUWE-Trust-172.16.2.0_24_sNet"
}

//Trust Subnet Address
variable "Trust_subnet_address" {
  default = "172.16.2.0/24"
}

//Storage Account name
variable "Storage_account_name" {
    default = "labeuweplatformpa"
}

//Storage Account Tier
variable "Storage_account_tier" {
    default = "Standard"
}

//Storage Account Type
variable "Storage_account_type" {
    default = "LRS"
}

//Storage Account Access
variable "Storage_account_access" {
    default = "true"
}

//Management IP1 name
variable "Mgmt_IP1_name" {
    default = "lab-daas-euwe-front-fwl-pip-mgmt1"
}

//IP Allocation Method
variable "IP_allocation_method" {
    default = "Dynamic"
}

//Management IP2 name
variable "Mgmt_IP2_name" {
    default = "lab-daas-euwe-front-fwl-pip-mgmt2"
}

//Internet IP1 name for Palo 1
variable "Internet_IP1_name" {
    default = "lab-DaaS-EUWE-Front-FWL-PIP-INT1"
}

//Internet IP2 name for Palo 2
variable "Internet_IP2_name" {
    default = "lab-DaaS-EUWE-Front-FWL-PIP-INT2"
}

//Load Balancer IP name
variable "LoadBalancer_IP_name" {
    default = "lab-DaaS-EUWE-Front-ALB-PIP-INT1"
}

//FrontEnd Load Balancer name
variable "Fe_LoadBalancer_name" {
    default = "LAB-DaaS-EUWE-Front-FWL-ALB-Internet"
}

// Load Balancer sku
variable "LoadBalancer_sku" {
    default = "Standard"
}

//FrontEnd Loadbalancer Ip configuration name
variable "Fe_IP_config_name" {
    default = "FeIP"
}

//FrontEnd Loadbalancer Backend Pool name
variable "Fe_BP_name" {
  default = "FeBackendPool"
}

//FrontEnd Loadbalancer Health Probe name
variable "Fe_HP_name" {
  default = "FeHealthProbe"
}

//FrontEnd Loadbalancer Rule name
variable "Fe_LB_Rule_name" {
  default = "FeLBrule"
}

//BackEnd Load Balancer name
variable "Be_LoadBalancer_name" {
    default = "LAB-DaaS-EUWE-Front-FWL-ALB-Trust"
}

//BackEnd Loadbalancer Ip configuration name
variable "Be_IP_config_name" {
    default = "BeIP"
}

//BackEnd Loadbalancer Backend Pool name
variable "Be_BP_name" {
  default = "BeBackendPool"
}

//BackEnd Loadbalancer Health Probe name
variable "Be_HP_name" {
  default = "BeHealthProbe"
}

//BackEnd Loadbalancer Rule name
variable "Be_LB_Rule_name" {
  default = "BeLBrule"
}

//Route Table for Management Subnet
variable "RT1_name" {
  default = "LAB-DaaS-EUWE-PA-Mgmt-UDR"
}

//Route Table for Internet Subnet
variable "RT2_name" {
  default = "LAB-DaaS-EUWE-PA-Internet-UDR"
}

//Route Table for Trust Subnet
variable "RT3_name" {
  default = "LAB-DaaS-EUWE-PA-Trust-UDR"
}

//PermitAll Network Security Group name
variable "PermitAll_NSG_name" {
  default = "LAB-DaaS-EUWE-PA-PermitAll-NSG"
}

//Management Network Security Group name
variable "Mgmt_NSG_name" {
  default = "LAB-DaaS-EUWE-PA-Mgmt-NSG"
}

//PaloAlto 1 VM name
variable "PA1_VM_name" {
  default = "LEUWELIPA01"
}

//PaloAlto VM Size
variable "PA_VM_Size" {
  default = "Standard_D3_v2"
}

//PaloAlto License name
variable "PA_License_name" {
  default = "bundle2"
}

//PaloAlto Publisher
variable "PA_Publisher" {
  default = "paloaltonetworks"
}

//PaloAlto Product
variable "PA_Product" {
  default = "vmseries1"
}

//StorageImageRefference Offer
variable "Offer" {
  default = "vmseries1"
}

//StorageImageRefference sku
variable "sku" {
  default = "bundle2"
}

//StorageImageRefference version
variable "StorageReffVersion" {
  default = "Latest"
}

//Storage OS Disk name
variable "Disk1_name" {
  default = "Storage123"
}

//computer name
variable "Firewall01VmName" {
  default = "PaloAltoVM01"
}

//admin username
variable "username" {
  default = "admin12"
}

//admin password
variable "password" {
  default = "Admin@123qwe"
}

//PaloAlto 1 Management Network Interface
variable "PA_Mgmt_NI1_name" {
  default = "fwl-pip-mgmt1"
}

//PaloAlto 1 Management Ip-config name
variable "PA_Mgmt_NI1_IPconfig_name" {
  default = "fwl-mgmt1"
}

//PaloAlto 2 VM name
variable "PA2_VM_name" {
  default = "LEUWELIPA02"
}

//Storage OS Disk name
variable "Disk2_name" {
  default = "Storage456"
}

//computer name
variable "Firewall02VmName" {
  default = "PaloAltoVM02"
}

//PaloAlto 2 Management Network Interface
variable "PA_Mgmt_NI2_name" {
  default = "fwl-pip-mgmt2"
}

//PaloAlto 2 Management Ip-config name
variable "PA_Mgmt_NI2_IPconfig_name" {
  default = "fwl-mgmt2"
}

//PaloAlto 1 Internet Network Interface
variable "PA_Internet_NI1_name" {
  default = "FWL-PIP-INT1"
}

//PaloAlto 1 Internet Ip-config name
variable "PA_Internet_NI1_IPconfig_name" {
  default = "fwl-Internet1"
}

//PaloAlto 2 Internet Network Interface
variable "PA_Internet_NI2_name" {
  default = "FWL-PIP-INT2"
}

//PaloAlto 2 Internet Ip-config name
variable "PA_Internet_NI2_IPconfig_name" {
  default = "fwl-Internet2"
}

variable "Pb-Lb-IP" {
  default = "PB-LB-name"
}

variable "LB-IP-config-name" {
  default = "LB_IP_Configuration"
}

//mgmt Ip config name
variable "mgmt1_ip_config_name" {
  default = "PAmgmt1_IP_config_name"
}

variable "mgmt2_ip_config_name" {
  default = "PAmgmt2_IP_config_name"
}

//Internet IP config name
variable "internet1_ip_config_name" {
  default = "PAInternet1_IP_config_name"
}

variable "internet2_ip_config_name" {
  default = "PAInternet2_IP_config_name"
}