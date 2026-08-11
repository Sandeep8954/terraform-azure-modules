output "vm_id" {
  description = "Virtual machine resource ID"
  value       = azurerm_linux_virtual_machine.this[0].id
}

output "vm_name" {
  description = "Virtual machine name"
  value       = azurerm_linux_virtual_machine.this[0].name
}

output "nic_id" {
  description = "Network interface ID"
  value       = azurerm_network_interface.this.id
}

output "private_ip_address" {
  description = "Private IP address of VM"
  value       = azurerm_network_interface.this.private_ip_address
}

output "identity_principal_id" {
  description = "System assigned managed identity principal ID"
  value       = azurerm_linux_virtual_machine.this[0].identity[0].principal_id
}