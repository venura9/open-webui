resource "azurerm_container_app_environment" "main" {
  name                = "open-webui-env"
  resource_group_name = var.resource_group_name
  location            = var.location
}

resource "azurerm_container_app" "open_webui" {
  name                = "open-webui"
  resource_group_name = var.resource_group_name
  # location            = var.location
  container_app_environment_id = azurerm_container_app_environment.main.id
  revision_mode                = "Single"

  ingress { #missing
    external_enabled = true
    target_port      = 8080
    transport = "http"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  template {
    container {
      name   = "open-webui"
      image  = "ghcr.io/open-webui/open-webui:latest"
      cpu    = "1"
      memory = "2Gi"
      env {
        name  = "OPENAI_API_KEY"
        value = var.openai_api_key
      }
    }
    container {
      name   = "ollama"
      image  = "ollama/ollama"
      cpu    = "1"
      memory = "2Gi"
      env {
        name  = "OLLAMA_BASE_URL"
        value = "http://ollama:8000"
      }
    }
  }
}