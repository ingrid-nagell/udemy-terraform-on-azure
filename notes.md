# Notes

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
* terraform init -upgrade
* terraform plan -out main.tfplan -> Creates a plan comparing the declared state to the existing env.
* terraform apply main.tfplan: Executes the actions in the terraform plan.
* terraform destroy

## Caveats
Terraform does not execute in the order of the script, nor does it wait for dependent resources to be created in sequence by Azure.

## Add dependencies
Important to add the depend_on() to blocks when depends on other resource, but does not reference it.

## Variables
* Locals
* Input (variable() + .tfvars)
* Output


## Output values
"Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use. Output values are similar to return values in programming languages."


## .tfstate
"Terraform must store state about your managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures."

## Input variables
"Input variables let you customize aspects of Terraform modules without altering the module's own source code. This functionality allows you to share modules across different Terraform configurations, making your module composable and reusable.

When you declare variables in the root module of your configuration, you can set their values using CLI options and environment variables. When you declare them in child modules, the calling module should pass values in the module block."

### .tfvars
A nice article on .tfvars files:
https://spacelift.io/blog/terraform-tfvars

sensiteive bool option rm print
## Terraform validate
"The terraform validate command validates the configuration files in a directory, referring only to the configuration and not accessing any remote services such as remote state, provider APIs, etc.

Validate runs checks that verify whether a configuration is syntactically valid and internally consistent, regardless of any provided variables or existing state. It is thus primarily useful for general verification of reusable modules, including correctness of attribute names and value types."
