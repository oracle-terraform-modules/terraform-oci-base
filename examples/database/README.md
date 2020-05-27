[rootvariables]:https://github.com/oracle/terraform-oci-base/blob/master/examples/db/variables.tf
[rootlocals]:https://github.com/oracle/terraform-oci-base/blob/master/examples/db/locals.tf
[terraformoptions]:https://github.com/oracle/terraform-oci-base/blob/master/docs/terraformoptions.adoc
[dbvariables]:https://github.com/oracle/terraform-oci-base/blob/master/examples/db/modules/db/variables.tf
[dbvariables]:https://github.com/oracle/terraform-oci-base/blob/master/examples/db/modules/db/security.tf
[dbsubnet]:https://github.com/oracle/terraform-oci-base/blob/master/examples/db/modules/db/subnets.tf

Example reusing terraform-oci-base and extending to create a db instance from OCI Marketplace

## Create a new Terraform project

As an example, we’ll be using terraform-oci-base to create an Oracle Database on OCI. The steps required are the following:

1. Create a new directory for your project e.g. oracle-database

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
  disable_auto_retries = false
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

  # identity
  oci_base_provider = local.oci_base_provider

  # general oci parameters
  oci_base_general = local.oci_base_general

  # vcn parameters
  oci_base_vcn = local.oci_base_vcn

  # bastion parameters
  oci_base_bastion = local.oci_base_bastion

  # operator server parameters
  oci_base_operator = local.oci_base_operator
}
```

2. Enter appropriate values for terraform.tfvars. Review [Terraform Options][terraformoptions] for reference

## Add your own modules

1. Create your own module e.g. db. In modules directory, create a db directory:

```
mkdir db
```

2. Define the necessary variables, resources (e.g [security lists][dbvariables], [subnets][dbsubnet], [compute][dbcompute]) and [data sources][dbdatasources].

3. Update the [locals.tf][[rootlocals]] to initialize the db variables

4. Add the db module in the main.tf

```
module "db" {
  source = "./modules/db"

  db_identity = local.db_identity

  db_ssh_keys = local.oci_base_ssh_keys

  db_oci_general = local.oci_base_general

  db_bastion = local.db_bastion

  db_network = local.db_network

  db_config = local.db_config
}
```

5. Update your terraform variable file and add the database parameters:

```
# db

db_system_shape = "VM.Standard2.8"

cpu_core_count = 2

db_edition = "ENTERPRISE_EDITION"

db_admin_password = "BEstrO0ng_#12"

db_name = "basedb"

db_home_db_name = "basedb2"

db_version = "19.0.0.0"

db_home_display_name = "basedbhome"

db_disk_redundancy = "HIGH"

db_system_display_name = "basedb_system"

hostname = "myoracledb"

n_character_set = "AL16UTF16"

character_set = "AL32UTF8"

db_workload = "OLTP"

pdb_name = "pdb1"

data_storage_size_in_gb = 256

license_model = "LICENSE_INCLUDED"

node_count = 2

data_storage_percentage = 40
```

## Test access to your database:

1. Login to the OCI Console and note down the IP address of 1 of the database nodes.

2. ssh to the Database node:

```
ssh -i </path/to/private_ssh_key> -J opc<bastion_public_ip_address> opc@<database_private_ip_address>
```

3. Login to your database:

```
sudo su - oracle
sqlplus / as sysdba
```
