terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "4.0.1"
    }
  }
}

# Authenticate against Azure
provider "azurerm" {
    subscription_id = var.subscription_id_train
    tenant_id = var.tenant_id_train
    client_id = var.client_id_train
    client_secret = var.client_secret_train
    features {}
}

# Create a resource group
resource "azurerm_resource_group" "appgrp" { # This name is given within the config file
    name = var.resource_group_name # the actual name of ther esource we try to deploy
    location = var.location
}
