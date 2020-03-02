# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# general

variable "oci_admin_identity" {
  type = object({
    api_fingerprint      = string
    api_private_key_path = string
    compartment_id       = string
    tenancy_id           = string
    user_id              = string
  })
  description = "parameters related to oci identity"
}

variable "oci_admin_general" {
  type = object({
    home_region  = string
    label_prefix = string
    region       = string
  })
  description = "general oci parameters"
}

# admin

variable "oci_admin" {
  type = object({
    admin_image_id            = string
    admin_shape               = string
    admin_upgrade             = bool
    admin_enabled             = bool
    enable_instance_principal = bool
    ssh_public_key_path       = string
    timezone                  = string
  })
  description = "admin host parameters"
}

variable "oci_admin_network" {
  type = object({
    ad_names             = list(string)
    availability_domains = number
    nat_route_id         = string
    netnum               = number
    newbits              = number
    vcn_cidr             = string
    vcn_id               = string
  })
  description = "admin host networking parameters"
}

variable "oci_admin_notification" {
  type = object({
    notification_enabled  = bool
    notification_endpoint = string
    notification_protocol = string
    notification_topic    = string
  })
  description = "OCI notification parameters for admin"
}

#tagging
variable "tagging" {
  type = object({
    computetag                = map(any)
    networktag                = map(any)
  }) 
}

