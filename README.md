# stw-tf-storage-account

Single-responsibility Terraform module that creates an Azure Storage Account
and a Storage Container. This is the centralized destination that VM Syslog
data streams to via the Monitoring (DCR) module, per Stewardship's Security
Team mandate.

## Scope

Creates:

- The Storage Account
- A Storage Container inside it

## Naming — worked example

Storage Account names can't contain hyphens and are capped at 24 characters
(Azure platform constraint), so the standard convention is applied first,
then sanitised:

project_name = "projecta", environment = "prod":