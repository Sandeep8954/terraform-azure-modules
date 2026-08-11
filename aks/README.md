# Azure Kubernetes Service Terraform Module

## Overview

This Terraform module provisions an Azure Kubernetes Service (AKS) cluster designed to host containerized applications.

The module supports enterprise workloads and separates Kubernetes system workloads from application workloads using dedicated node pools.

---

## Architecture

```text
                    Azure AKS
                       │
             ┌─────────┴─────────┐
             │                   │
       System Node Pool      User Node Pool
             │                   │
       ┌─────┴─────┐       ┌─────┴──────────┐
       │           │       │                │
     CoreDNS    Metrics   Frontend       Backend
                           │                │
                           ├── Auth         │
                           ├── Account      │
                           ├── Transaction  │
                           └── Payment      │
```

---

## Features

* Creates AKS cluster
* Uses managed identity
* Supports system and user node pools
* Supports cluster autoscaling
* Supports Azure CNI
* Supports Azure network policy
* Enables OIDC issuer
* Enables Workload Identity
* Integrates with Log Analytics
* Integrates AKS with ACR using RBAC
* Supports environment-specific sizing
* Supports upgrade surge configuration

---

## Example Usage

```hcl
module "aks" {
  source = "../../modules/aks"

  project_name = "bankone"
  environment  = "dev"
  location     = "Central India"

  resource_group_name = module.resource_group.name

  subnet_id = module.network.subnet_ids["system"]

  system_node_vm_size   = "Standard_D2s_v5"
  system_node_count     = 2
  system_node_min_count = 2
  system_node_max_count = 3

  user_node_vm_size   = "Standard_D2s_v5"
  user_node_min_count = 2
  user_node_max_count = 4

  acr_id = module.acr.id

  log_analytics_workspace_id = module.monitoring.id

  tags = {
    Application = "BankOne"
    ManagedBy   = "Terraform"
  }
}
```

---

## Node Pool Strategy

The cluster uses separate node pools.

### System Pool

Responsible for Kubernetes system components.

```text
CoreDNS
Metrics
Kubernetes system pods
```

### User Pool

Used for application workloads.

```text
Frontend
Authentication
Account
Transaction
Payment
Notification
```

---

## Environment Sizing

### DEV

```text
System:
VM     = Standard_D2s_v5
Min    = 2
Max    = 3

User:
VM     = Standard_D2s_v5
Min    = 2
Max    = 4
```

### UAT

```text
System:
Min = 2
Max = 3

User:
Min = 2
Max = 6
```

### PROD

```text
System:
Min = 3
Max = 5

User:
Min = 3
Max = 10
```

These values should be provided through environment-specific variables.

---

## Networking

The module supports Azure networking.

Typical architecture:

```text
VNet
│
├── AKS System Subnet
│
├── AKS User Subnet
│
├── Application Gateway Subnet
│
└── Private Endpoint Subnet
```

For production, a private AKS cluster is recommended.

---

## Identity

The cluster uses Azure managed identity.

AKS also enables:

```text
OIDC Issuer
Workload Identity
```

This allows workloads to authenticate to Azure services without storing client secrets inside Kubernetes.

---

## ACR Integration

The AKS kubelet identity receives:

```text
AcrPull
```

on the ACR resource.

```text
AKS
 │
 │ Managed Identity
 ▼
AcrPull
 │
 ▼
ACR
```

No registry username/password is required.

---

## Monitoring

AKS integrates with:

```text
Azure Monitor
      │
      └── Log Analytics
              │
              └── Container Insights
```

Monitor:

* Node health
* CPU
* Memory
* Pod status
* Container restarts
* Kubernetes events
* Application logs

---

## Autoscaling

The user node pool supports cluster autoscaling.

Example:

```text
Normal load

2 Nodes
   ↓
High workload
   ↓
3 Nodes
   ↓
4 Nodes
```

Maximum node count is controlled through variables.

Application-level scaling should be handled separately using Kubernetes HPA.

---

## Upgrade Strategy

The module supports:

```hcl
upgrade_settings {
  max_surge = "33%"
}
```

This allows additional nodes to be temporarily created during upgrades to reduce workload disruption.

---

## Outputs

| Output                       | Description              |
| ---------------------------- | ------------------------ |
| `id`                         | AKS resource ID          |
| `name`                       | AKS cluster name         |
| `fqdn`                       | AKS API server FQDN      |
| `kubelet_identity_object_id` | Kubelet managed identity |
| `oidc_issuer_url`            | OIDC issuer URL          |

---

## Best Practices

* Use separate clusters for PROD and non-PROD.
* Use dedicated system and user node pools.
* Enable autoscaling.
* Use Azure RBAC.
* Use Workload Identity.
* Avoid static credentials.
* Use private AKS for sensitive production workloads.
* Configure resource requests and limits.
* Configure readiness/liveness probes.
* Use Pod Disruption Budgets.
* Apply network policies.
* Monitor cluster health.
* Use controlled upgrade strategies.

---

## Future Enhancements

* Private AKS
* Azure Application Gateway
* WAF
* Ingress Controller
* Private DNS
* Multiple user node pools
* Availability Zones
* KEDA
* Defender for Containers
* Diagnostic settings
* Azure Monitor alerts
* DR cluster
