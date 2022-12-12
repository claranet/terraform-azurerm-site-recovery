locals {
  name_prefix = lower(var.name_prefix)
  name_suffix = lower(var.name_suffix)

  rsv_name            = coalesce(var.recovery_vault_custom_name, lower(data.azurecaf_name.rsv.result))
  primary_srf_name    = coalesce(var.primary_site_recovery_fabric_custom_name, lower(data.azurecaf_name.primary_srf.result))
  secondary_srf_name  = coalesce(var.secondary_site_recovery_fabric_custom_name, lower(data.azurecaf_name.secondary_srf.result))
  primary_srpc_name   = coalesce(var.primary_site_recovery_protection_container, lower(data.azurecaf_name.primary_srpc.result))
  secondary_srpc_name = coalesce(var.secondary_site_recovery_protection_container, lower(data.azurecaf_name.secondary_srpc.result))
}
