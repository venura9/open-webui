variable "terraform_organization" {
  description = "Terraform Cloud organization name"
  type        = string
}

variable "terraform_workspace" {
  description = "Terraform Cloud workspace name"
  type        = string
}

variable "azure_subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "azure_client_id" {
  description = "Azure client ID"
  type        = string
}

variable "azure_client_secret" {
  description = "Azure client secret"
  type        = string
  sensitive   = true
}

variable "azure_tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "azure_region" {
  description = "Azure region"
  type        = string
  default     = "Australia East"
}
