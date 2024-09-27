terraform {
  required_version = ">= 1.3"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.114"
    }
    azurecaf = {
      source  = "claranet/azurecaf"
      version = "~> 1.1"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.0, < 1.13"
    }
  }
}
