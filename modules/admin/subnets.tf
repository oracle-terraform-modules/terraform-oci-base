# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

resource "oci_core_subnet" "admin" {
  cidr_block                 = cidrsubnet(var.oci_admin_network.vcn_cidr, var.oci_admin_network.newbits, var.oci_admin_network.netnum)
  compartment_id             = var.oci_admin_identity.compartment_id
  display_name               = "${var.oci_admin_general.label_prefix}-admin"
  dns_label                  = "admin"
  prohibit_public_ip_on_vnic = true
  route_table_id             = var.oci_admin_network.nat_route_id
  security_list_ids          = [oci_core_security_list.admin[0].id]
  vcn_id                     = var.oci_admin_network.vcn_id
  freeform_tags              = var.tagging.networktag

  count = var.oci_admin.admin_enabled == true ? 1 : 0
}
