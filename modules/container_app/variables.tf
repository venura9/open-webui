variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "openai_api_key" {
  description = "API key for Azure OpenAI"
  type        = string
  sensitive   = true
}

variable "openai_api_base_url" {
  description = "Base URL for Azure OpenAI"
  type        = string
}
