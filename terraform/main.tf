terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.65"
    }
  }
}

provider "azurerm" {
  features {}
}

# -----------------------------
# Resource Group
# -----------------------------
resource "azurerm_resource_group" "rg" {
  name     = "iac-webapp-958ao_group"
  location = "Australia Southeast"
}

# -----------------------------
# App Service Plan
# -----------------------------
resource "azurerm_app_service_plan" "app_plan" {
  name                = "ASP-iacwebapp958aogroup-b82a"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"

  sku {
    tier = "Free"
    size = "F1"
  }
  reserved = true
}

# -----------------------------
# App Service (Web App)
# -----------------------------
resource "azurerm_app_service" "webapp" {
  name                = "iac-webapp-958au2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.app_plan.id

  site_config {
    linux_fx_version = "NODE|22-lts"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "1"
  }
}


