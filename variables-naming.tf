variable "name_prefix" {
  description = "Optional prefix for the generated name."
  type        = string
  default     = ""
}

variable "name_suffix" {
  description = "Optional suffix for the generated name."
  type        = string
  default     = ""
}
variable "recovery_vault_custom_name" {
  description = "Custom name for Azure Recovery Vault."
  type        = string
  default     = ""
}

variable "primary_site_recovery_fabric_custom_name" {
  description = "Custom name for Primary Azure Site Recovery Fabric."
  type        = string
  default     = ""
}

variable "secondary_site_recovery_fabric_custom_name" {
  description = "Custom name for Secondary Azure Site Recovery Fabric."
  type        = string
  default     = ""
}

variable "primary_site_recovery_protection_container" {
  description = "Custom name for Primary Azure Site Recovery Protection Container."
  type        = string
  default     = ""
}
variable "secondary_site_recovery_protection_container" {
  description = "Custom name for Secondary Azure Site Recovery Protection Container."
  type        = string
  default     = ""
}

variable "use_caf_naming" {
  description = "Use the Azure CAF naming provider to generate default resource name. `custom_rg_name` override this if set. Legacy default name is used if this is set to `false`."
  type        = bool
  default     = true
}

variable "cache_storage_custom_name" {
  description = "Custom name for cache Storage Account."
  type        = string
  default     = null
}
