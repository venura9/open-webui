resource "azurerm_cognitive_account" "openai" {
  name                = "openai-instance"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "S0"  # Note: You might need to request quota increase for GPT-4
  kind                = "OpenAI"
  custom_subdomain_name = "openwebui-gpt4"
}

resource "azurerm_cognitive_deployment" "gpt" {
  name                 = "gpt-4"
  cognitive_account_id = azurerm_cognitive_account.openai.id
  model {
    format  = "OpenAI"
    name    = "gpt-4"
    version = "0613"
  }
  sku {
    name     = "Standard"
    capacity = 10
  }
}

output "api_key" {
  value     = azurerm_cognitive_account.openai.primary_access_key
  sensitive = true
}

output "api_base_url" {
  value = azurerm_cognitive_account.openai.endpoint
}

output "model_deployment_name" {
  value = azurerm_cognitive_deployment.gpt.name
}
