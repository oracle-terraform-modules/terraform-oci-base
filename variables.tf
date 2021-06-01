# Copyright 2017, 2021, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

# provider parameters

variable "api_fingerprint" {
  description = "Fingerprint of oci api private key."
  type        = string
}

variable "api_private_key_path" {
  description = "The path to oci api private key."
  type        = string
}

variable "region" {
  # List of regions: https://docs.cloud.oracle.com/iaas/Content/General/Concepts/regions.htm#ServiceAvailabilityAcrossRegions
  description = "The oci region where resources will be created."
  type        = string
}

variable "tenancy_id" {
  description = "The tenancy id in which to create the resources."
  type        = string
}

variable "user_id" {
  description = "The id of the user that terraform will use to create the resources."
  type        = string
}

# general oci parameters
variable "compartment_id" {
  description = "The compartment id where to create all resources."
  type        = string
}

variable "label_prefix" {
  default     = "none"
  description = "A string that will be prepended to all resources."
  type        = string
}

# networking parameters
variable "create_drg" {
  description = "Whether to create a Dynamic Routing Gateway. If set to true, creates a Dynamic Routing Gateway and attach it to the VCN."
  type        = bool
  default     = false
}

variable "create_internet_gateway" {
  description = "Whether to create an Internet gateway in the VCN. If set to true, a NAT gateway is created."
  default     = true
  type        = bool
}

variable "create_nat_gateway" {
  description = "Whether to create a NAT gateway in the VCN. If set to true, a NAT gateway is created."
  default     = true
  type        = bool
}

variable "create_service_gateway" {
  description = "Whether to create a service gateway. If set to true, a Service Gateway is created."
  default     = true
  type        = bool
}

variable "drg_display_name" {
  description = "(Updatable) Name of Dynamic Routing Gateway. Does not have to be unique."
  type        = string
  default     = "drg"
}

variable "lockdown_default_seclist" {
  description = "Whether to remove all default security rules from the VCN Default Security List"
  default     = true
  type        = bool
}

variable "vcn_cidr" {
  default     = "10.0.0.0/16"
  description = "The CIDR block of the VCN."
  type        = string
}

variable "vcn_dns_label" {
  default     = "vcn"
  description = "A DNS label for the VCN, used in conjunction with the VNIC's hostname and subnet's DNS label to form a fully qualified domain name (FQDN) for each VNIC within this subnet."
  type        = string
}

variable "vcn_name" {
  default     = "vcn"
  description = "User-friendly name of to use for the VCN to be appended to the label_prefix"
  type        = string
}

variable "internet_gateway_route_rules" {
  description = "(Updatable) List of routing rules to add to Internet Gateway Route Table"
  type = list(object({
    destination       = string
    destination_type  = string
    network_entity_id = string
    description       = string
  }))
  default = null
}

variable "nat_gateway_route_rules" {
  description = "(Updatable) List of routing rules to add to NAT Gateway Route Table"
  type = list(object({
    destination       = string
    destination_type  = string
    network_entity_id = string
    description       = string
  }))
  default = null
}

variable "vcn_tags" {
  description = "Freeform tags for VCN"
  default = {
    environment = "dev"
    role        = "hub"
  }
  type = map(any)
}

# subnets
variable "netnum" {
  description = "0-based index of the subnet when the network is masked with the newbit. Used as netnum parameter for cidrsubnet function."
  default = {
    bastion  = 0
    operator = 1
  }
  type = map(any)
}

variable "newbits" {
  default = {
    bastion  = 14
    operator = 14
  }
  description = "The masks for the subnets within the virtual network. Used as newbits parameter for cidrsubnet function."
  type        = map(any)
}

# ssh keys

variable "ssh_public_key" {
  description = "The content of the ssh public key used to access the bastion/operator. Set this or the ssh_public_key_path"
  default     = ""
  type        = string
}

variable "ssh_private_key_path" {
  description = "The path to the ssh private key used to access the bastion/operator."
  default     = ""
  type        = string
}

variable "ssh_public_key_path" {
  description = "The path to the ssh public key used to access the bastion/operator. Set this or the ssh_public_key"
  default     = ""
  type        = string
}

# bastion parameters

variable "create_bastion" {
  description = "Whether to create the bastion"
  default     = true
  type        = bool
}

