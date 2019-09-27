[rootvariables]:https://github.com/oracle/terraform-oci-base/blob/master/examples/gitlab/variables.tf
[rootlocals]:https://github.com/oracle/terraform-oci-base/blob/master/examples/gitlab/locals.tf
[terraformoptions]:https://github.com/oracle/terraform-oci-base/blob/master/docs/terraformoptions.adoc
[gitlabvariables]:https://github.com/oracle/terraform-oci-base/blob/master/examples/gitlab/modules/gitlab/variables.tf
[gitlabsecurity]:https://github.com/oracle/terraform-oci-base/blob/master/examples/gitlab/modules/gitlab/security.tf
[gitlabsubnet]:https://github.com/oracle/terraform-oci-base/blob/master/examples/gitlab/modules/gitlab/subnets.tf
[gitlabcompute]:https://github.com/oracle/terraform-oci-base/blob/master/examples/gitlab/modules/gitlab/compute.tf
[gitlabdatasources]:https://github.com/oracle/terraform-oci-base/blob/master/examples/gitlab/modules/gitlab/datasources.tf

Example reusing terraform-oci-base and extending to create a Gitlab instance from OCI Marketplace

## Create a new Terraform project

As an example, we’ll be using terraform-oci-base to create a gitlab infrastructure with the image from OCI Marketplace. The steps required are the following:

1. Create a new directory for your project e.g. gitlab

2. Create the following files in root directory of your project:

- variables.tf
- locals.tf
- provider.tf
- main.tf
- terraform.tfvars

3. Define the oci provider

```
provider "oci" {
  tenancy_ocid         = var.tenancy_id
  user_ocid            = var.user_id
  fingerprint          = var.api_fingerprint
  private_key_path     = var.api_private_key_path
  region               = var.region
  disable_auto_retries = var.disable_auto_retries
}
```

4. Create the modules directory

```
mkdir modules
cd modules
```

5. Add the terraform-oci-base module

```
git clone https://github.com/oracle/terraform-oci-base.git base
```

N.B. Cloning will be required until the module is published in Hashicorp's registry

## Define project variables

### Variables to reuse the base module

1. Define the base parameters in the root variables.tf. You can choose to keep the same object-oriented structure like in the base’s variables.tf or keep it flat. 

See [variables.tf][rootvariables] in this directory.

2. Initialize the variables as in [locals.tf][rootlocals]

## Define your modules

1. Define the base module in root main.tf

```
module "base" {
  source = "./modules/base"

  oci_base_identity = local.oci_base_identity

  oci_base_ssh_keys = local.oci_base_ssh_keys

  oci_base_general = local.oci_base_general

  oci_base_vcn = local.oci_base_vcn

  oci_base_bastion = local.oci_base_bastion
}
```

2. Enter appropriate values for terraform.tfvars. Review [Terraform Options][terraformoptions] for reference

## Add your own modules

1. Create your own module e.g. gitlab. In modules directory, create a gitlab directory:

```
mkdir gitlab
```

2. Define the necessary variables, resources (e.g [security lists][gitlabsecurity], [subnets][gitlabsubnet], [compute][gitlabcompute]) and [data sources][gitlabdatasources].

3. Update the [locals.tf][[rootlocals]] to initialize the gitlab variables

4. Add the gitlab module in the main.tf

```
module "gitlab" {
  source = "./modules/gitlab"

  gitlab_identity = local.gitlab_identity

  gitlab_ssh_keys = local.oci_base_ssh_keys

  gitlab_oci_general = local.oci_base_general

  gitlab_bastion = local.gitlab_bastion

  gitlab_network = local.gitlab_network

  gitlab_config = local.gitlab_config
}
```