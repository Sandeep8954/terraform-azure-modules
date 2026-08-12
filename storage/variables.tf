variable "storage_account_name" {
  description = "Globally unique Azure Storage Account name"
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

variable "account_tier" {
  description = "Storage account tier"
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Storage replication type"
  type        = string
  default     = "GRS"

  validation {
    condition = contains(
      [
        "LRS",
        "ZRS",
        "GRS",
        "RAGRS",
        "GZRS",
        "RAGZRS"
      ],
      var.account_replication_type
    )

    error_message = "Invalid storage replication type."
  }
}

variable "public_network_access_enabled" {
  description = "Allow public network access"
  type        = bool
  default     = true
}

variable "network_default_action" {
  description = "Default network action for the storage account"
  type        = string
  default     = "Deny"

  validation {
    condition     = contains(["Allow", "Deny"], var.network_default_action)
    error_message = "network_default_action must be either Allow or Deny."
  }
}

variable "allowed_ip_addresses" {
  description = "List of public IP addresses allowed to access the storage account"
  type        = list(string)
  default     = []
}

variable "shared_access_key_enabled" {
  description = "Enable storage account shared keys"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Enable blob versioning"
  type        = bool
  default     = true
}

variable "blob_delete_retention_days" {
  description = "Blob soft delete retention"
  type        = number
  default     = 30
}

variable "container_delete_retention_days" {
  description = "Container soft delete retention"
  type        = number
  default     = 30
}

variable "containers" {
  description = "List of blob containers"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "Resource tags"
  type        = map(string)
  default     = {}
}
<<<<<<< HEAD

variable "network_default_action" {
  description = "Default network action for the storage account"
  type        = string
  default     = "Deny"

  validation {
    condition     = contains(["Allow", "Deny"], var.network_default_action)
    error_message = "network_default_action must be either Allow or Deny."
  }
}

variable "allowed_ip_addresses" {
  description = "List of public IP addresses allowed to access the storage account"
  type        = list(string)
  default     = []
}
=======
>>>>>>> 0461a0d0069628b3e9b090bba487cdcb9c7e2fef
