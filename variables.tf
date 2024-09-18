# auth:
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

# resources:
variable "location" {
    default = "North Europe"
    type = string
}

variable "resource_group_name" {
    type = string
}

# Values assigned/managed in the local env vars or in terraform.tfvars file
