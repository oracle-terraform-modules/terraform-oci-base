# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_subnet" "gitlab" {
  cidr_block                 = cidrsubnet(var.gitlab_network.vcn_cidr,var.gitlab_network.newbits["gitlab"],var.gitlab_network.subnets["gitlab"])
  display_name               = "${var.gitlab_oci_general.label_prefix}-gitlab"
  compartment_id             = var.gitlab_identity.compartment_id
  vcn_id                     = var.gitlab_network.vcn_id
  route_table_id             = var.gitlab_network.nat_route_id
  security_list_ids          = [oci_core_security_list.gitlab.id]
  dns_label                  = "gitlab"
  prohibit_public_ip_on_vnic = true
}