terraform {
  required_version = ">= 1.5.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }
}

provider "azurerm" {
  features {}
}

module "storage_account" {
  source = "../../"

  project_name         = "projecta"
  environment          = "dev"
  resource_group_name  = "rg-projecta-dev-southafricanorth"
  container_name       = "syslog-data"
}

output "storage_account_id" {
  value = module.storage_account.storage_account_id
}

output "storage_container_name" {
  value = module.storage_account.storage_container_name
}