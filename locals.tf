locals {
    location = "North Europe"
    resource_group_name = "rg-train"
    virtual_network = {
        name = "network-train"
        address_space="10.0.0.0/16"
    }
    subnets = [
        {
            name = "app-subnet"
            address_prefixes = ["10.0.0.0/24"]
        },
        {
            name = "web-subnet"
            address_prefixes = ["10.0.1.0/24"]
        }
    ]
}
