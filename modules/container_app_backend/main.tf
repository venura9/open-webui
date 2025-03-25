resource "azurerm_container_app" "ollama" {
  name                = "ollama"
  resource_group_name = var.resource_group_name
  container_app_environment_id = var.container_app_environment_id
  revision_mode                = "Single"

  ingress {
    external_enabled = false
    target_port      = 11434
    transport = "http"
    traffic_weight {
      latest_revision = true
      percentage      = 100
    }
  }

  template {
    container {
      name   = "ollama"
      image  = "ollama/ollama"
      cpu    = "1"
      memory = "2Gi"
    }
  }
}

output "container_app_backend_name" {
  value = azurerm_container_app.ollama.name
}