# Copyright 2017, 2021, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

locals {
  oci_base_provider = {
    api_fingerprint      = var.api_fingerprint
    api_private_key_path = var.api_private_key_path
    region               = var.region
    tenancy_id           = var.tenancy_id
    user_id              = var.user_id
  }

  oci_base_general = {
    compartment_id = var.compartment_id
    label_prefix   = var.label_prefix
  }

  oci_base_ssh_keys = {
    ssh_private_key_path = var.ssh_private_key_path
    ssh_public_key_path  = var.ssh_public_key_path
  }

  oci_base_vcn = {
    internet_gateway_enabled = var.create_internet_gateway
    nat_gateway_enabled      = var.create_nat_gateway
    service_gateway_enabled  = var.create_service_gateway
    tags                     = var.vcn_tags
    vcn_cidr                 = var.vcn_cidr
    vcn_dns_label            = var.vcn_dns_label
    vcn_name                 = var.vcn_name
  }

  oci_base_bastion = {
    bastion_enabled                  = var.create_bastion
    bastion_image_id                 = var.bastion_image_id
    bastion_operating_system_version = var.bastion_operating_system_version
    bastion_shape                    = var.bastion_shape
    bastion_state                    = var.bastion_state
    bastion_upgrade                  = var.bastion_upgrade
    timezone                         = var.bastion_timezone

    ssh_public_key      = var.ssh_public_key
    ssh_public_key_path = var.ssh_public_key_path

    notification_enabled  = var.bastion_notification
    notification_endpoint = var.bastion_notification_endpoint
    notification_protocol = var.bastion_notification_protocol
    notification_topic    = var.bastion_notification_topic

    tags = var.bastion_tags
  }

  oci_base_operator = {
    availability_domain = var.operator_availability_domain
    nat_route_id        = module.vcn.nat_route_id
    netnum              = var.netnum["operator"]
    newbits             = var.newbits["operator"]
    vcn_id              = module.vcn.vcn_id

    operator_enabled            = var.create_operator
    operator_image_id           = var.operator_image_id
    operator_instance_principal = var.operator_instance_principal
    # operator_nsg_ids            = var.operator_nsg_ids
    operating_system_version = var.operator_os_version
    operator_shape           = var.operator_shape
    # operator_state = var.operator_state
    timezone            = var.operator_timezone
    operator_upgrade    = var.operator_upgrade
    ssh_public_key      = var.ssh_public_key
    ssh_public_key_path = var.ssh_public_key_path

    notification_enabled  = var.operator_notification
    notification_endpoint = var.operator_notification_endpoint
    notification_protocol = var.operator_notification_protocol
    notification_topic    = var.operator_notification_topic

    tags = var.operator_tags
  }

  db_identity = {
    compartment_id = var.compartment_id
    tenancy_id     = var.tenancy_id
  }

  db_oci_general = {
    ad_names            = module.base.ad_names
    availability_domain = 1
    label_prefix        = var.label_prefix
    region              = var.region
  }

  db_bastion = {
    bastion_public_ip = module.base.bastion_public_ip
  }

  db_network = {
    ig_route_id             = module.base.ig_route_id
    service_gateway_enabled = var.create_service_gateway
    nat_route_id            = module.base.nat_route_id
    netnum                  = var.netnum
    newbits                 = var.newbits
    vcn_cidr                = var.vcn_cidr
    vcn_id                  = module.base.vcn_id
  }

  db_config = {
    db_system_shape         = var.db_system_shape
    cpu_core_count          = var.cpu_core_count
    db_edition              = var.db_edition
    db_admin_password       = var.db_admin_password
    db_name                 = var.db_name
    db_home_db_name         = var.db_home_db_name
    db_version              = var.db_version
    db_home_display_name    = var.db_home_display_name
    db_disk_redundancy      = var.db_disk_redundancy
    db_system_display_name  = var.db_system_display_name
    hostname                = var.hostname
    n_character_set         = var.n_character_set
    character_set           = var.character_set
    db_workload             = var.db_workload
    pdb_name                = var.pdb_name
    data_storage_size_in_gb = var.data_storage_size_in_gb
    license_model           = var.license_model
    node_count              = var.node_count
    data_storage_percentage = var.data_storage_percentage
  }

}
