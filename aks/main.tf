resource "azurerm_kubernetes_cluster" "this" {
  name                = "${var.project_name}-${var.environment}-aks"
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_prefix = "${var.project_name}-${var.environment}"

  kubernetes_version = var.kubernetes_version

  private_cluster_enabled = false

  sku_tier = "Free"

  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name = "system"

    vm_size = var.system_node_vm_size

    node_count = var.system_node_count

    min_count = var.system_node_min_count
    max_count = var.system_node_max_count

    enable_auto_scaling = true

    vnet_subnet_id = var.subnet_id

    type = "VirtualMachineScaleSets"

    only_critical_addons_enabled = true

    upgrade_settings {
      max_surge = "33%"
    }
  }

  network_profile {
    network_plugin    = "azure"
    network_plugin_mode = "overlay"
    network_policy    = "azure"
    load_balancer_sku = "standard"

    service_cidr   = "10.100.0.0/16"
    dns_service_ip = "10.100.0.10"
  }

  azure_policy_enabled = true

  oidc_issuer_enabled = true

  workload_identity_enabled = true

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }

  tags = merge(
    var.tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

resource "azurerm_kubernetes_cluster_node_pool" "user" {
  name                  = "user"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id

  vm_size = var.user_node_vm_size

  auto_scaling_enabled = true

  min_count = var.user_node_min_count
  max_count = var.user_node_max_count

  vnet_subnet_id = var.subnet_id

  mode = "User"

  node_labels = {
    workload = "bankone"
  }

  upgrade_settings {
    max_surge = "33%"
  }

  tags = merge(
    var.tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
    }
  )
}

# This is an important real-world piece.

# AKS should not have ACR admin credentials.

# Instead:
# AKS Managed Identity ->Arcpull -> ACR

resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.this.kubelet_identity[0].object_id
}