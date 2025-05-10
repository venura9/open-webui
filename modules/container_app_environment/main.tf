resource "azurerm_container_app_environment" "main" {
  name                = "open-webui-env"
  resource_group_name = var.resource_group_name
  location            = var.location
  
  workload_profile {
    name                  = "Consumption"
    workload_profile_type = "Consumption"
  }
}

output "container_app_environment_id" {
  value = azurerm_container_app_environment.main.id
}