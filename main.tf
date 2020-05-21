# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# module "vcn" {
#   source       = "./modules/vcn"
#   oci_base_vcn = local.oci_base_vcn
#   tagging      = local.tagging
# }

module "vcn" {
  source                   = "github.com/oracle-terraform-modules/terraform-oci-vcn?ref=v1.0.0"
  compartment_id           = var.oci_base_general.compartment_id
  freeform_tags            = var.tagging.networktag
  internet_gateway_enabled = var.oci_base_vcn.internet_gateway_enabled
  label_prefix             = var.oci_base_general.label_prefix
  nat_gateway_enabled      = var.oci_base_vcn.nat_gateway_enabled
  region                   = var.oci_base_provider.region
  service_gateway_enabled  = var.oci_base_vcn.service_gateway_enabled
  vcn_cidr                 = var.oci_base_vcn.vcn_cidr
  vcn_dns_label            = var.oci_base_vcn.vcn_dns_label
  vcn_name                 = var.oci_base_vcn.vcn_name
}

module "bastion" {
  source                   = "./modules/bastion"
  oci_bastion_provider     = var.oci_base_provider
  oci_bastion_general      = local.oci_base_general
  oci_bastion_network      = local.oci_bastion_network
  oci_bastion              = local.oci_bastion
  oci_bastion_notification = local.oci_bastion_notification
  tagging                  = local.tagging
}

module "admin" {
  source                 = "./modules/admin"
  oci_admin_provider     = var.oci_base_provider
  oci_admin_general      = local.oci_base_general
  oci_admin_network      = local.oci_admin_network
  oci_admin              = local.oci_admin
  oci_admin_notification = local.oci_admin_notification
  tagging                = local.tagging
}
