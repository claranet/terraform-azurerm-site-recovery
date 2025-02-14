module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location       = module.azure_region.location
  location_short = module.azure_region.location_short
  client_name    = var.client_name
  environment    = var.environment
  stack          = var.stack
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

  resource_group_name = module.rg.name

  location       = module.secondary_location.location
  location_short = module.secondary_location.location_short

  cidrs = ["172.16.2.0/24"]
}

module "subnet" {
  source  = "claranet/subnet/azurerm"
  version = "x.x.x"

  client_name = var.client_name
  environment = var.environment
  stack       = var.stack

  resource_group_name = module.rg.name
  location_short      = module.secondary_location.location_short

  virtual_network_name = module.vnet.name
  cidrs                = ["172.16.2.0/24"]
}
