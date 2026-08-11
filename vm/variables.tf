variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where VM NIC will be created"
  type        = string
}

variable "vm_size" {
  description = "Azure VM SKU"
  type        = string
  default     = "Standard_D2s_v5"
}

variable "admin_username" {
  description = "VM administrator username"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key"
  type        = string
  sensitive   = true
}

variable "os_type" {
  description = "Operating system type"
  type        = string
  default     = "Linux"

  validation {
    condition     = contains(["Linux"], var.os_type)
    error_message = "Currently only Linux VMs are supported."
  }
}

variable "os_disk_type" {
  description = "Managed disk type"
  type        = string
  default     = "Premium_LRS"
}

variable "os_disk_size_gb" {
  description = "OS disk size"
  type        = number
  default     = 64
}

variable "image_publisher" {
  type    = string
  default = "Canonical"
}

variable "image_offer" {
  type    = string
  default = "0001-com-ubuntu-server-jammy"
}

variable "image_sku" {
  type    = string
  default = "22_04-lts-gen2"
}

variable "image_version" {
  type    = string
  default = "latest"
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}