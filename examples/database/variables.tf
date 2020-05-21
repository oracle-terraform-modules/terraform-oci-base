# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# Identity and access parameters
variable "api_fingerprint" {
  description = "fingerprint of oci api private key"
  type        = string
}

variable "api_private_key_path" {
  description = "path to oci api private key"
  type        = string
}

variable "region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "region"
  default     = "us-phoenix-1"
  type        = string
}

variable "tenancy_id" {
  description = "tenancy id"
  type        = string
}

variable "user_id" {
  description = "user id"
  type        = string
}

# ssh keys
variable "ssh_private_key_path" {
  description = "path to ssh private key"
  type        = string
}

variable "ssh_public_key_path" {
  description = "path to ssh public key"
  type        = string
}

# general oci parameters
variable "compartment_id" {
  description = "compartment id"
  type        = string
}

variable "label_prefix" {
  description = "a string that will be prependend to all resources"
  default     = "oke"
  type        = string
}

# networking parameters

variable "internet_gateway_enabled" {
  description = "whether to create a nat gateway"
  default     = false
  type        = bool
}

variable "nat_gateway_enabled" {
  description = "whether to create a nat gateway"
  default     = true
  type        = bool
}

variable "netnum" {
  description = "zero-based index of the subnet when the network is masked with the newbit."
  default = {
    admin   = 33
    bastion = 32
  }
  type = map
}

variable "newbits" {
  description = "new mask for the subnet within the virtual network. use as newbits parameter for cidrsubnet function"
  default = {
    admin   = 13
    bastion = 13
  }
  type = map
}

variable "service_gateway_enabled" {
  description = "whether to create a service gateway"
  default     = true
  type        = bool
}

variable "vcn_cidr" {
  description = "cidr block of VCN"
  default     = "10.0.0.0/16"
  type        = string
}

variable "vcn_dns_label" {
  default = "db"
  type    = string
}

variable "vcn_name" {
  description = "name of vcn"
  default     = "db vcn"
  type        = string
}

# bastion
variable "bastion_access" {
  description = "cidr from where the bastion can be sshed into. Default is ANYWHERE and equivalent to 0.0.0.0/0"
  default     = "ANYWHERE"
  type        = string
}

variable "bastion_enabled" {
  description = "whether to create a bastion host"
  default     = true
  type        = bool
}

variable "bastion_image_id" {
  description = "image id to use for bastion."
  default     = "NONE"
  type        = string
}

variable "bastion_notification_enabled" {
  description = "Whether to enable notification on the bastion host"
  default     = true
  type        = bool
}

variable "bastion_notification_endpoint" {
  description = "The subscription notification endpoint for the bastion. Email address to be notified."
  default     = ""
  type        = string
}

variable "bastion_notification_protocol" {
  description = "The notification protocol used."
  default     = "EMAIL"
  type        = string
}

variable "bastion_notification_topic" {
  description = "The name of the notification topic."
  default     = "bastion"
  type        = string
}

variable "bastion_package_upgrade" {
  description = "Whether to upgrade the bastion host packages after provisioning. It’s useful to set this to false during development so the bastion is provisioned faster."
  default     = true
  type        = bool
}

variable "bastion_shape" {
  description = "shape of bastion instance"
  default     = "VM.Standard.E2.1"
  type        = string
}

variable "bastion_timezone" {
  description = "The preferred timezone for the bastion host."
  default     = "Australia/Sydney"
  type        = string
}

variable "bastion_use_autonomous" {
  description = "Whether to use Autonomous Linux or an Oracle Linux Platform image or custom image. Set to false if you want to use your own image id or Oracle Linux Platform image."
  default     = true
  type        = bool
}

# admin server

variable "admin_enabled" {
  description = "whether to create an admin server in a private subnet"
  default     = true
  type        = bool
}

variable "admin_image_id" {
  description = "image id to use for admin server."
  default     = "NONE"
  type        = string
}

variable "enable_instance_principal" {
  description = "enable the admin server host to call OCI API services without requiring api key"
  default     = true
  type        = bool
}

variable "admin_notification_enabled" {
  description = "Whether to enable notification on the admin host"
  default     = false
  type        = bool
}

variable "admin_notification_endpoint" {
  description = "The subscription notification endpoint for the admin. Email address to be notified."
  default     = ""
  type        = string
}

variable "admin_notification_protocol" {
  description = "The notification protocol used."
  default     = "EMAIL"
  type        = string
}

variable "admin_notification_topic" {
  description = "The name of the notification topic."
  default     = "admin"
  type        = string
}

variable "admin_package_upgrade" {
  description = "Whether to upgrade the bastion host packages after provisioning. It’s useful to set this to false during development so the bastion is provisioned faster."
  default     = true
  type        = bool
}

variable "admin_shape" {
  description = "shape of admin server instance"
  default     = "VM.Standard.E2.1"
  type        = string
}

variable "admin_timezone" {
  default     = "Australia/Sydney"
  description = "The preferred timezone for the admin host."
  type        = string
}

variable "admin_use_autonomous" {
  description = "Whether to use Autonomous Linux or an Oracle Linux Platform image or custom image. Set to false if you want to use your own image id or Oracle Linux Platform image."
  default     = true
  type        = bool
}

# availability domains
variable "availability_domains" {
  description = "ADs where to provision compute resources"
  type        = map

  default = {
    bastion = 1
    db      = 1
  }
}

# dbserver

variable "db_system_shape" {
  description = "compute shape of db nodes"
  default     = "VM.Standard2.8"
  type        = string
}

variable "cpu_core_count" {
  default = "2"
  type    = number
}

variable "db_edition" {
  default = "ENTERPRISE_EDITION"
  type    = string
}

variable "db_admin_password" {
  default = "BEstrO0ng_#12"
  type    = string
}

variable "db_name" {
  default = "basedb"
  type    = string
}

variable "db_home_db_name" {
  default = "basedb2"
  type    = string
}

variable "db_version" {
  default = "19.0.0.0"
  type    = string
}

variable "db_home_display_name" {
  default = "basedbhome"
  type    = string
}

variable "db_disk_redundancy" {
  default = "HIGH"
  type    = string
}

variable "db_system_display_name" {
  default = "basedb_system"
  type    = string
}

variable "hostname" {
  default = "myoracledb"
  type    = string
}

variable "n_character_set" {
  default = "AL16UTF16"
  type    = string
}

variable "character_set" {
  default = "AL32UTF8"
  type    = string
}

variable "db_workload" {
  default = "OLTP"
  type    = string
}

variable "pdb_name" {
  default = "pdb1"
  type    = string
}

variable "data_storage_size_in_gb" {
  default = 256
  type    = number
}

variable "license_model" {
  default = "LICENSE_INCLUDED"
  type    = string
}

variable "node_count" {
  default = 1
  type    = number
}

variable "data_storage_percentage" {
  default = 40
  type    = number
}
