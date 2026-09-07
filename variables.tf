variable "project_name" {
  type        = string
  description = "Short project identifier used in resource naming, e.g. 'projecta'."
}

variable "environment" {
  type        = string
  description = "Environment name used in resource naming, e.g. 'dev', 'test', 'prod'."
}

variable "location" {
  type        = string
  default     = "southafricanorth"
  description = "Azure region to deploy into."

  validation {
    condition     = var.location == "southafricanorth"
    error_message = "Only 'southafricanorth' is permitted as the deployment region for this project."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the existing resource group to deploy into."
}

variable "account_tier" {
  type        = string
  default     = "Standard"
  description = "Storage account performance tier."
}

variable "account_replication_type" {
  type        = string
  default     = "LRS"
  description = "Storage account replication type, e.g. LRS, GRS, ZRS."
}

variable "container_name" {
  type        = string
  default     = "syslog-data"
  description = "Name of the storage container used to hold centralized Syslog data streamed via DCR."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Optional tags to apply to the Storage Account."
}