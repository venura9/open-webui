resource "azurerm_openai" "main" {
  name                = "openai-instance"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = "Standard"
}

output "api_key" {
  value     = azurerm_openai.main.api_key
  sensitive = true
}

output "api_base_url" {
  value = azurerm_openai.main.endpoint
}
