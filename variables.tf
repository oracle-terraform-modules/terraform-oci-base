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
    create_nat_gateway     = bool
    create_service_gateway = bool
    vcn_cidr               = string
    vcn_dns_label          = string
    vcn_name               = string
  })
  description = "VCN basic parameters"
  default = {
    create_nat_gateway     = false
    create_service_gateway = false
    vcn_cidr               = "10.0.0.0/16"
    vcn_dns_label          = "base"
    vcn_name               = "base"
  }
}

# bastion

variable "oci_base_bastion" {
  type = object({
    availability_domains      = number
    bastion_access            = string
    bastion_shape             = string
    create_bastion            = bool
    enable_instance_principal = bool
    enable_notification       = bool
    newbits                   = number
    netnum                    = number
    notification_endpoint     = string
    notification_protocol     = string
    notification_topic        = string
    ssh_private_key_path      = string
    ssh_public_key_path       = string
    timezone                  = string
  })
  description = "bastion host parameters"
  default = {
    availability_domains      = 1
    bastion_access            = "ANYWHERE"
    bastion_shape             = "VM.Standard.E2.1"
    create_bastion            = false
    enable_instance_principal = false
    enable_notification       = false
    newbits                   = 13
    netnum                    = 32
    notification_endpoint     = ""
    notification_protocol     = "EMAIL"
    notification_topic        = "bastion"
    ssh_private_key_path      = ""
    ssh_public_key_path       = ""
    timezone                  = ""
  }
}
