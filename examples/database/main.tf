# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

module "base" {
  source = "./modules/base"

  # provider
  oci_base_provider = local.oci_base_provider

  # general oci parameters
  oci_base_general = local.oci_base_general

  # vcn parameters
  oci_base_vcn = local.oci_base_vcn

  # bastion parameters
  oci_base_bastion = local.oci_base_bastion

  # admin parameters
  oci_base_admin = local.oci_base_admin
}

module "db" {
  source = "./db"

  db_identity = local.db_identity

  # since they have the same signature, we can reuse that
  db_ssh_keys = local.oci_base_ssh_keys

  db_oci_general = local.db_oci_general

  db_bastion = local.db_bastion

  db_network = local.db_network

  db_config = local.db_config
}
