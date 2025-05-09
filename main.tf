terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.23.0"
    }
  }
  cloud {}
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = "open-webui-rg"
  location            = var.azure_region
}

module "container_app_environment" {
  source              = "./modules/container_app_environment"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.azure_region
}

module "container_app_backend" {
  source                       = "./modules/container_app_backend"
  resource_group_name          = module.resource_group.resource_group_name
  container_app_environment_id = module.container_app_environment.container_app_environment_id
  storage_name_azure_files     = "ollamafileshare"
  access_key                   = module.storage_account.storage_account_key
}

module "container_app_frontend" {
  source                       = "./modules/container_app_frontend"
  resource_group_name          = module.resource_group.resource_group_name
  container_app_environment_id = module.container_app_environment.container_app_environment_id
  storage_name_azure_files     = "openwebuifileshare"
  access_key                   = module.storage_account.storage_account_key
  openai_api_key               = var.OPENAI_API_KEY
  ollama_base_url              = "http://${module.container_app_backend.container_app_backend_name}:11434"
  postgres_url                 = "postgresql://${module.postgresql_server.fqdn}:5432/postgres?user=adminuser&password=${random_password.postgres_password.result}&sslmode=require"
}

module "storage_account" {
  source               = "./modules/storage_account"
  storage_account_name = "openwebuistorage001"
  resource_group_name  = module.resource_group.resource_group_name
  location             = var.azure_region
}

module "file_share_open_webui" {
  source             = "./modules/file_share"
  storage_account_id = module.storage_account.storage_account_id
  file_share_name    = "openwebuifileshare"
}

module "file_share_ollama" {
  source             = "./modules/file_share"
  storage_account_id = module.storage_account.storage_account_id
  file_share_name    = "ollamafileshare"
}

module "postgresql_server" {
  source              = "./modules/postgresql_server"
  resource_group_name = module.resource_group.resource_group_name
  location           = var.azure_region
  postgres_password  = random_password.postgres_password.result
  name_suffix       = random_string.postgres_suffix.result
}

resource "random_password" "postgres_password" {
  length           = 16
  special          = true
  override_special = "_@"
}

resource "random_string" "postgres_suffix" {
  length  = 8
  special = false
  upper   = false
}