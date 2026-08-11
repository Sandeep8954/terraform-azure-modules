# Azure Container Registry Terraform Module

## Overview

This Terraform module provisions an Azure Container Registry (ACR) for storing and managing container images.

It is designed for CI/CD platforms where application container images are built by pipelines and deployed to Azure Kubernetes Service (AKS).

---

## Architecture

```text
Developer
    │
    ▼
GitHub
    │
    ▼
CI/CD Pipeline
    │
    ├── Build
    ├── Test
    ├── Security Scan
    └── Docker Build
            │
            ▼
       Azure ACR
            │
            ▼
           AKS
```

---

## Features

* Creates Azure Container Registry
* Supports configurable SKU
* Disables admin credentials by default
* Supports environment-specific naming
* Supports tagging
* Returns ACR ID and login server
* Can be integrated with AKS managed identity
* Suitable for CI/CD workloads

---

## Example Usage

```hcl
module "acr" {
  source = "../../modules/acr"

  project_name = "bankone"
  environment  = "dev"
  location     = "Central India"

  resource_group_name = module.resource_group.name

  sku = "Standard"

  tags = {
    Application = "BankOne"
    ManagedBy   = "Terraform"
  }
}
```

---

## Input Variables

| Variable              | Type        | Required | Description    |
| --------------------- | ----------- | -------: | -------------- |
| `project_name`        | string      |      Yes | Project name   |
| `environment`         | string      |      Yes | Environment    |
| `location`            | string      |      Yes | Azure region   |
| `resource_group_name` | string      |      Yes | Resource group |
| `sku`                 | string      |       No | ACR SKU        |
| `tags`                | map(string) |       No | Resource tags  |

---

## Supported SKU

Typical options:

```text
Basic
Standard
Premium
```

For the BankOne project:

```text
DEV  → Standard
UAT  → Standard/Premium
PROD → Premium
```

Premium is recommended when advanced registry features such as private networking and geo-replication are required.

---

## Outputs

| Output         | Description      |
| -------------- | ---------------- |
| `id`           | ACR resource ID  |
| `name`         | ACR name         |
| `login_server` | ACR login server |

Example:

```hcl
module.acr.login_server
```

---

## AKS Integration

AKS should access ACR using Azure RBAC rather than storing registry credentials.

Example:

```hcl
resource "azurerm_role_assignment" "acr_pull" {
  scope                = module.acr.id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_identity_object_id
}
```

Architecture:

```text
AKS Managed Identity
        │
        │ AcrPull
        ▼
Azure Container Registry
```

---

## Image Tagging Strategy

Use immutable image tags.

Recommended:

```text
bankone/account:<git-sha>
```

Example:

```text
bankone/account:a82f71c
```

Avoid:

```text
latest
```

for production deployments.

---

## Best Practices

* Disable ACR admin credentials unless explicitly required.
* Use managed identity/RBAC for AKS.
* Use immutable image tags.
* Scan images before production deployment.
* Enable private networking for production.
* Use Premium SKU when private endpoints or geo-replication are required.
* Apply lifecycle policies for unused images.
* Enable appropriate logging and monitoring.

---

## Future Enhancements

* Private Endpoint
* Private DNS
* Geo-replication
* Retention policies
* Diagnostic settings
* Customer-managed keys
* Defender for Containers integration
