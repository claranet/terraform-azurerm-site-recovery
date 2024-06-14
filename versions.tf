terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.102"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.1"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.0, < 1.13"
    }
  }
}
