module "cache_storage_account" {
  source  = "claranet/storage-account/azurerm"
  version = "~> 7.3.0"

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  resource_group_name = var.cache_storage_resource_group_name

  storage_account_custom_name = var.cache_storage_custom_name

  location                 = var.primary_location
  location_short           = var.primary_location_short
  logs_destinations_ids    = []
  account_tier             = "Standard"
  account_replication_type = "LRS"
  storage_blob_data_protection = {
    change_feed_enabled             = false
    container_point_in_time_restore = false
    versioning_enabled              = false
  }

  advanced_threat_protection_enabled = var.cache_storage_advanced_threat_protection_enabled

  subnet_ids    = var.cache_storage_allowed_subnet_ids
  allowed_cidrs = var.cache_storage_allowed_cidrs
}
