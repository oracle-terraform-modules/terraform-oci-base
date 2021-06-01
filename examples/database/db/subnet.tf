# Copyright 2017, 2021, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

resource "oci_core_subnet" "db" {
  cidr_block                 = cidrsubnet(var.db_network.vcn_cidr, var.db_network.newbits["db"], var.db_network.subnets["db"])
  compartment_id             = var.db_identity.compartment_id
  display_name               = "${var.db_oci_general.label_prefix}_db"
  dns_label                  = "db"
  prohibit_public_ip_on_vnic = true
  route_table_id             = var.db_network.nat_route_id
  security_list_ids          = [oci_core_security_list.db.id]
  vcn_id                     = var.db_network.vcn_id
}