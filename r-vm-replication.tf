resource "azurerm_site_recovery_replicated_vm" "vm_replication" {
  for_each = var.replicated_vms

  name                           = each.key
  recovery_replication_policy_id = azurerm_site_recovery_replication_policy.policy.id
  recovery_vault_name            = azurerm_recovery_services_vault.asr_vault.name
  resource_group_name            = var.resource_group_name

  source_recovery_fabric_name               = azurerm_site_recovery_fabric.primary.name
  source_recovery_protection_container_name = azurerm_site_recovery_protection_container.primary.name
  source_vm_id                              = each.value.vm_id

  target_recovery_fabric_id               = azurerm_site_recovery_fabric.secondary.id
  target_recovery_protection_container_id = azurerm_site_recovery_protection_container.secondary.id
  target_resource_group_id                = each.value.target_resource_group_id
  target_availability_set_id              = each.value.target_availability_set_id
  target_zone                             = each.value.target_zone
  target_network_id                       = each.value.target_network_id

  dynamic "managed_disk" {
    for_each = toset(each.value.managed_disks)
    content {
      disk_id                    = managed_disk.value.disk_id
      staging_storage_account_id = module.cache_storage_account.id
      target_resource_group_id   = each.value.target_resource_group_id
      target_disk_type           = managed_disk.value.disk_type
      target_replica_disk_type   = managed_disk.value.disk_type
    }
  }

  dynamic "network_interface" {
    for_each = toset(each.value.network_interfaces)
    content {
      source_network_interface_id   = network_interface.value.network_interface_id
      target_subnet_name            = network_interface.value.target_subnet_name
      target_static_ip              = network_interface.value.target_static_ip
      recovery_public_ip_address_id = network_interface.value.recovery_public_ip_address_id

    }
  }

  depends_on = [
    azurerm_site_recovery_network_mapping.network_mapping,
    azurerm_site_recovery_replication_policy.policy
  ]

  lifecycle {
    precondition {
      condition     = !alltrue([each.value.target_availability_set_id != null, each.value.target_zone != null])
      error_message = "You can't define target_availabity_set_id and target_zone."
    }
  }
}
