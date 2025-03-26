resource "azurerm_container_app" "open_webui" {
  name                         = "open-webui-fe"
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

    # volume {
    #   name         = "open-webui"
    #   storage_type = "AzureFile"
    #   storage_name = azurerm_container_app_environment_storage.files.name
    # }

    volume {
      name = "open-webui"
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
      # env {
      #   name  = "OLLAMA_BASE_URL"
      #   value = var.ollama_base_url
      # }
      env {
        name = "AZURE_STORAGE_ENDPOINT"
        value = var.azure_storage_endpoint
      }
      env {
        name = "AZURE_STORAGE_CONTAINER_NAME"
        value = var.azure_storage_container_name
      }
      env {
        name = "AZURE_STORAGE_KEY"
        value = var.azure_storage_key
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