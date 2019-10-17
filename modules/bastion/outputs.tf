# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

output "bastion_public_ip" {
  description = "public IP address of bastion host"
  value       = join(",", data.oci_core_vnic.bastion_vnic_1.*.public_ip_address)
}

output "bastion_instance_principal_group_name" {
  value = oci_identity_dynamic_group.bastion_instance_principal[0].name
}