variable "bastion_availability_domain" {
  description = "The AD to place the bastion host when multi-regions AD is used"
  default     = 1
  type        = number
}

variable "bastion_access" {
  description = "The CIDR block in the form of a string to which ssh access to the bastion must be restricted to. *_ANYWHERE_* is equivalent to 0.0.0.0/0 and allows ssh access from anywhere."
  default     = "ANYWHERE"
  type        = string
}

variable "bastion_image_id" {
  description = "Provide a custom image id for the bastion host or leave as Autonomous."
  default     = "Autonomous"
  type        = string
}

variable "bastion_operating_system_version" {
  description = "In case Autonomous Linux is used, allow specification of Autonomous version"
  default     = "7.9"
  type        = string
}

variable "bastion_shape" {
  description = "The shape of bastion instance."
  default     = {
   shape = "VM.Standard.E4.Flex", ocpus = 1, memory = 4, boot_volume_size = 50
  }
  type        = map(any)
}

variable "bastion_state" {
  description = "The target state for the instance. Could be set to RUNNING or STOPPED. (Updatable)"
  default     = "RUNNING"
  type        = string
}

variable "bastion_timezone" {
  description = "The preferred timezone for the bastion host."
  default     = "Australia/Sydney"
  type        = string
}

variable "bastion_type" {
  description = "Whether to make the bastion host public or private."
  default     = "public"
  type        = string
}

variable "bastion_upgrade" {
  description = "Whether to upgrade the bastion host packages after provisioning. It's useful to set this to false during development/testing so the bastion is provisioned faster."
  default     = false
  type        = bool
}

variable "bastion_notification" {
  description = "Whether to enable ONS notification for the bastion host."
  default     = false
  type        = bool
}

variable "bastion_notification_endpoint" {
  description = "The subscription notification endpoint. Email address to be notified."
  default     = null
  type        = string
}

variable "bastion_notification_protocol" {
  description = "The notification protocol used."
  default     = "EMAIL"
  type        = string
}

variable "bastion_notification_topic" {
  description = "The name of the notification topic"
  default     = "bastion"
  type        = string
}

variable "bastion_tags" {
  description = "Freeform tags for bastion"
  default = {
    environment = "dev"
    role        = "bastion"
  }
  type = map(any)
}

# operator

variable "create_operator" {
  description = "Whether to create the operator host"
  default     = false
  type        = bool
}

variable "operator_availability_domain" {
  description = "The AD to place the operator host when multi-regions AD is used"
  default     = 1
  type        = number
}

variable "operator_image_id" {
  description = "Provide a custom image id for the operator host or leave as Oracle."
  default     = "Oracle"
  type        = string
}

variable "operator_instance_principal" {
  description = "Whether to enable instance_principal on the operator"
  default     = false
  type        = bool
}

variable "operator_nsg_ids" {
  description = "Optional list of network security groups that the operator will be part of"
  type        = list(string)
  default     = []
}

variable "operator_os_version" {
  description = "The version of the Oracle Linux to use."
  default     = "8"
  type        = string
}

variable "operator_shape" {
  description = "The shape of the operator instance."
  default = {
    shape = "VM.Standard.E4.Flex", ocpus = 1, memory = 4, boot_volume_size = 50
  }
  type = map(any)
}

variable "operator_state" {
  description = "The target state for the instance. Could be set to RUNNING or STOPPED. (Updatable)"
  default     = "RUNNING"
  type        = string
}

variable "operator_timezone" {
  description = "The preferred timezone for the operator host."
  default     = "Australia/Sydney"
  type        = string
}

variable "operator_upgrade" {
  description = "Whether to upgrade the operator host packages after provisioning. It's useful to set this to false during development/testing so the operator is provisioned faster."
  default     = false
  type        = bool
}

variable "operator_notification" {
  description = "Whether to enable ONS notification for the operator host."
  default     = false
  type        = bool
}

variable "operator_notification_endpoint" {
  description = "The subscription notification endpoint. Email address to be notified."
  default     = null
  type        = string
}

variable "operator_notification_protocol" {
  description = "The notification protocol used."
  default     = "EMAIL"
  type        = string
}

variable "operator_notification_topic" {
  description = "The name of the notification topic"
  default     = "operator"
  type        = string
}

variable "operator_tags" {
  description = "Freeform tags for bastion"
  default = {
    environment = "dev"
    role        = "operator"
  }
  type = map(any)
}
