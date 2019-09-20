# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

locals {
  oci_base_identity = {
    api_fingerprint      = var.api_fingerprint
    api_private_key_path = var.api_private_key_path
    compartment_name     = var.compartment_name
    compartment_id       = var.compartment_id
    tenancy_id           = var.tenancy_id
    user_id              = var.user_id
  }
  oci_base_ssh_keys = {
    ssh_private_key_path = var.ssh_private_key_path
    ssh_public_key_path  = var.ssh_public_key_path
  }
  oci_base_general = {
    disable_auto_retries = var.disable_auto_retries
    label_prefix         = var.label_prefix
    region               = var.region
  }
  oci_base_vcn = {
    vcn_cidr               = var.vcn_cidr
    vcn_dns_label          = var.vcn_dns_label
    vcn_name               = var.vcn_name
    create_nat_gateway     = var.create_nat_gateway
    nat_gateway_name       = var.nat_gateway_name
    create_service_gateway = var.create_service_gateway
    service_gateway_name   = var.service_gateway_name
  }
  oci_base_bastion = {
    newbits                        = var.newbits["bastion"]
    subnets                        = var.subnets["bastion"]
    bastion_shape                  = var.bastion_shape
    create_bastion                 = var.create_bastion
    bastion_access                 = var.bastion_access
    enable_instance_principal      = var.enable_instance_principal
    image_id                       = var.image_id
    image_operating_system         = var.image_operating_system
    image_operating_system_version = var.image_operating_system_version
    availability_domains           = var.availability_domains["bastion"]
    bastion_package_update         = var.bastion_package_update
    bastion_package_update         = var.bastion_package_upgrade
  }

  gitlab_identity = {
    compartment_id = var.compartment_id
    tenancy_id     = var.tenancy_id
  }

  gitlab_bastion = {
    bastion_public_ip      = module.base.bastion_public_ip
    create_bastion         = var.create_bastion
    image_operating_system = var.image_operating_system
  }

  gitlab_network = {
    ig_route_id                = module.base.ig_route_id
    is_service_gateway_enabled = var.create_service_gateway
    nat_route_id               = module.base.nat_gateway_id
    newbits                    = var.newbits
    subnets                    = var.subnets
    vcn_cidr                   = var.vcn_cidr
    vcn_id                     = module.base.vcn_id
  }

  gitlab_config = {
    gitlab_shape = var.gitlab_shape
    gitlab_url   = var.gitlab_url
  }
}
