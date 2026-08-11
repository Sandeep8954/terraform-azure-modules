# Azure Network Terraform Module

## Overview

This Terraform module provisions an Azure Virtual Network and its associated subnets.

The module is designed to be **reusable across DEV, UAT, PROD, and other environments** without changing the module source code.

It supports creating a VNet with multiple subnets such as:

* AKS System Node Pool subnet
* AKS User Node Pool subnet
* Application Gateway subnet
* Private Endpoint subnet
* VM subnet
* Other workload-specific subnets

---

## Architecture

```text
Azure Resource Group
│
└── Virtual Network
    │
    ├── AKS System Subnet
    │
    ├── AKS User Subnet
    │
    ├── Application Gateway Subnet
    │
    ├── Private Endpoint Subnet
    │
    └── VM Subnet
```

---

## Features

* Creates Azure Virtual Network
* Creates multiple subnets dynamically
* Supports environment-specific CIDR ranges
* Uses `for_each` for subnet creation
* Returns VNet and subnet IDs
* Supports common tagging
* Suitable for reusable Terraform modules
* Can be consumed by AKS, VMs, Application Gateway, Private Endpoints, etc.

---

## Module Structure

```text
network/
├── main.tf
├── variables.tf
├── outputs.tf
└── README.md
```

---

## Example Usage

```hcl
module "network" {
  source = "../../modules/network"

  project_name = "bankone"
  environment  = "dev"
  location     = "Central India"

  resource_group_name = module.resource_group.name

  vnet_address_space = [
    "10.10.0.0/16"
  ]

  subnets = {
    system = {
      address_prefixes = ["10.10.1.0/24"]
    }

    user = {
      address_prefixes = ["10.10.2.0/23"]
    }

    appgateway = {
      address_prefixes = ["10.10.4.0/24"]
    }

    private-endpoint = {
      address_prefixes = ["10.10.5.0/24"]
    }
  }

  tags = {
    Application = "BankOne"
    ManagedBy   = "Terraform"
  }
}
```

---

## Input Variables

| Variable              | Type         | Required | Description                        |
| --------------------- | ------------ | -------: | ---------------------------------- |
| `project_name`        | string       |      Yes | Project/application name           |
| `environment`         | string       |      Yes | Environment such as dev, uat, prod |
| `location`            | string       |      Yes | Azure region                       |
| `resource_group_name` | string       |      Yes | Resource group name                |
| `vnet_address_space`  | list(string) |      Yes | VNet CIDR ranges                   |
| `subnets`             | map(object)  |      Yes | Subnet definitions                 |
| `tags`                | map(string)  |       No | Resource tags                      |

---

## Outputs

| Output       | Description                         |
| ------------ | ----------------------------------- |
| `vnet_id`    | ID of the Virtual Network           |
| `vnet_name`  | Name of the Virtual Network         |
| `subnet_ids` | Map containing subnet names and IDs |

Example:

```hcl
module.network.subnet_ids["system"]
```

---

## Environment Example

### DEV

```text
10.10.0.0/16
```

### UAT

```text
10.20.0.0/16
```

### PROD

```text
10.30.0.0/16
```

The same module can be reused for all environments.

---

## Best Practices

* Do not hard-code environment-specific CIDRs inside the module.
* Pass CIDRs through variables.
* Use separate VNets for isolated environments.
* Avoid overlapping CIDR ranges.
* Reserve address space for future growth.
* Use dedicated subnets for Azure services where required.
* Use Private Endpoint subnets for private connectivity.
* Apply consistent tags.
* Keep networking logic inside the reusable module.

---

## Validation

```bash
terraform fmt
terraform validate
terraform plan
```

---

## Future Enhancements

The module can be extended to support:

* Network Security Groups
* NSG associations
* Route tables
* User Defined Routes
* NAT Gateway
* Azure Firewall
* Private DNS integration
* VNet peering
* DDoS protection
* Service endpoints
* Delegated subnets
