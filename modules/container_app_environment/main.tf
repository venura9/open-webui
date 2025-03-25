resource "azurerm_container_app_environment" "main" {
  name                = "open-webui-env"
  resource_group_name = var.resource_group_name
  location            = var.location
}

output "container_app_environment_id" {
  value = azurerm_container_app_environment.main.id
}