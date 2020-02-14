# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# for reuse

output "ad_names" {
  description = "list of ADs in the selected region"
  value       = sort(data.template_file.ad_names.*.rendered)
}

output "admin_private_ip" {
  description = "private ip address of admin host"
  value       = module.admin.admin_private_ip
}

output "bastion_public_ip" {
  description = "public ip address of admin host"
  value       = module.bastion.bastion_public_ip
}

output "group_name" {
  description = "name of dynamic group for admin host instance_principal"
  value       = module.admin.admin_instance_principal_group_name
}

output "ig_route_id" {
  description = "Internet Gateway id"
  value       = module.vcn.ig_route_id
}

output "nat_gateway_id" {
  description = "NAT gateway id of VCN"
  value       = module.vcn.nat_gateway_id
}

output "nat_route_id" {
  description = "NAT Routing table id"
  value       = module.vcn.nat_route_id
}

output "vcn_id" {
  description = "VCN id"
  value       = module.vcn.vcn_id
}

output "home_region" {
  description = "tenancy home region"
  value       = lookup(data.oci_identity_regions.home_region.regions[0], "name")
}

# convenient output

output "ssh_to_bastion" {
  description = "convenient output to ssh to the bastion host"
  value       = "ssh -i ${var.oci_base_bastion.ssh_private_key_path} opc@${module.bastion.bastion_public_ip}"
}

output "ssh_to_admin" {
  description = "convenient output to ssh to the admin host"
  value       = "ssh -i ${var.oci_base_bastion.ssh_private_key_path} -J opc@${module.bastion.bastion_public_ip} opc@${module.admin.admin_private_ip}"
}
