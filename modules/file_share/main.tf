resource "azurerm_storage_share" "this" {
  name = var.file_share_name
  storage_account_id = var.storage_account_id
  quota = 50
}

output "file_share_name" {
  value = azurerm_storage_share.this.name
}
