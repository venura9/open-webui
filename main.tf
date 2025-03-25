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
}

module "container_app_frontend" {
  source                       = "./modules/container_app_frontend"
  resource_group_name          = module.resource_group.resource_group_name
  container_app_environment_id = module.container_app_environment.container_app_environment_id
  openai_api_key               = var.OPENAI_API_KEY
  ollama_base_url              = module.container_app_backend.container_app_backend_name
  storage_name_azure_files     = module.file_share_open_webui.file_share_name
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