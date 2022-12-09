module "cache-storage-account" {
  source  = "claranet/storage-account/azurerm"
  version = "7.3.0"

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  resource_group_name      = var.cache_storage_resource_group_name
  location                 = var.primary_location
  location_short           = var.primary_location_short
  logs_destinations_ids    = []
  account_tier             = "Standard"
  account_replication_type = "LRS"
}
