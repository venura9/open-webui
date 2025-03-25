variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "openai_api_key" {
  description = "API Key OpenAI"
  type        = string
  sensitive   = true
}

# variable "openai_api_base_url" {
#   description = "Base URL for Azure OpenAI"
#   type        = string
# }


#new
variable "ollama_base_url" {
  description = "Base URL for Ollama"
  type        = string
}

variable "container_app_environment_id" {
  description = "Contaiener App Envirnment ID to create the App"
  type        = string
}