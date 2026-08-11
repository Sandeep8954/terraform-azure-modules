# Terraform Azure Reusable Modules

A collection of reusable and version-controlled **Terraform modules for Microsoft Azure**, designed to promote standardization, scalability, consistency, and Infrastructure as Code (IaC) best practices.

These modules are intended to simplify Azure infrastructure provisioning across multiple environments such as **Development, UAT, and Production** while reducing code duplication and improving maintainability.

---

## 📌 Repository Overview

This repository contains reusable Terraform modules for commonly used Azure infrastructure components.

```text
terraform-azure-modules/
│
├── resource-group/
├── network/
├── storage/
├── keyvault/
├── vm/
├── aks/
│
└── README.md
```

Each module is designed to be:

* ♻️ Reusable
* 📦 Modular
* 🔐 Secure
* 📈 Scalable
* 🏗️ Production-oriented
* 🔖 Version controlled
* 📚 Well documented

---

## 🏗️ Architecture

The modules can be consumed by separate environment repositories:

```text
                         GitHub
                           │
                           ▼
                terraform-azure-modules
                           │
          ┌────────────────┼────────────────┐
          │                │                │
          ▼                ▼                ▼
       Network          Storage          Key Vault
        Module           Module            Module
          │                │                │
          └────────────────┼────────────────┘
                           │
                           ▼
              Environment Repositories
                           │
              ┌────────────┼────────────┐
              ▼            ▼            ▼
             DEV          UAT          PROD
```

---

## 📦 Available Modules

| Module         | Description                                 | Status         |
| -------------- | ------------------------------------------- | -------------- |
| Resource Group | Creates and manages Azure Resource Groups   | 🚧 In Progress |
| Network        | VNet, Subnets and Network Security Groups   | 🚧 In Progress |
| Storage        | Azure Storage Account and related resources | 🚧 Planned     |
| Key Vault      | Azure Key Vault and security configuration  | 🚧 Planned     |
| VM             | Azure Virtual Machine infrastructure        | 🚧 Planned     |
| AKS            | Azure Kubernetes Service infrastructure     | 🚧 Planned     |

> Modules will be added and versioned progressively as development continues.

---

# 🚀 Module Usage

Modules can be consumed from this repository using a Git source.

Example:

```hcl
module "network" {
  source = "git::https://github.com/<your-username>/terraform-azure-modules.git//network?ref=v1.0.0"

  resource_group_name = "rg-dev"
  location            = "Central India"

  vnet_name = "vnet-dev"

  address_space = [
    "10.10.0.0/16"
  ]

  subnets = {
    app = {
      address_prefix = "10.10.1.0/24"
    }

    db = {
      address_prefix = "10.10.2.0/24"
    }
  }
}
```

Replace `<your-username>` with your GitHub username.

---

# 🔖 Module Versioning

Modules are version controlled using Git tags.

Example:

```text
v1.0.0
v1.1.0
v1.2.0
v2.0.0
```

Consumers should reference a specific module version rather than always consuming the latest code.

Example:

```hcl
source = "git::https://github.com/<your-username>/terraform-azure-modules.git//network?ref=v1.0.0"
```

This provides controlled upgrades and prevents unexpected infrastructure changes.

---

# 📁 Standard Module Structure

Each module follows a consistent structure:

```text
network/
│
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── locals.tf
├── README.md
│
└── examples/
    └── basic/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

### `main.tf`

Contains the primary Azure resources.

### `variables.tf`

Defines configurable module inputs.

### `outputs.tf`

Exposes important resource attributes to consuming configurations.

### `versions.tf`

Defines Terraform and provider version requirements.

### `locals.tf`

Contains reusable local values and common expressions.

### `examples/`

Contains examples demonstrating how the module can be consumed.

---

# 🔧 Development Workflow

All modules follow a standard development workflow:

```text
Developer
    │
    ▼
Create / Modify Module
    │
    ▼
