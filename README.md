# AI Generated - accuracy is questionable.

# Open WebUI Deployment to Azure

This Terraform configuration deploys Open WebUI and Ollama containers to Azure Container Apps and creates an Azure OpenAI resource.

## Overview
This repository contains Terraform configurations to set up an Azure environment with container apps for backend and frontend services.

## Prerequisites

- Terraform v0.14 or later
- Azure CLI
- An Azure subscription
- Environment variables set for:
  - `TF_VAR_terraform_organization`
  - `TF_VAR_terraform_workspace`
  - `TF_VAR_azure_subscription_id`
  - `TF_VAR_azure_client_id`
  - `TF_VAR_azure_client_secret`
  - `TF_VAR_azure_tenant_id`

## Setup

1. **Clone the repository:**
   ```sh
   git clone https://github.com/your-repo/open-webui.git
   cd open-webui
   ```

2. **Initialize Terraform:**
   ```sh
   terraform init
   ```

3. **Set up your variables:**
   Create a `terraform.tfvars` file in the root directory and add the following variables:
   ```hcl
   azure_region = "your-azure-region"
   OPENAI_API_KEY = "your-openai-api-key"
   ```

4. **Apply the Terraform configuration:**
   ```sh
   terraform apply
   ```

## Deployment

1. Initialize Terraform:

    ```sh
    terraform init
    ```

2. Apply the Terraform configuration:

    ```sh
    terraform apply
    ```

3. After the deployment is complete, the URL for accessing Open WebUI will be displayed in the output.

## Modules

### Resource Group
This module creates an Azure Resource Group.

### Container App Environment
This module sets up the environment for container apps.

### Container App Backend
This module deploys the backend container app.

### Container App Frontend
This module deploys the frontend container app.

## Outputs
- `container_app_backend_name`: The name of the backend container app.

## Environment Variables

- `OPENAI_API_KEY` and `OPENAI_API_BASE_URL` are dynamically captured from the Azure OpenAI instance.
- `OLLAMA_BASE_URL` is set to point to the Ollama container instance.

## Notes

- The display name of the Open WebUI interface is set to "Azure Builders".
- Open WebUI is published at: `ghcr.io/open-webui/open-webui:latest`
- Ensure that you have the necessary permissions to create resources in your Azure subscription.
- The backend container app uses a volume mounted at `/app/backend/data` for data storage.
