//AzureAD Provider
terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "=2.46.0"
    }
  }
}

//User
resource "azuread_user" "example" {
  user_principal_name = "dev@azure010698gmail.onmicrosoft.com"
  display_name        = "developer"
  mail_nickname       = "dev"
  password            = "Admin@123qwe"
}

//group
resource "azuread_group" "example" {
  display_name = "User"
  members = [
    azuread_user.example.object_id,
    /* more users */
  ]
}