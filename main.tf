terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }

  backend "remote" {
    organization = var.terraform_organization
    workspaces {
      name = var.terraform_workspace
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
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
