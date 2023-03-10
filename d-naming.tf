data "azurecaf_name" "rsv" {
  name          = var.stack
  resource_type = "azurerm_recovery_services_vault"
  prefixes      = var.name_prefix == "" ? null : [local.name_prefix]
  suffixes      = compact([var.client_name, var.environment, local.name_suffix, var.use_caf_naming ? "" : "rsv"])
  use_slug      = var.use_caf_naming
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "primary_srf" {
  name          = var.stack
  resource_type = "azurerm_resource_group"
  prefixes      = var.name_prefix == "" ? ["primary"] : compact(["primary", local.name_prefix])
  suffixes      = compact([var.client_name, var.environment, local.name_suffix, "srf"])
  use_slug      = false
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "secondary_srf" {
  name          = var.stack
  resource_type = "azurerm_resource_group"
  prefixes      = var.name_prefix == "" ? ["secondary"] : ["secondary", local.name_prefix]
  suffixes      = compact([var.client_name, var.environment, local.name_suffix, "srf"])
  use_slug      = false
}

data "azurecaf_name" "primary_srpc" {
  name          = var.stack
  resource_type = "azurerm_resource_group"
  prefixes      = var.name_prefix == "" ? ["primary"] : compact(["primary", local.name_prefix])
  suffixes      = compact([var.client_name, var.environment, local.name_suffix, "srpc"])
  use_slug      = false
  clean_input   = true
  separator     = "-"
}

data "azurecaf_name" "secondary_srpc" {
  name          = var.stack
  resource_type = "azurerm_resource_group"
  prefixes      = var.name_prefix == "" ? ["secondary"] : ["secondary", local.name_prefix]
  suffixes      = compact([var.client_name, var.environment, local.name_suffix, "srpc"])
  use_slug      = false
}
