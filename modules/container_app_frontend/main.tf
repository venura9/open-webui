resource "azurerm_container_app" "open_webui" {
  name                = "open-webui"
  resource_group_name = var.resource_group_name
  # location            = var.location
  container_app_environment_id = var.container_app_environment_id
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
      cpu    = "1" #missing 
      memory = "2Gi" #missing 
      env {
        name  = "OPENAI_API_KEY"
        value = var.openai_api_key
      }
      env {
        name  = "OLLAMA_BASE_URL"
        value = var.ollama_base_url
      }
      # env {
      #   name  = "OPENAI_API_BASE_URL"
      #   value = var.openai_api_base_url
      # }
    }
    }
  }
