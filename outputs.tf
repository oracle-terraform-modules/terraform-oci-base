# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

# for reuse

output "ad_names" {
  description = "sorted list of AD names"
  value       = sort(data.template_file.ad_names.*.rendered)
}

output "bastion_public_ip" {
  description = "public IP address of bastion host"
  value       = module.bastion.bastion_public_ip
}

output "ig_route_id" {
  description = "id of internet gateway route table"
  value       = module.vcn.ig_route_id
}

output "nat_gateway_id" {
  description = "id of nat gateway if it is created"
  value       = module.vcn.nat_gateway_id
}

output "nat_route_id" {
  description = "id of VCN NAT gateway route table"
  value       = module.vcn.nat_route_id
}

output "vcn_id" {
  description = "id of vcn that is created"
  value       = module.vcn.vcn_id
}

output "home_region" {
  description = "name of home region"
  value       = lookup(data.oci_identity_regions.home_region.regions[0], "name")
}

# convenient output

output "ssh_to_bastion" {
  description = "convenient output of terraform to ssh to the bastion host"
  value       = "ssh -i ${var.oci_base_ssh_keys.ssh_private_key_path} opc@${module.bastion.bastion_public_ip}"
}
