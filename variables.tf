# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

# provider parameters

variable "oci_base_provider" {
  type = object({
    api_fingerprint      = string
    api_private_key_path = string
    region               = string
    tenancy_id           = string
    user_id              = string
  })
  description = "oci provider parameters"
}

# general oci parameters

variable "oci_base_general" {
  type = object({
    compartment_id = string
    label_prefix   = string
  })
  description = "general oci parameters"
}

# networking parameters

variable "oci_base_vcn" {
  type = object({
    internet_gateway_enabled = bool
    nat_gateway_enabled      = bool
    service_gateway_enabled  = bool
    tags                     = map(any)
    vcn_cidr                 = string
    vcn_dns_label            = string
    vcn_name                 = string
  })
  description = "VCN parameters"
  default = {
    internet_gateway_enabled = true
    nat_gateway_enabled      = true
    service_gateway_enabled  = true
    tags                     = null
    vcn_cidr                 = "10.0.0.0/16"
    vcn_dns_label            = ""
    vcn_name                 = ""
  }
}

# bastion

variable "oci_base_bastion" {
  type = object({
    availability_domain   = number
    bastion_access        = string
    bastion_enabled       = bool
    bastion_image_id      = string
    bastion_shape         = string
    bastion_upgrade       = bool
    netnum                = number
    newbits               = number
    notification_enabled  = bool
    notification_endpoint = string
    notification_protocol = string
    notification_topic    = string
    ssh_private_key_path  = string
    ssh_public_key_path   = string
    tags                  = map(any)
    timezone              = string
  })
  description = "bastion host parameters"
  default = {
    availability_domain   = 1
    bastion_access        = "ANYWHERE"
    bastion_enabled       = false
    bastion_image_id      = "Autonomous"
    bastion_shape         = ""
    bastion_upgrade       = true
    netnum                = 13
    newbits               = 32
    notification_enabled  = false
    notification_endpoint = ""
    notification_protocol = "EMAIL"
    notification_topic    = "bastion"
    ssh_private_key_path  = ""
    ssh_public_key_path   = ""
    tags = {
      role        = "bastion"
    }
    timezone = "Australia/Sydney"
  }
}

# operator

variable "oci_base_operator" {
  type = object({
    availability_domain       = number
    operator_enabled          = bool
    operator_image_id         = string
    operator_shape            = string
    operator_upgrade          = bool
    enable_instance_principal = bool
    netnum                    = number
    newbits                   = number
    notification_enabled      = bool
    notification_endpoint     = string
    notification_protocol     = string
    notification_topic        = string
    ssh_private_key_path      = string
    ssh_public_key_path       = string
    tags                      = map(any)
    timezone                  = string
  })
  description = "operator host parameters"
  default = {
    availability_domain       = 1
    operator_enabled          = false
    operator_image_id         = "Oracle"
    operator_shape            = ""
    operator_upgrade          = true
    enable_instance_principal = false
    netnum                    = 33
    newbits                   = 13
    notification_enabled      = false
    notification_endpoint     = ""
    notification_protocol     = "EMAIL"
    notification_topic        = "operator"
    ssh_private_key_path      = ""
    ssh_public_key_path       = ""
    tags = {
      role        = "operator"
    }
    timezone = "Australia/Sydney"
  }
}
