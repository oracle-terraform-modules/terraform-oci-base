# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

variable "gitlab_identity" {
  type = object({
    compartment_id = string
    tenancy_id     = string
  })
}

variable "gitlab_ssh_keys" {
  type = object({
    ssh_private_key_path = string
    ssh_public_key_path  = string
  })
}

variable "gitlab_oci_general" {
  type = object({
    ad_names     = list(string)
    label_prefix = string
    region       = string
  })
}

variable "gitlab_bastion" {
  type = object({
    bastion_public_ip      = string
    create_bastion         = bool
    image_operating_system = string
  })
}

variable "gitlab_network" {
  type = object({
    ig_route_id                = string
    is_service_gateway_enabled = bool
    nat_route_id               = string
    newbits                    = map(number)
    subnets                    = map(number)
    vcn_cidr                   = string
    vcn_id                     = string
  })
}

variable "gitlab_config" {
  type = object({
    gitlab_shape = string
    gitlab_url   = string
  })
}
