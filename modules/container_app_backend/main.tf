resource "azurerm_container_app" "ollama" {
  name                         = "ollama"
  resource_group_name          = var.resource_group_name
  container_app_environment_id = var.container_app_environment_id
  revision_mode                = "Single"

  ingress {
    external_enabled = false
    target_port      = 11434
    transport        = "http"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
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
      cpu    = "1"
      memory = "2Gi"

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