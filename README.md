# terraform-azurerm-storage-account

Creates the centralized Storage Account and container that VM Syslog data is streamed into via the `monitoring-dcr` module's Data Collection Rule, as mandated by the Security Team.

## Scope

**Creates**
- One `azurerm_storage_account`
- One `azurerm_storage_container` (the syslog container)

**Does not create**
- The Data Collection Rule that streams data into this container — owned by the `monitoring-dcr` module, which takes this module's `storage_account_id` and `container_name` as inputs
- Any lifecycle management, private endpoints, or network rules on the storage account — not currently modelled on this platform

## Usage

```hcl
module "storage_account" {
  source = "github.com/azimkayz/terraform-azurerm-storage-account?ref=v1.0.0"

  project_name         = "stw"
  environment          = "prod"
  location             = "southafricanorth"
  resource_group_name  = module.resource_group.resource_group_name
}
```

A minimal, runnable example is in [`examples/basic`](./examples/basic).

## Naming

Patterns:
- Storage account: `st<project_name><environment><location>` — hyphens stripped, lowercased, and truncated to 24 characters to satisfy Azure's storage-account naming rules (alphanumeric only, globally unique, ≤ 24 chars)
- Container: `con-syslog-<project_name>-<environment>-<location>`

Example: `ststwprodsouthafrica` / `con-syslog-stw-prod-southafricanorth`

Because the storage account name must be globally unique, a name generated from these inputs is not guaranteed to be available — if `terraform apply` reports the name is taken, change `project_name` or `environment`.

`location` is validated to accept only `southafricanorth` — no other Azure region is permitted on this platform.

## Inputs

| Name | Type | Required | Default | Description |
|---|---|---|---|---|
| `project_name` | `string` | Yes | – | Short project name used to build resource names. |
| `environment` | `string` | Yes | – | Environment name, e.g. `dev`, `test`, `prod`. |
| `location` | `string` | No | `"southafricanorth"` | Azure region. Validated to reject every value except `southafricanorth`. |
| `resource_group_name` | `string` | Yes | – | Resource group the Storage Account is deployed into. |
| `account_tier` | `string` | No | `"Standard"` | Storage account performance tier. |
| `account_replication_type` | `string` | No | `"LRS"` | Storage account replication type. |
| `container_access_type` | `string` | No | `"private"` | Access level of the syslog container. |
| `tags` | `map(string)` | No | `{}` | Common tags applied to the Storage Account. |

## Outputs

| Name | Description | Consumed by |
|---|---|---|
| `storage_account_id` | Resource ID of the Storage Account. | `monitoring-dcr` module — set as the DCR's `storage_blob` destination. |
| `storage_account_name` | Name of the Storage Account. | Not currently consumed by another module; available for diagnostics or documentation. |
| `container_name` | Name of the syslog container. | `monitoring-dcr` module — set as the DCR's `storage_blob` destination container. |

## Requirements

| Name | Version |
|---|---|
| Terraform | `>= 1.5.0` |
| azurerm provider | `~> 3.90` |

## Versioning

Only tagged releases are supported for consumption — always pin `?ref=vX.Y.Z` in the `source` argument. `main` is not a supported consumption target and may change without notice.
