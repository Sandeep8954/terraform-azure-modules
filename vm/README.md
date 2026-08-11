# Azure Virtual Machine Terraform Module

## Overview

This Terraform module provisions Azure Virtual Machines for workloads that cannot or should not run inside AKS.

Typical use cases include:

* Jump Box
* Management VM
* Azure DevOps self-hosted agent
* Hybrid Worker
* Legacy application
* Migration tooling
* Administrative workloads

---

## Architecture

```text
Azure VNet
│
├── AKS Subnet
│
├── Private Endpoint Subnet
│
└── VM Subnet
      │
      └── Management VM
             │
             ├── Azure CLI
             ├── Terraform
             ├── AzCopy
             └── Administration Tools
```

---

## Features

* Creates Linux or Windows VM
* Creates network interface
* Supports configurable VM size
* Supports existing subnet
* Supports managed identity
* Supports OS disk configuration
* Supports data disks
* Supports tags
* Supports availability configuration

---

## Example Usage

```hcl
module "vm" {
  source = "../../modules/vm"

  project_name = "bankone"
  environment  = "dev"
  location     = "Central India"

  resource_group_name = module.resource_group.name

  subnet_id = module.network.subnet_ids["vm"]

  vm_name = "bankone-dev-jumpbox"

  vm_size = "Standard_D2s_v5"

  admin_username = "azureadmin"

  os_type = "Linux"

  tags = {
    Application = "BankOne"
    Role        = "Management"
    ManagedBy   = "Terraform"
  }
}
```

---

## VM Use Cases

### Jump Box

Used for:

```text
Azure CLI
kubectl
Terraform
AzCopy
Network troubleshooting
```

### Migration VM

Can be used for:

```text
AzCopy
Azure Migrate tooling
Data migration
Backup operations
```

### Self-hosted Agent

Can execute:

```text
Terraform
Azure CLI
PowerShell
Deployment scripts
```

---

## Identity

The VM should preferably use:

```text
System Assigned Managed Identity
```

instead of storing Azure credentials.

Example:

```text
VM
 │
 │ Managed Identity
 ▼
Microsoft Entra ID
 │
 ▼
Azure RBAC
```

---

## Security

For production:

* Avoid public IP where possible.
* Use Azure Bastion for administrative access.
* Restrict inbound traffic using NSGs.
* Use managed identity.
* Use Trusted Launch where supported.
* Enable disk encryption.
* Use Defender for Cloud.
* Keep OS patched.
* Avoid storing passwords in Terraform code.
* Use SSH keys for Linux.
* Use private connectivity.

---

## OS Disk

Example configuration:

```text
OS Disk
│
├── Managed Disk
├── Premium SSD
└── Encryption
```

Use appropriate disk type based on workload requirements.

---

## Data Disks

For workloads requiring persistent data:

```text
VM
│
├── OS Disk
│
├── Data Disk 1
│
└── Data Disk 2
```

Data disks should be managed independently where possible.

---

## Outputs

Typical outputs:

| Output                  | Description                   |
| ----------------------- | ----------------------------- |
| `vm_id`                 | VM resource ID                |
| `vm_name`               | VM name                       |
| `nic_id`                | Network interface ID          |
| `private_ip_address`    | VM private IP                 |
| `identity_principal_id` | Managed identity principal ID |

---

## Best Practices

* Prefer private IPs.
* Use Bastion instead of public SSH/RDP.
* Use managed identities.
* Use SSH keys instead of passwords for Linux.
* Apply NSGs.
* Keep the OS patched.
* Use Azure Monitor.
* Enable Defender for Cloud.
* Avoid manual configuration drift.
* Prefer cloud-init/VM extensions for initial configuration.
* Use Terraform for lifecycle management.

---

## Example Enterprise Architecture

```text
                    Azure VNet
                        │
              ┌─────────┴─────────┐
              │                   │
          AKS Subnet           VM Subnet
              │                   │
              ▼                   ▼
             AKS              Jump Box
              │                   │
              │              Azure CLI
              │              Terraform
              │              kubectl
              │              AzCopy
              │                   │
              └─────────┬─────────┘
                        │
                  Private Azure
                    Services
```

---

## Future Enhancements

* Azure Bastion
* VM Scale Sets
* Availability Zones
* Trusted Launch
* Disk Encryption
* Azure Monitor Agent
* Defender for Cloud
* Backup
* Patch Management
* Custom Script Extension
* Cloud-init
* Private DNS
