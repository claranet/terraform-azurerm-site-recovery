module "diagnostics" {
  source  = "claranet/diagnostic-settings/azurerm"
  version = "~> 8.2.0"

  resource_id = azurerm_recovery_services_vault.main.id

  name_prefix = var.name_prefix
  name_suffix = var.name_suffix
  custom_name = var.diagnostic_settings_custom_name

  log_categories    = var.logs_categories
  metric_categories = var.logs_metrics_categories

  logs_destinations_ids = coalesce(var.recovery_vault_logs_destinations_ids, var.logs_destinations_ids)
}
