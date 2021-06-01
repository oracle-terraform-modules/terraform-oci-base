# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

module "vcn" {
  source  = "oracle-terraform-modules/vcn/oci"
  version = "2.2.0"

  # provider parameters
  region = var.region

  # general oci parameters
  compartment_id = var.compartment_id
  label_prefix   = var.label_prefix
  tags           = var.vcn_tags

  # vcn parameters
  create_drg               = var.create_drg
  internet_gateway_enabled = var.create_internet_gateway
  nat_gateway_enabled      = var.create_nat_gateway
  service_gateway_enabled  = var.create_service_gateway
  drg_display_name         = var.drg_display_name
  lockdown_default_seclist = var.lockdown_default_seclist
  vcn_cidr                 = var.vcn_cidr
  vcn_dns_label            = var.vcn_dns_label
  vcn_name                 = var.vcn_name

  # routing rules
  internet_gateway_route_rules = var.internet_gateway_route_rules
  nat_gateway_route_rules      = var.nat_gateway_route_rules
}

module "bastion" {
  source  = "oracle-terraform-modules/bastion/oci"
  version = "2.1.0"

  # provider identity parameters
  api_fingerprint      = var.api_fingerprint
  api_private_key_path = var.api_private_key_path
  region               = var.region
  tenancy_id           = var.tenancy_id
  user_id              = var.user_id

  # general oci parameters
  compartment_id = var.compartment_id
  label_prefix   = var.label_prefix

  # network parameters
  availability_domain = var.bastion_availability_domain
  bastion_access      = var.bastion_access
  ig_route_id         = module.vcn.ig_route_id
  netnum              = var.netnum["bastion"]
  newbits             = var.newbits["bastion"]
  vcn_id              = module.vcn.vcn_id

  # bastion parameters
  bastion_enabled                  = var.create_bastion
  bastion_image_id                 = var.bastion_image_id
  bastion_operating_system_version = var.bastion_operating_system_version
  bastion_shape                    = var.bastion_shape
  bastion_state                    = var.bastion_state
  bastion_upgrade                  = var.bastion_upgrade
  timezone                         = var.bastion_timezone

  # ssh keys
  ssh_public_key                   = var.ssh_public_key
  ssh_public_key_path              = var.ssh_public_key_path

  # notification
  notification_enabled  = var.bastion_notification
  notification_endpoint = var.bastion_notification_endpoint
  notification_protocol = var.bastion_notification_protocol
  notification_topic    = var.bastion_notification_topic

  # tags
  tags = var.bastion_tags
}

module "operator" {
  source  = "oracle-terraform-modules/operator/oci"
  version = "2.1.1"

  # provider identity parameters
  api_fingerprint      = var.api_fingerprint
  api_private_key_path = var.api_private_key_path
  region               = var.region
  tenancy_id           = var.tenancy_id
  user_id              = var.user_id

  # general oci parameters
  compartment_id = var.compartment_id
  label_prefix   = var.label_prefix

  # network parameters
  availability_domain = var.operator_availability_domain
  nat_route_id        = module.vcn.nat_route_id
  netnum              = var.netnum["operator"]
  newbits             = var.newbits["operator"]
  vcn_id              = module.vcn.vcn_id

  # operator parameters
  operator_enabled            = var.create_operator
  operator_image_id           = var.operator_image_id
  operator_instance_principal = var.operator_instance_principal
  # operator_nsg_ids            = var.operator_nsg_ids
  operating_system_version    = var.operator_os_version
  operator_shape              = var.operator_shape
  # operator_state = var.operator_state
  timezone            = var.operator_timezone
  operator_upgrade    = var.operator_upgrade
  ssh_public_key      = var.ssh_public_key
  ssh_public_key_path = var.ssh_public_key_path


  # notification
  notification_enabled  = var.operator_notification
  notification_endpoint = var.operator_notification_endpoint
  notification_protocol = var.operator_notification_protocol
  notification_topic    = var.operator_notification_topic

  # tags
  tags = var.operator_tags
}
