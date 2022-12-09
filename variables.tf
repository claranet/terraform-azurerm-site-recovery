variable "location" {
  description = "Azure region to use."
  type        = string
}

variable "client_name" {
  description = "Client name/account used in naming."
  type        = string
}

variable "environment" {
  description = "Project environment."
  type        = string
}

variable "stack" {
  description = "Project stack name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "primary_location" {
  description = "Location of source resources to be replicated."
  type        = string
}

variable "primary_location_short" {
  description = "Short name of the source location."
}

variable "network_mapping" {
  description = "Map of VNET mapping. Source = Destination."
  type        = map(string)
  default     = {}
}

variable "cache_storage_resource_group_name" {
  description = "Resource Group name in which to deploy the cache Storage Account."
  type        = string
}

variable "replicated_vms" {
  description = "Map of VMs to replicate with Azure Site Recovery."
  type = object({
    vm_id                      = string
    target_resource_group_id   = string
    target_availability_set_id = optional(string, null)
    target_zone                = optional(number, null)
    target_network_id          = string

    managed_disks = list(object({
      disk_id   = string
      disk_type = string
    }))

    network_interfaces = list(object({
      network_interface_id          = string
      target_subnet_name            = string
      target_static_ip              = optional(string, null)
      recovery_public_ip_address_id = optional(string, null)
    }))
  })
}

variable "replication_policy" {
  description = "Site recovery replication policy."
  type = object({
    name                                                 = string
    recovery_point_retention_in_minutes                  = optional(number, 1440) # 24h
    application_consistent_snapshot_frequency_in_minutes = optional(number, 240)  # 4h
  })
}
