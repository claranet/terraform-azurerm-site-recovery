module "diagnostics_recovery_vault" {
  source  = "claranet/diagnostic-settings/azurerm"
  version = "~> 8.0.0"

  resource_id = azurerm_recovery_services_vault.main.id

  name_prefix = var.name_prefix
  name_suffix = var.name_suffix

  logs_destinations_ids = coalesce(var.recovery_vault_logs_destinations_ids, var.logs_destinations_ids)
}
