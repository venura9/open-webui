output "storage_account_id" {
  value = azurerm_storage_account.this.id
}

output "storage_account_key" {
  value = azurerm_storage_account.this.primary_access_key
}