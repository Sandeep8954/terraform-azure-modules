output "id" {
  description = "Storage Account resource ID"
  value       = azurerm_storage_account.this.id
}

output "name" {
  description = "Storage Account name"
  value       = azurerm_storage_account.this.name
}

output "primary_blob_endpoint" {
  description = "Primary Blob endpoint"
  value       = azurerm_storage_account.this.primary_blob_endpoint
}

output "primary_location" {
  description = "Primary Azure region"
  value       = azurerm_storage_account.this.primary_location
}

output "container_names" {
  description = "Created blob containers"
  value       = keys(azurerm_storage_container.this)
}