locals {
  # Azure Storage Account names must be globally unique, lowercase alphanumeric
  # only (no hyphens), and max 24 characters. This is a hard platform constraint,
  # so the convention is applied FIRST, then sanitised — not skipped outright.
  raw_storage_account_name = "st-${var.project_name}-${var.environment}-${var.location}"
  storage_account_name     = substr(lower(replace(local.raw_storage_account_name, "-", "")), 0, 24)

  common_tags = merge(
    {
      project     = var.project_name
      environment = var.environment
      managed_by  = "Qays"
    },
    var.tags
  )
}