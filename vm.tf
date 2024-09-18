# Azure virtual network
    # SubnetA - network interface and vm is depolyed here
    # SubnetB
    # Sometime necessary to divide workloads to diff subnets
locals {
    virtual_network = {
        name = "network_train"
        address_space="10.0.0.0/16"
    }
}

resource "azurerm_virtual_network" "avn" {
    name = local.virtual_network.name
    location = var.location
    resource_group_name = var.resource_group_name
    address_space = [local.virtual_network.address_space]
    depends_on = [
        azurerm_resource_group.appgrp
    ]

    subnet {
        name = "subnetA"
        address_prefixes = ["10.0.0.0/24"]
    }

    subnet {
        name = "subnetB"
        address_prefixes = ["10.0.1.0/24"]
    }

}
