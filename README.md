# Open WebUI Deployment to Azure

This Terraform configuration deploys Open WebUI and Ollama containers to Azure Container Apps and creates an Azure OpenAI resource.

## Prerequisites

- Terraform installed
- Azure CLI installed
- Environment variables set for:
  - `TF_VAR_terraform_organization`
  - `TF_VAR_terraform_workspace`
  - `TF_VAR_azure_subscription_id`
  - `TF_VAR_azure_client_id`
  - `TF_VAR_azure_client_secret`
  - `TF_VAR_azure_tenant_id`

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

## Environment Variables

- `OPENAI_API_KEY` and `OPENAI_API_BASE_URL` are dynamically captured from the Azure OpenAI instance.
- `OLLAMA_BASE_URL` is set to point to the Ollama container instance.

## Notes

- The display name of the Open WebUI interface is set to "Azure Builders".
- Open WebUI is published at: `ghcr.io/open-webui/open-webui:latest`
