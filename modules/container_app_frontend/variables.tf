variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "openai_api_key" {
  description = "API Key OpenAI"
  type        = string
  sensitive   = true
}

variable "ollama_base_url" {
  description = "Base URL for Ollama"
  type        = string
}

variable "container_app_environment_id" {
  description = "Contaiener App Envirnment ID to create the App"
  type        = string
}

variable "storage_name_azure_files" {
  description = "Azure Files Storage Account Name"
  type        = string
}

variable "access_key" {
  description = "Azure Files access_key"
  type        = string
  sensitive   = true
}

variable "azure_storage_endpoint" {
  description = "azure_storage_endpoint"
  type        = string
  default = "https://openwebuistorage001.blob.core.windows.net/"
}

variable "azure_storage_container_name" {
  description = "azure_storage_container_name"
  type        = string
  default = "openwebui"
}

variable "azure_storage_key" {
  description = "azure_storage_key"
  type        = string
  default = ""
}

variable "postgres_url" {
  description = "The URL of the PostgreSQL database"
  type        = string
}