terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.70.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "rg-acmp-final"
    storage_account_name = "acmp2400storageaccount"
    container_name = "big-tf-state-acmp2400"
    use_azuread_auth = true
  }  
}

provider "azurerm" {
  features {}
}

resource "azurerm_container_registry" "JosephPringle-acr" {
  name = "acrJosephPringleacmp2400"
  resource_group_name = "rg-JosephPringle"
  location = "Central US"
  sku = "Basic"
  admin_enabled = false
}

resource "azurerm_container_group" "aci-JosephPringle-acmp" {
  name                = "aci-JosephPringle-acmp"
  location            = "Central US"
  resource_group_name = "rg-JosephPringle"
  ip_address_type     = "Public"
  dns_name_label      = "aci-JosephPringle-acmp"
  os_type             = "Linux"

  container {
    name   = "final-app"
    image  = "mcr.microsoft.com/azuredocs/final:latest"
    cpu    = "0.5"
    memory = "1.5"

    ports {
      port     = 443
      protocol = "TCP"
    }
  }
