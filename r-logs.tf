module "diagnostics_recovery_vault" {
  source  = "claranet/diagnostic-settings/azurerm"
  version = "~> 8.0.0"

  logs_destinations_ids = coalesce(var.recovery_vault_logs_destinations_ids, var.logs_destinations_ids)
  resource_id           = azurerm_recovery_services_vault.asr_vault.id
}
