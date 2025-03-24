resource "azurerm_container_app_environment" "main" {
  name                = "open-webui-env"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_container_app" "open_webui" {
  name                = "open-webui"
  resource_group_name = var.resource_group_name
  location            = var.location
  container_app_environment_id = azurerm_container_app_environment.main.id

  template {
    container {
      name   = "open-webui"
      image  = "ghcr.io/open-webui/open-webui:latest"
      env {
        name  = "OPENAI_API_KEY"
        value = var.openai_api_key
      }
      env {
        name  = "OPENAI_API_BASE_URL"
        value = var.openai_api_base_url
      }
    }
    container {
      name   = "ollama"
      image  = "ollama/ollama"
      env {
        name  = "OLLAMA_BASE_URL"
        value = "http://ollama:8000"
      }
    }
  }
}

output "open_webui_url" {
  value = azurerm_container_app.open_webui.url
}
