# NOTES

## Terraform workflow:
* Terraform config file/write: Define resources that needs to be deployed.
* Terraform plan: Looks at environment and at the config file and then checks what resources needs to be deployed or changed. Maintains a state-file (what is the current state of your environment).
* Terraform apply: Apply all changes as pr the config file.

Terms:
* Terraform configueration: The complete document in the Terraform lang. Tells terraform how to manage the infrastructure.
* Providers: Plugins for teraform. Helps teraform work with (cloud) providers.

## Terraform editions
* Terraform CLI open source
* Terraform Cloud (SaaS appl.)

## Azure
On Azure we can use a service to provision a resource.

The resource is provisioned in some physical region, w/data center.

Subscription: used for billing resources
Resource group: logical grouping of resources (eg in an application, applying different resources).

## Workflow commands:
* Create a config file, e.g. main.tf.
* Declare a provider (in this case, azurerm).
    * Register an application in Azure portal that is granted access to authorize against our Azure subscription, and which Terraform config file will use to access our Azure subscription.
    * Give the application permission to access: Subscription > Access Control > Add > Add role Assignment > Select 'Contributor' > Select members > Choose the terraform application
* Declare whatever else (in this case a resource, "azurerm_resource_group").
See docs for more information: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

In powershell:
* terraform init: The terraform init command initializes a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control. It is safe to run this command multiple times.
* terraform plan -out main.tfplan -> Creates a plan comparing the declared state to the existing env.
* terraform apply: Executes the actions in the terraform plan.
