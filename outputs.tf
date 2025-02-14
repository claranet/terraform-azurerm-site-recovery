output "recovery_vault" {
  description = "Azure Recovery Services Vault."
  value       = azurerm_recovery_services_vault.asr_vault
}

output "replicated_vms" {
  description = "Replicated virtual machines."
  value       = azurerm_site_recovery_replicated_vm.vm_replication
}

output "replication_policy" {
  description = "Replication policy."
  value       = azurerm_site_recovery_replication_policy.policy
}

output "cache_storage_account" {
  description = "Cache Storage Account."
  value       = module.cache_storage_account
}

output "primary_fabric" {
  description = "Fabric of the source resources. Primary region."
  value       = azurerm_site_recovery_fabric.primary
}

output "secondary_fabric" {
  description = "Fabric of the replicated resources. Secondary region."
  value       = azurerm_site_recovery_fabric.secondary
}

output "primary_protection_container" {
  description = "Protection containers of the replicated resources. Primary region."
  value       = azurerm_site_recovery_protection_container.primary
}

output "secondary_protection_container" {
  description = "Protection containers of the replicated resources. Secondary region."
  value       = azurerm_site_recovery_protection_container.secondary
}

output "network_mapping" {
  description = "Site recovery network mapping."
  value       = azurerm_site_recovery_network_mapping.network_mapping
}

output "container_mapping" {
  description = "Protection container mapping."
  value       = azurerm_site_recovery_protection_container_mapping.container_mapping
}

output "module_diagnostics" {
  description = "Diagnostics settings module outputs."
  value       = module.diagnostics_recovery_vault
}
