# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

module "base" {
  source = "./modules/base"

  # identity
  oci_base_identity = local.oci_base_identity

  # ssh keys
  oci_base_ssh_keys = local.oci_base_ssh_keys

  # general oci parameters
  oci_base_general = local.oci_base_general

  # vcn parameters
  oci_base_vcn = local.oci_base_vcn

  # bastion parameters
  oci_base_bastion = local.oci_base_bastion
}

module "gitlab" {
  source = "./modules/gitlab"

  gitlab_identity = local.gitlab_identity

  # since they have the same signature, we can reuse that
  gitlab_ssh_keys = local.oci_base_ssh_keys

  gitlab_oci_general = local.oci_base_general

  gitlab_bastion = local.gitlab_bastion

  gitlab_network = local.gitlab_network

  gitlab_config = local.gitlab_config
}
