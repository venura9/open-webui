# Base image with Golang
FROM mcr.microsoft.com/devcontainers/go:1.22

# Install Azure CLI, Terraform, and jq
RUN curl -fsSL https://aka.ms/install-azure-cli | bash \
    && curl -fsSL https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
    && apt-get update && apt-get install -y terraform jq \
    && apt-get clean

# Install CDKTF (Terraform CDK)
RUN npm install -g cdktf-cli

# Set default working directory
WORKDIR /workspace