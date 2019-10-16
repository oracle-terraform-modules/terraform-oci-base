# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

# Identity and access parameters

variable "oci_base_identity" {
  type = object({
    api_fingerprint      = string
    api_private_key_path = string
    compartment_id       = string
    tenancy_id           = string
    user_id              = string
  })
  description = "identity and provider parameters"
}

# ssh keys

variable "oci_base_ssh_keys" {
  type = object({
    ssh_private_key_path = string
    ssh_public_key_path  = string
  })
  description = "ssh keys for bastion"
}

# general oci parameters

variable "oci_base_general" {
  type = object({
    label_prefix = string
    region       = string
  })
  description = "general oci parameters"
  default = {
    label_prefix = "base"
    region       = ""
  }
}

# networking parameters

variable "oci_base_vcn" {
  type = object({
    vcn_cidr               = string
    vcn_dns_label          = string
    vcn_name               = string
    create_nat_gateway     = bool
    create_service_gateway = bool
  })
  description = "VCN basic parameters"
  default = {
    vcn_cidr               = "10.0.0.0/16"
    vcn_dns_label          = "base"
    vcn_name               = "base"
    create_nat_gateway     = false
    create_service_gateway = false
  }
}

# bastion

variable "oci_base_bastion" {
  type = object({
    newbits                   = number
    subnets                   = number
    bastion_shape             = string
    create_bastion            = bool
    timezone                  = string
    bastion_access            = string
    enable_instance_principal = bool
    availability_domains      = number
    enable_notification       = bool
    notification_endpoint     = string
    notification_protocol     = string
    notification_topic        = string
  })
  description = "bastion host parameters"
  default = {
    newbits                   = 13
    subnets                   = 32
    bastion_shape             = "VM.Standard.E2.1"
    create_bastion            = false
    timezone                  = ""
    bastion_access            = "ANYWHERE"
    enable_instance_principal = false
    availability_domains      = 1
    enable_notification       = false
    notification_endpoint     = ""
    notification_protocol     = "EMAIL"
    notification_topic        = "bastion"
  }
}
