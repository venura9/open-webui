variable "resource_group_name" {
  description = "Name of the resource group"
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