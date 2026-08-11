variable "project_name" {
  type = string
}

variable "environment" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "kubernetes_version" {
  type    = string
  default = null
}

variable "system_node_vm_size" {
  type = string
}

variable "system_node_count" {
  type = number
}

variable "system_node_min_count" {
  type = number
}

variable "system_node_max_count" {
  type = number
}

variable "user_node_vm_size" {
  type = string
}

variable "user_node_min_count" {
  type = number
}

variable "user_node_max_count" {
  type = number
}

variable "acr_id" {
  type = string
}

variable "log_analytics_workspace_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}