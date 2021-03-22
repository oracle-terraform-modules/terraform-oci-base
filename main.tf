# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "2.0.0"

  # provider parameters
  region = var.oci_base_provider.region

  # general oci parameters
  compartment_id = var.oci_base_general.compartment_id
  label_prefix   = var.oci_base_general.label_prefix

  # vcn parameters
  internet_gateway_enabled = var.oci_base_vcn.internet_gateway_enabled
  nat_gateway_enabled      = var.oci_base_vcn.nat_gateway_enabled
  service_gateway_enabled  = var.oci_base_vcn.service_gateway_enabled
  tags                     = var.oci_base_vcn.tags
  vcn_cidr                 = var.oci_base_vcn.vcn_cidr
  vcn_dns_label            = var.oci_base_vcn.vcn_dns_label
  vcn_name                 = var.oci_base_vcn.vcn_name
}

module "bastion" {
  source  = "oracle-terraform-modules/bastion/oci"
  version = "2.0.0"

  # provider identity parameters
  api_fingerprint      = var.oci_base_provider.api_fingerprint
  api_private_key_path = var.oci_base_provider.api_private_key_path
  region               = var.oci_base_provider.region
  tenancy_id           = var.oci_base_provider.tenancy_id
  user_id              = var.oci_base_provider.user_id

  # general oci parameters
  compartment_id = var.oci_base_general.compartment_id
  label_prefix   = var.oci_base_general.label_prefix

  # network parameters

  availability_domain = var.oci_base_bastion.availability_domain
  bastion_access      = var.oci_base_bastion.bastion_access
  ig_route_id         = module.vcn.ig_route_id
  netnum              = var.oci_base_bastion.netnum
  newbits             = var.oci_base_bastion.newbits
  vcn_id              = module.vcn.vcn_id

  # bastion parameters
  bastion_enabled     = var.oci_base_bastion.bastion_enabled
  bastion_image_id    = var.oci_base_bastion.bastion_image_id
  bastion_shape       = var.oci_base_bastion.bastion_shape
  bastion_upgrade     = var.oci_base_bastion.bastion_upgrade
  ssh_public_key      = var.oci_base_bastion.ssh_public_key
  ssh_public_key_path = var.oci_base_bastion.ssh_public_key_path
  timezone            = var.oci_base_bastion.timezone

  # notification
  notification_enabled  = var.oci_base_bastion.notification_enabled
  notification_endpoint = var.oci_base_bastion.notification_endpoint
  notification_protocol = var.oci_base_bastion.notification_protocol
  notification_topic    = var.oci_base_bastion.notification_topic

  # tags
  tags = var.oci_base_bastion.tags
}

module "operator" {
  source  = "oracle-terraform-modules/operator/oci"
  version = "2.1.0"

  # provider identity parameters
  api_fingerprint      = var.oci_base_provider.api_fingerprint
  api_private_key_path = var.oci_base_provider.api_private_key_path
  region               = var.oci_base_provider.region
  tenancy_id           = var.oci_base_provider.tenancy_id
  user_id              = var.oci_base_provider.user_id

  # general oci parameters
  compartment_id = var.oci_base_general.compartment_id
  label_prefix   = var.oci_base_general.label_prefix

  # network parameters
  availability_domain = var.oci_base_operator.availability_domain
  nat_route_id        = module.vcn.nat_route_id
  netnum              = var.oci_base_operator.netnum
  newbits             = var.oci_base_operator.newbits
  vcn_id              = module.vcn.vcn_id

  # operator parameters
  operator_enabled            = var.oci_base_operator.operator_enabled
  operator_image_id           = var.oci_base_operator.operator_image_id
  operator_instance_principal = var.oci_base_operator.enable_instance_principal
  operator_shape              = var.oci_base_operator.operator_shape
  operating_system_version    = var.oci_base_operator.operating_system_version
  operator_upgrade            = var.oci_base_operator.operator_upgrade
  ssh_public_key              = var.oci_base_operator.ssh_public_key
  ssh_public_key_path         = var.oci_base_operator.ssh_public_key_path
  timezone                    = var.oci_base_operator.timezone

  # notification
  notification_enabled  = var.oci_base_operator.notification_enabled
  notification_endpoint = var.oci_base_operator.notification_endpoint
  notification_protocol = var.oci_base_operator.notification_protocol
  notification_topic    = var.oci_base_operator.notification_topic

  # tags
  tags = var.oci_base_operator.tags
}
