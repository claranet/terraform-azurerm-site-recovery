module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  client_name = var.client_name
  location    = var.location
  environment = var.environment
  stack       = var.stack
}

module "primary_location" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = "fr-central"
}

module "secondary_location" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = "fr-south"
}

module "vnet" {
  source  = "claranet/vnet/azurerm"
  version = "x.x.x"

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  resource_group_name = module.rg.resource_group_name

  location       = module.secondary_location.location
  location_short = module.secondary_location.location_short

  vnet_cidr = ["172.16.2.0/24"]
}

module "subnet" {
  source  = "claranet/subnet/azurerm"
  version = "x.x.x"

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  resource_group_name = module.rg.resource_group_name
  location_short      = module.secondary_location.location_short

  virtual_network_name = module.vnet.virtual_network_name
  subnet_cidr_list     = ["172.16.2.0/24"]
}

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

  resource_group_name = module.rg.resource_group_name

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
  resource_group_name = module.rg.resource_group_name

  primary_location       = module.primary_location.location
  primary_location_short = module.primary_location.location_short

  logs_destinations_ids = [
    module.run.log_analytics_workspace_id,
    module.run.logs_storage_account_id
  ]

  cache_storage_resource_group_name = "rg-cache-storage"

  replicated_vms = {
    vm01 = {
      vm_id                    = jsondecode(data.azapi_resource.vms_infos.output).id
      target_resource_group_id = module.rg.resource_group_name
      target_network_id        = module.subnet.subnet_id

      managed_disks = [
        {
          disk_id   = jsondecode(data.azapi_resource.vms_infos.output).properties.storageProfile.osDisk.managedDisk.id
          disk_type = jsondecode(data.azapi_resource.vms_infos.output).properties.storageProfile.osDisk.managedDisk.storageAccountType
        }
      ]
      network_interfaces = [
        {
          network_interface_id = jsondecode(data.azapi_resource.vms_infos.output).properties.networkProfile.networkInterfaces[0].id
          target_subnet_name   = module.subnet.subnet_id
          target_static_ip     = "172.16.2.10"
        }
      ]
    }
  }


  replication_policy = {
    name = "replipol-01"
  }
}
