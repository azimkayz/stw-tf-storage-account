output "storage_account_id" {
  value       = azurerm_storage_account.this.id
  description = "The resource ID of the Storage Account. Consumed by the Monitoring module."
}

output "storage_account_name" {
  value       = azurerm_storage_account.this.name
  description = "The generated (sanitised) name of the Storage Account."
}

output "storage_container_name" {
  value       = azurerm_storage_container.this.name
  description = "The name of the storage container. Consumed by the Monitoring module — this is where Syslog blobs land."
}