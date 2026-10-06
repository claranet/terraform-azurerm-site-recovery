resource "azurerm_recovery_services_vault" "main" {
  location            = var.location
  name                = local.name
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  tags = local.tags
}

moved {
  from = azurerm_recovery_services_vault.asr_vault
  to   = azurerm_recovery_services_vault.main
}

# AzureRM 5.0 removed `soft_delete_enabled` from `azurerm_recovery_services_vault`.
# `AlwaysON` is irreversible: Azure rejects any downgrade to `Enabled` or `Disabled`.
resource "azapi_update_resource" "vault_soft_delete" {
  count = var.vault_soft_delete_state != null ? 1 : 0

  type        = "Microsoft.RecoveryServices/vaults@2024-04-01"
  resource_id = azurerm_recovery_services_vault.main.id

  body = {
    properties = {
      securitySettings = {
        softDeleteSettings = {
          softDeleteState = var.vault_soft_delete_state
        }
      }
    }
  }
}

resource "azurerm_site_recovery_fabric" "primary" {
  name                = local.primary_srf_name
  location            = var.primary_location
  recovery_vault_name = azurerm_recovery_services_vault.main.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_site_recovery_fabric" "secondary" {
  name                = local.secondary_srf_name
  location            = var.location
  recovery_vault_name = azurerm_recovery_services_vault.main.name
  resource_group_name = var.resource_group_name
}

resource "azurerm_site_recovery_protection_container" "primary" {
  name                 = local.primary_srpc_name
  recovery_fabric_name = azurerm_site_recovery_fabric.primary.name
  recovery_vault_name  = azurerm_recovery_services_vault.main.name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_site_recovery_protection_container" "secondary" {
  name                 = local.secondary_srpc_name
  recovery_fabric_name = azurerm_site_recovery_fabric.secondary.name
  recovery_vault_name  = azurerm_recovery_services_vault.main.name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_site_recovery_network_mapping" "main" {
  for_each                    = var.network_mapping
  name                        = format("asr-netmapping-%s-to-%s", reverse(split("/", each.key))[0], reverse(split("/", each.value))[0])
  recovery_vault_name         = azurerm_recovery_services_vault.main.name
  resource_group_name         = var.resource_group_name
  source_network_id           = each.key
  source_recovery_fabric_name = azurerm_site_recovery_fabric.primary.name
  target_network_id           = each.value
  target_recovery_fabric_name = azurerm_site_recovery_fabric.secondary.name
}

moved {
  from = azurerm_site_recovery_network_mapping.network_mapping
  to   = azurerm_site_recovery_network_mapping.main
}

resource "azurerm_site_recovery_protection_container_mapping" "main" {
  name                                      = "container-mapping"
  resource_group_name                       = var.resource_group_name
  recovery_vault_name                       = azurerm_recovery_services_vault.main.name
  recovery_fabric_name                      = azurerm_site_recovery_fabric.primary.name
  recovery_source_protection_container_name = azurerm_site_recovery_protection_container.primary.name
  recovery_target_protection_container_id   = azurerm_site_recovery_protection_container.secondary.id
  recovery_replication_policy_id            = azurerm_site_recovery_replication_policy.main.id

  dynamic "automatic_update" {
    for_each = var.container_mapping_automatic_update[*]
    content {
      automation_account_id = automatic_update.value.automation_account_id
      authentication_type   = automatic_update.value.authentication_type
    }
  }
}

moved {
  from = azurerm_site_recovery_protection_container_mapping.container_mapping
  to   = azurerm_site_recovery_protection_container_mapping.main
}

resource "azurerm_site_recovery_replication_policy" "main" {
  name                                                 = var.replication_policy.name
  resource_group_name                                  = var.resource_group_name
  recovery_vault_name                                  = azurerm_recovery_services_vault.main.name
  recovery_point_retention_in_minutes                  = var.replication_policy.recovery_point_retention_in_minutes
  application_consistent_snapshot_frequency_in_minutes = var.replication_policy.application_consistent_snapshot_frequency_in_minutes
}

moved {
  from = azurerm_site_recovery_replication_policy.policy
  to   = azurerm_site_recovery_replication_policy.main
}
