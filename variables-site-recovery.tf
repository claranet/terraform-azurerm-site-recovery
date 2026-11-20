variable "primary_location" {
  description = "Location of source resources to be replicated."
  type        = string
}

variable "primary_location_short" {
  description = "Short name of the source location."
  type        = string
}

variable "network_mapping" {
  description = "Virtual Network mapping as `{ \"source VNet ID\" => \"destination VNet ID\" }.`"
  type        = map(string)
  default     = {}
}

variable "cache_storage_resource_group_name" {
  description = "Resource Group name in which to deploy the cache Storage Account."
  type        = string
}

variable "cache_storage_allowed_subnet_ids" {
  description = "List of subnet IDs allowed to access to the cache Storage Account. All subnets of replicated VMs are dynamically fetched."
  type        = list(string)
  default     = []
}

variable "cache_storage_allowed_cidrs" {
  description = "List of public IPs allowed to access to the cache Storage Account."
  type        = list(string)
  default     = []
}

variable "cache_storage_advanced_threat_protection_enabled" {
  description = "Boolean flag which controls if advanced threat protection is enabled, see [documentation](https://docs.microsoft.com/en-us/azure/storage/common/storage-advanced-threat-protection?tabs=azure-portal) for more information."
  type        = bool
  default     = true
  nullable    = false
}

variable "cache_storage_shared_access_key_enabled" {
  description = "Whether the cache Storage Account permits requests to be authorized with the account access key via Shared Key."
  type        = bool
  default     = false
  nullable    = false
}

variable "cache_storage_cross_tenant_replication_enabled" {
  description = "Whether cross tenant replication is enabled on the cache Storage Account."
  type        = bool
  default     = false
  nullable    = false
}

variable "replicated_vms" {
  description = "Map of VMs to replicate with Azure Site Recovery. VM Name is expected as a key."
  type = map(
    object({
      vm_id                      = string
      target_resource_group_id   = string
      target_availability_set_id = optional(string, null)
      target_zone                = optional(number, null)
      target_network_id          = string

      managed_disks = list(object({
        disk_id   = string
        disk_type = string
        # Overrides the module cache Storage Account, e.g. to keep the cache account already used by an existing replication (changing it forces a re-protection).
        staging_storage_account_id = optional(string)
      }))

      network_interfaces = list(object({
        network_interface_id          = string
        ip_configuration_name         = string
        target_subnet_name            = string
        target_static_ip              = optional(string, null)
        recovery_public_ip_address_id = optional(string, null)
      }))
  }))
}

variable "container_mapping_automatic_update" {
  description = "Automatic update of the Site Recovery extension (Mobility service) on the replicated VMs, through an Automation Account. Disabled when `null`."
  type = object({
    automation_account_id = string
    authentication_type   = optional(string, "SystemAssignedIdentity")
  })
  default = null
}

variable "vault_soft_delete_state" {
  description = "Soft delete state of the Recovery Services Vault, one of `Enabled`, `Disabled` or `AlwaysON`. AzureRM 5.0 no longer manages it, so it is set through AzAPI. Left unmanaged when `null`. `AlwaysON` is irreversible: once set, Azure no longer allows to disable soft delete."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition     = var.vault_soft_delete_state == null || contains(["Enabled", "Disabled", "AlwaysON"], coalesce(var.vault_soft_delete_state, "Enabled"))
    error_message = "`var.vault_soft_delete_state` must be `null`, `Enabled`, `Disabled` or `AlwaysON`."
  }
}

variable "replication_policy" {
  description = "Site recovery replication policy."
  type = object({
    name                                                 = string
    recovery_point_retention_in_minutes                  = optional(number, 1440) # 24h
    application_consistent_snapshot_frequency_in_minutes = optional(number, 240)  # 4h
  })
}
