resource "azurerm_storage_share" "this" {
  name = var.file_share_name
  storage_account_id = var.storage_account_id
  quota = 50
}
