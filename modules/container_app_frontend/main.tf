resource "azurerm_container_app" "open_webui" {
  name                         = "open-webui"
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.container_app_environment_id
  revision_mode                = "Single"

  ingress {
    external_enabled = true
    target_port      = 8080
    transport        = "http"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  # secret {
  #   name  = "OPENAI_API_KEY"
  #   value = var.openai_api_key
  # }

  template {

    volume {
      name         = "open-webui"
      storage_type = "AzureFile"
      storage_name = azurerm_container_app_environment_storage.files.name
    }

    container {
      name   = "open-webui"
      image  = "ghcr.io/open-webui/open-webui:latest"
      cpu    = "1"
      memory = "2Gi"
      volume_mounts {
        name = "open-webui"
        path = "/app/backend/data"
      }

      env {
        name  = "OPENAI_API_KEY"
        value = var.openai_api_key
      }
      env {
        name  = "OLLAMA_BASE_URL"
        value = var.ollama_base_url
      }
    }
  }
}


resource "azurerm_container_app_environment_storage" "files" {
  name                         = "openwebui"
  container_app_environment_id = var.container_app_environment_id
  account_name                 = "openwebuistorage001"
  share_name                   = var.storage_name_azure_files
  access_key                   = var.access_key
  access_mode                  = "ReadWrite"
}