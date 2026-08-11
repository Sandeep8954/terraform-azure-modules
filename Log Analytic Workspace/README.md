# Azure Log Analytics Terraform Module

## Overview

This Terraform module provisions an Azure Log Analytics Workspace used as the centralized logging and monitoring platform for Azure resources and AKS.

It can be integrated with:

* AKS
* Virtual Machines
* Azure Monitor
* Container Insights
* Application Insights
* Azure resources through Diagnostic Settings

---

## Architecture

```text
Azure Resources
│
├── AKS
├── Virtual Machines
├── ACR
├── Key Vault
└── Application Gateway
        │
        ▼
 Azure Monitor
        │
        ▼
 Log Analytics Workspace
        │
        ├── Logs
        ├── Metrics
        └── Alerts
```

---

## Features

* Creates Log Analytics Workspace
* Configurable retention
* Supports environment-specific naming
* Supports resource tagging
* Can be integrated with AKS monitoring
* Can be used by Azure Monitor
* Centralizes operational logs

---

## Example Usage

```hcl
module "monitoring" {
  source = "../../modules/log-analytics"

  project_name = "bankone"
  environment  = "dev"
  location     = "Central India"

  resource_group_name = module.resource_group.name

  retention_days = 30

  tags = {
    Application = "BankOne"
    ManagedBy   = "Terraform"
  }
}
```

---

## Input Variables

| Variable              | Type        | Required | Description          |
| --------------------- | ----------- | -------: | -------------------- |
| `project_name`        | string      |      Yes | Project name         |
| `environment`         | string      |      Yes | Environment          |
| `location`            | string      |      Yes | Azure region         |
| `resource_group_name` | string      |      Yes | Resource group       |
| `retention_days`      | number      |       No | Log retention period |
| `tags`                | map(string) |       No | Resource tags        |

---

## Recommended Retention

Example:

```text
DEV  → 30 days
UAT  → 60 days
PROD → 90+ days
```

Actual retention should be based on:

* Compliance requirements
* Security requirements
* Cost
* Application requirements
* Banking regulations

---

## AKS Integration

AKS can send monitoring data to the workspace.

```text
AKS
 │
 ├── Node logs
 ├── Container logs
 ├── Kubernetes events
 └── Metrics
        │
        ▼
Log Analytics
```

---

## Monitoring Use Cases

Examples include:

### Pod failures

```text
CrashLoopBackOff
ImagePullBackOff
```

### Infrastructure

```text
High CPU
High memory
Node unavailable
```

### Application

```text
HTTP 5xx
High latency
Application exceptions
```

---

## Outputs

| Output         | Description           |
| -------------- | --------------------- |
| `id`           | Workspace resource ID |
| `workspace_id` | Workspace identifier  |

---

## Best Practices

* Use separate workspaces where isolation is required.
* Define appropriate retention periods.
* Avoid unnecessary high-volume logging.
* Use diagnostic settings for Azure resources.
* Create alerts for critical production events.
* Apply RBAC to workspace access.
* Protect sensitive information from being written to logs.
* Monitor Log Analytics ingestion costs.

---

## Future Enhancements

* Diagnostic Settings
* Azure Monitor Alerts
* Application Insights
* Custom KQL queries
* Workbooks
* Action Groups
* Cost monitoring
* Security analytics
