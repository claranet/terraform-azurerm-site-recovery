terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.9"
    }
    azurecaf = {
      source  = "claranet/azurecaf"
      version = "~> 1.2.28"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.0, < 1.13"
    }
  }
}
