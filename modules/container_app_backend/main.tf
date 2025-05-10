resource "azurerm_container_app" "ollama" {
  name                         = "ollama"
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.container_app_environment_id
  revision_mode                = "Single"

  ingress {
    external_enabled = false  # Internal access only
    target_port      = 11434
    transport        = "http"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
    allow_insecure_connections = true  # Allow HTTP connections
  }

  template {

    volume {
      name         = "ollama"
      storage_type = "AzureFile"
      storage_name = azurerm_container_app_environment_storage.files.name
    }

    container {
      name   = "ollama"
      image  = "ollama/ollama"
      cpu    = "2"
      memory = "4Gi"

      env {
        name  = "OLLAMA_HOST"
        value = "0.0.0.0"
      }

      env {
        name  = "OLLAMA_ORIGINS"
        value = "*"
      }

      env {
        name  = "OLLAMA_CORS"
        value = "true"
      }

      liveness_probe {
        transport = "HTTP"
        port      = 11434
        path      = "/"
        initial_delay = 30
        timeout      = 1
      }

      readiness_probe {
        transport = "HTTP"
        port      = 11434
        path      = "/"
        timeout   = 1
      }

      volume_mounts {
        name = "ollama"
        path = "/root/.ollama"
      }
    }
  }
}

resource "azurerm_container_app_environment_storage" "files" {
  name                         = "ollama"
  container_app_environment_id = var.container_app_environment_id
  account_name                 = "openwebuistorage001"
  share_name                   = var.storage_name_azure_files
  access_key                   = var.access_key
  access_mode                  = "ReadWrite"
}

output "container_app_backend_name" {
  value = azurerm_container_app.ollama.name
}

output "ollama_url" {
  value = "http://${azurerm_container_app.ollama.name}.internal:11434"
}