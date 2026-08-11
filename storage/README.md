# Azure Storage Account Terraform Module

## Overview

This Terraform module provisions Azure Storage Accounts for workloads such as:

* Terraform remote state
* Application files
* Blob storage
* Backups
* Logs
* Artifacts
* Data exchange

The module is designed to be reusable across multiple environments.

---

## Architecture

```text
Application / Terraform / Backup
             │
             ▼
      Azure Storage Account
             │
       ┌─────┼─────┐
       ▼     ▼     ▼
     Blob  File   Queue
```

---

## Features

* Creates Storage Account
* Configurable replication
* Configurable access tier
* TLS configuration
* Blob versioning
* Soft delete
* Container creation
* Resource tagging
* Supports environment-specific configuration

---

## Example Usage

```hcl
module "storage" {
  source = "../../modules/storage"

  project_name = "bankone"
  environment  = "dev"
  location     = "Central India"

  resource_group_name = module.resource_group.name

  account_tier             = "Standard"
  account_replication_type = "GRS"

  containers = [
    "application",
    "backup",
    "artifacts"
  ]

  tags = {
    Application = "BankOne"
    ManagedBy   = "Terraform"
  }
}
```

---

## Replication Options

Common options include:

```text
LRS
ZRS
GRS
RA-GRS
GZRS
RA-GZRS
```

Selection depends on:

* Availability requirements
* Disaster recovery requirements
* Region support
* Cost
* Data requirements

---

## Remote Terraform State

A storage account can be used for Terraform state.

Example:

```text
Azure Storage Account
│
└── tfstate container
      │
      ├── bankone-dev.tfstate
      ├── bankone-uat.tfstate
      └── bankone-prod.tfstate
```

State should be protected using:

* RBAC
* Encryption
* Versioning
* Soft delete
* Restricted access

---

## Security

For production workloads, consider:

* Disable public blob access
* Disable anonymous access
* Private Endpoint
* Private DNS
* Azure RBAC
* Customer-managed keys where required
* Network restrictions
* TLS 1.2+
* Defender for Storage

---

## Outputs

Typical outputs:

| Output                  | Description                       |
| ----------------------- | --------------------------------- |
| `id`                    | Storage Account ID                |
| `name`                  | Storage Account name              |
| `primary_blob_endpoint` | Blob endpoint                     |
| `primary_access_key`    | Access key if explicitly required |

Avoid exposing access keys unless there is a specific requirement.

---

## Best Practices

* Prefer managed identity over access keys.
* Do not commit storage keys to Git.
* Use private endpoints for sensitive workloads.
* Enable versioning for important data.
* Enable soft delete.
* Use lifecycle policies for old data.
* Select replication based on business requirements.
* Separate state storage from application storage where appropriate.

---

## Future Enhancements

* Private Endpoint
* Private DNS
* Lifecycle Management
* Immutable Blob Storage
* Customer-managed keys
* Defender for Storage
* Diagnostic Settings
* Geo-replication
* Object replication
