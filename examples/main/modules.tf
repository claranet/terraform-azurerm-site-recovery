data "azapi_resource" "vms_infos" {
  name      = "vm01"
  parent_id = "/subscriptions/xxxx-yyyyyy-aaaaaa-zzzzzzz-tttttttt/resourceGroups/rg-primary-region-vm01"
  type      = "Microsoft.Compute/virtualMachines@2022-08-01"

  response_export_values = ["name", "id", "properties.storageProfile.osDisk.managedDisk", "properties.storageProfile.dataDisks", "properties.networkProfile.networkInterfaces"]
}

module "run" {
  source  = "claranet/run/azurerm"
  version = "x.x.x"

  client_name    = var.client_name
  location       = module.secondary_location.location
  location_short = module.secondary_location.location_short
  environment    = var.environment
  stack          = var.stack

  resource_group_name = module.rg.name

  monitoring_function_splunk_token = "xxxxxx"
  monitoring_function_metrics_extra_dimensions = {
    env           = var.environment
    sfx_monitored = "true"
  }

  backup_vm_enabled         = true
  backup_postgresql_enabled = true

  update_center_enabled = true

  extra_tags = {
    foo = "bar"
  }
}

module "site_recovery" {
  source  = "claranet/site-recovery/azurerm"
  version = "x.x.x"

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  location            = module.secondary_location.location
  resource_group_name = module.rg.name

  primary_location       = module.primary_location.location
  primary_location_short = module.primary_location.location_short

  logs_destinations_ids = [
    module.run.log_analytics_workspace_id,
    module.run.logs_storage_account_id,
  ]

  cache_storage_resource_group_name = "rg-cache-storage"

  replicated_vms = {
    vm01 = {
      vm_id                    = data.azapi_resource.vms_infos.output.id
      target_resource_group_id = module.rg.id
      target_network_id        = module.subnet.id

      managed_disks = [
        {
          disk_id   = data.azapi_resource.vms_infos.output.properties.storageProfile.osDisk.managedDisk.id
          disk_type = data.azapi_resource.vms_infos.output.properties.storageProfile.osDisk.managedDisk.storageAccountType
        }
      ]
      network_interfaces = [
        {
          network_interface_id = data.azapi_resource.vms_infos.output.properties.networkProfile.networkInterfaces[0].id
          target_subnet_name   = module.subnet.name
          target_static_ip     = "172.16.2.10"
        }
      ]
    }
  }


  replication_policy = {
    name = "replipol-01"
  }
}
