# Azure Site Recovery
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/site-recovery/azurerm/)

Common Azure terraform module to create an [Azure Site Recovery](https://learn.microsoft.com/en-us/azure/site-recovery/site-recovery-overview) configuration with its cache [Storage Account](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview).

## Naming

Resource naming is based on the [Microsoft CAF naming convention best practices](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming). Legacy naming is available by setting the parameter `use_caf_naming` to false.
We rely on [the official Terraform Azure CAF naming provider](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/azurecaf_name) to generate resource names.

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | AzureRM version |
| -------------- | ----------------- | --------------- |
| >= 7.x.x       | 1.3.x             | >= 3.0          |
| >= 6.x.x       | 1.x               | >= 3.0          |
| >= 5.x.x       | 0.15.x            | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   | >= 2.0          |
| >= 3.x.x       | 0.12.x            | >= 2.0          |
| >= 2.x.x       | 0.12.x            | < 2.0           |
| <  2.x.x       | 0.11.x            | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

```hcl
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
```

## Providers

| Name | Version |
|------|---------|
| azapi | ~> 1.0, < 1.13 |
| azurecaf | ~> 1.1 |
| azurerm | ~> 3.39 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| cache\_storage\_account | claranet/storage-account/azurerm | ~> 7.12.0 |
| diagnostics\_recovery\_vault | claranet/diagnostic-settings/azurerm | ~> 6.5.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_recovery_services_vault.asr_vault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/recovery_services_vault) | resource |
| [azurerm_site_recovery_fabric.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_fabric) | resource |
| [azurerm_site_recovery_fabric.secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_fabric) | resource |
| [azurerm_site_recovery_network_mapping.network_mapping](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_network_mapping) | resource |
| [azurerm_site_recovery_protection_container.primary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container) | resource |
| [azurerm_site_recovery_protection_container.secondary](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container) | resource |
| [azurerm_site_recovery_protection_container_mapping.container_mapping](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_protection_container_mapping) | resource |
| [azurerm_site_recovery_replicated_vm.vm_replication](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_replicated_vm) | resource |
| [azurerm_site_recovery_replication_policy.policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/site_recovery_replication_policy) | resource |
| [azapi_resource.nic_interfaces](https://registry.terraform.io/providers/azure/azapi/latest/docs/data-sources/resource) | data source |
| [azurecaf_name.primary_srf](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.primary_srpc](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.rsv](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.secondary_srf](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |
| [azurecaf_name.secondary_srpc](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/data-sources/name) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| cache\_storage\_account\_custom\_diagnostic\_settings\_name | Custom name of the diagnostics settings of the cache storage account, name will be 'default' if not set. | `string` | `"default"` | no |
| cache\_storage\_account\_logs\_categories | Log categories to send to destinations. | `list(string)` | `null` | no |
| cache\_storage\_account\_logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination for the cache Storage Account.<br>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br>If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formatted string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character. | `list(string)` | `[]` | no |
| cache\_storage\_account\_logs\_metrics\_categories | Metrics categories to send to destinations. | `list(string)` | `null` | no |
| cache\_storage\_advanced\_threat\_protection\_enabled | Boolean flag which controls if advanced threat protection is enabled, see [documentation](https://docs.microsoft.com/en-us/azure/storage/common/storage-advanced-threat-protection?tabs=azure-portal) for more information. | `bool` | `true` | no |
| cache\_storage\_allowed\_cidrs | List of public IPs allowed to access to the cache Storage Account. | `list(string)` | `[]` | no |
| cache\_storage\_allowed\_subnet\_ids | List of subnet IDs allowed to access to the cache Storage Account. All subnets of replicated VMs are dynamically fetched. | `list(string)` | `[]` | no |
| cache\_storage\_custom\_name | Custom name for cache Storage Account. | `string` | `null` | no |
| cache\_storage\_resource\_group\_name | Resource Group name in which to deploy the cache Storage Account. | `string` | n/a | yes |
| client\_name | Client name/account used in naming. | `string` | n/a | yes |
| default\_tags\_enabled | Option to enable or disable default tags. | `bool` | `true` | no |
| environment | Project environment. | `string` | n/a | yes |
| extra\_tags | Additional tags to associate with your Azure Storage Account. | `map(string)` | `{}` | no |
| location | Azure region to use. | `string` | n/a | yes |
| logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination.<br>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br>If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formatted string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character. | `list(string)` | n/a | yes |
| name\_prefix | Optional prefix for the generated name. | `string` | `""` | no |
| name\_suffix | Optional suffix for the generated name. | `string` | `""` | no |
| network\_mapping | Virtual Network mapping as `{ "source VNet ID" => "destination VNet ID" }.` | `map(string)` | `{}` | no |
| primary\_location | Location of source resources to be replicated. | `string` | n/a | yes |
| primary\_location\_short | Short name of the source location. | `string` | n/a | yes |
| primary\_site\_recovery\_fabric\_custom\_name | Custom name for Primary Azure Site Recovery Fabric. | `string` | `""` | no |
| primary\_site\_recovery\_protection\_container\_custom\_name | Custom name for Primary Azure Site Recovery Protection Container. | `string` | `""` | no |
| recovery\_vault\_custom\_name | Custom name for Azure Recovery Vault. | `string` | `""` | no |
| recovery\_vault\_logs\_destinations\_ids | List of destination resources IDs for logs diagnostic destination for the Recovery Vault.<br>Can be `Storage Account`, `Log Analytics Workspace` and `Event Hub`. No more than one of each can be set.<br>If you want to specify an Azure EventHub to send logs and metrics to, you need to provide a formatted string with both the EventHub Namespace authorization send ID and the EventHub name (name of the queue to use in the Namespace) separated by the `|` character. | `list(string)` | `[]` | no |
| replicated\_vms | Map of VMs to replicate with Azure Site Recovery. VM Name is expected as a key. | <pre>map(<br>    object({<br>      vm_id                      = string<br>      target_resource_group_id   = string<br>      target_availability_set_id = optional(string, null)<br>      target_zone                = optional(number, null)<br>      target_network_id          = string<br><br>      managed_disks = list(object({<br>        disk_id   = string<br>        disk_type = string<br>      }))<br><br>      network_interfaces = list(object({<br>        network_interface_id          = string<br>        target_subnet_name            = string<br>        target_static_ip              = optional(string, null)<br>        recovery_public_ip_address_id = optional(string, null)<br>      }))<br>  }))</pre> | n/a | yes |
| replication\_policy | Site recovery replication policy. | <pre>object({<br>    name                                                 = string<br>    recovery_point_retention_in_minutes                  = optional(number, 1440) # 24h<br>    application_consistent_snapshot_frequency_in_minutes = optional(number, 240)  # 4h<br>  })</pre> | n/a | yes |
| resource\_group\_name | Resource group name | `string` | n/a | yes |
| secondary\_site\_recovery\_fabric\_custom\_name | Custom name for Secondary Azure Site Recovery Fabric. | `string` | `""` | no |
| secondary\_site\_recovery\_protection\_container\_custom\_name | Custom name for Secondary Azure Site Recovery Protection Container. | `string` | `""` | no |
| stack | Project stack name. | `string` | n/a | yes |
| use\_caf\_naming | Use the Azure CAF naming provider to generate default resource name. `custom_rg_name` override this if set. Legacy default name is used if this is set to `false`. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| cache\_storage\_account | Cache Storage Account. |
| primary\_fabric | Fabric of the source resources. Primary region. |
| recovery\_vault | Azure Recovery Services Vault. |
| replicated\_vms | Replicated virtual machines. |
| replication\_policy | Replication policy. |
| secondary\_fabric | Fabric of the replicated resources. Secondary region. |
<!-- END_TF_DOCS -->
## Related documentation

Azure Site Recovery documentation: [learn.microsoft.com/en-us/azure/site-recovery/site-recovery-overview](https://learn.microsoft.com/en-us/azure/site-recovery/site-recovery-overview)
