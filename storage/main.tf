resource "azurerm_storage_account" "this" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  min_tls_version = "TLS1_2"

  public_network_access_enabled   = var.public_network_access_enabled
  allow_nested_items_to_be_public = false

  shared_access_key_enabled = var.shared_access_key_enabled

  network_rules {
    default_action = var.network_default_action

    ip_rules = var.allowed_ip_addresses
  }

  blob_properties {
    versioning_enabled = var.versioning_enabled

    delete_retention_policy {
      days = var.blob_delete_retention_days
    }

    container_delete_retention_policy {
      days = var.container_delete_retention_days
    }
  }

  tags = var.tags
}

resource "azurerm_storage_container" "this" {
  for_each = toset(var.containers)

  name                  = each.value
  storage_account_id    = azurerm_storage_account.this.id
  container_access_type = "private"
}
