locals {
  location = "North Europe"
}

variable "subscription_id_train" {
    type = string
}

variable "tenant_id_train" {
    type = string
}

variable "client_id_train" {
    type = string
}

variable "client_secret_train" {
    type = string
}

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
    name = "app-grp" # the actual name of ther esource we try to deploy
    location = local.location
}

resource "azurerm_storage_account" "storageaccount_train" {
    name = "storagetrain232324322"
    resource_group_name = "appgrp"
    location = local.location
    account_tier = "Standard"
    account_replication_type = "LRS"
}
