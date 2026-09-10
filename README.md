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
`stprojectaprodsouthafricanorth`

The Storage Container supports hyphens normally and defaults to
`syslog-data`, fully configurable via `container_name`.

## Usage

```hcl
module "storage_account" {
  source = "github.com/azimkayz/stw-tf-storage-account?ref=v1.0.0"

  project_name         = "projecta"
  environment          = "prod"
  resource_group_name  = module.resource_group.resource_group_name
  container_name       = "syslog-data"
}
```

## Requirements

| Name      | Version  |
|-----------|----------|
| terraform | >= 1.5.0 |
| azurerm   | ~> 5.4.0   |

## Inputs

| Name                      | Type        | Default          | Required | Description                       |
|---------------------------|-------------|------------------|----------|-------------------------------------|
| project_name              | string      | n/a              | yes      | Short project identifier for naming |
| environment               | string      | n/a              | yes      | Environment name for naming         |
| location                  | string      | southafricanorth | no       | Azure region (validated)            |
| resource_group_name       | string      | n/a              | yes      | Existing resource group             |
| account_tier              | string      | Standard         | no       | Storage account performance tier    |
| account_replication_type  | string      | LRS              | no       | Replication type                    |
| container_name            | string      | syslog-data      | no       | Name of the storage container       |
| tags                      | map(string) | {}               | no       | Additional tags                     |

## Outputs

| Name                    | Description                                          |
|-------------------------|---------------------------------------------------------|
| storage_account_id      | Resource ID — consumed by the Monitoring module           |
| storage_account_name    | Generated (sanitised) name of the Storage Account          |
| storage_container_name  | Container name — consumed by the Monitoring module          |

## Versioning

Tagged `v1.0.0`. Consumers should pin to a tag, not a branch.