Terraform Format
    │
    ▼
Terraform Validate
    │
    ▼
Security / Quality Checks
    │
    ▼
Pull Request
    │
    ▼
Code Review
    │
    ▼
Merge
    │
    ▼
Git Tag / Release
    │
    ▼
Module Consumption
```

---

# 🧪 Validation

Before committing changes, run:

```bash
terraform fmt -recursive
```

```bash
terraform validate
```

For modules that contain examples:

```bash
cd examples/basic
terraform init
terraform validate
terraform plan
```

---

# 🔐 Security Practices

The modules follow security-focused IaC practices.

### Credentials

Sensitive credentials should **never be hard-coded** in Terraform files.

Avoid:

```hcl
password = "MyPassword123"
```

Use secure mechanisms such as:

* Azure Managed Identity
* Microsoft Entra ID
* Azure Key Vault
* Environment variables
* CI/CD secret stores

---

## 🚫 Files Not to Commit

The following should generally not be committed:

```text
terraform.tfstate
terraform.tfstate.*
.terraform/
*.tfvars
*.tfvars.json
crash.log
```

A recommended `.gitignore` should include:

```gitignore
.terraform/
*.tfstate
*.tfstate.*
*.tfvars
*.tfvars.json
crash.log
crash.*.log
override.tf
override.tf.json
*_override.tf
*_override.tf.json
```

---

# 🌎 Environment Strategy

The modules are designed to be consumed by separate environment configurations.

Example:

```text
terraform-environments/
│
├── dev/
│   ├── main.tf
│   ├── variables.tf
│   └── terraform.tfvars
│
├── uat/
│   ├── main.tf
│   ├── variables.tf
│   └── terraform.tfvars
│
└── prod/
    ├── main.tf
    ├── variables.tf
    └── terraform.tfvars
```

The same module can then be reused:

```text
                Network Module
                     │
          ┌──────────┼──────────┐
          ▼          ▼          ▼
         DEV        UAT        PROD
       10.10/16   10.20/16   10.30/16
```

Only environment-specific values change.

---

# 📋 Design Principles

The modules follow these principles:

### 1. Reusability

Avoid duplicating infrastructure code across environments.

### 2. Standardization

Use consistent resource configuration and naming conventions.

### 3. Versioning

Release modules using Git tags and consume pinned versions.

### 4. Security

Avoid hard-coded credentials and follow Azure security best practices.

### 5. Maintainability

Keep modules focused on a specific infrastructure responsibility.

### 6. Scalability

Design modules to support different environments and configurations.

### 7. Documentation

Every module should contain usage instructions, inputs, outputs, and examples.

---

# 🛠️ Tools & Technologies

* Terraform
* Microsoft Azure
* AzureRM Provider
* Git
* GitHub
* GitHub Actions
* Azure CLI
* Infrastructure as Code (IaC)

---

# 🗺️ Roadmap

* [x] Repository structure
* [ ] Resource Group module
* [ ] Network module
* [ ] Storage module
* [ ] Key Vault module
* [ ] Virtual Machine module
* [ ] AKS module
* [ ] Module examples
* [ ] Terraform validation pipeline
* [ ] Security scanning
* [ ] Automated testing
* [ ] Versioned releases
* [ ] Documentation improvements

---

# 📚 Learning Objectives

This repository is also being used as a practical DevOps learning and interview preparation project to demonstrate:

* Terraform module development
* Infrastructure as Code
* Azure infrastructure automation
* Environment separation
* Git-based version control
* CI/CD integration
* Infrastructure security
* Reusable infrastructure patterns
* Production-oriented Terraform practices

---

# 👨‍💻 Author

**Sandeep Kumar**

DevOps Engineer | Azure | Terraform | Kubernetes | CI/CD | GitHub

---

## ⭐ Note

This repository is continuously evolving as new reusable modules, examples, automation, testing, and security practices are added.
