terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.10.0"
    }
  }
}

# Authenticate against Azure
provider "azurerm" {
    features {}
    subscription_id = var.subscription_id_train
    tenant_id = var.tenant_id_train
    client_id = var.client_id_train
    client_secret = var.client_secret_train
}

# Create a resource group
resource "azurerm_resource_group" "appgrp" { # This name is given within the config file
    name = var.resource_group_name # the actual name of ther resource we try to deploy
    location = var.location
}
