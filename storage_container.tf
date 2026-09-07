resource "azurerm_storage_container" "this" {
  name                   = var.container_name
  storage_account_id     = azurerm_storage_account.this.id
  container_access_type  = var.container_access_type
}