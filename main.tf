terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
    }
  }

  backend "remote" {
  }
}

provider "azurerm" {
  features {}
}

module "resource_group" {
  source              = "./modules/resource_group"
  resource_group_name = "open-webui-rg"
  location            = var.azure_region
}

module "openai" {
  source              = "./modules/openai"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.azure_region
}

module "container_app" {
  source              = "./modules/container_app"
  resource_group_name = module.resource_group.resource_group_name
  location            = var.azure_region
  openai_api_key      = module.openai.api_key
  openai_api_base_url = module.openai.api_base_url
}
