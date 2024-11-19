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
    sensitive = true
}

variable "admin_username" {
    type = string
    description = "The admin username for the virtual machine."
}

# Values assigned/managed in the local env vars (prefixwd TF_VAR_) or in terraform.tfvars file
