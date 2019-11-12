# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

# db security checklist
resource "oci_core_security_list" "db" {
  compartment_id = var.db_identity.compartment_id
  display_name   = "${var.db_oci_general.label_prefix}-db"
  vcn_id         = var.db_network.vcn_id

  egress_security_rules {
    protocol    = local.all_protocols
    destination = local.anywhere
  }

  ingress_security_rules {
    # ssh
    protocol = local.tcp_protocol
    source   = var.db_network.vcn_cidr

    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }
  }
  ingress_security_rules {
    # db port
    protocol = local.tcp_protocol
    source   = var.db_network.vcn_cidr

    tcp_options {
      min = local.db_port
      max = local.db_port
    }
  }
}
