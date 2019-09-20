# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

locals {
  icmp_protocol = "1"
  tcp_protocol  = "6"
  all_protocols = "all"

  anywhere = "0.0.0.0/0"

  http_port = "80"

  https_port = "443"

  health_check_port = "8060"
  ssh_port          = "22"
}

# gitlab security checklist
resource "oci_core_security_list" "gitlab" {
  compartment_id = var.gitlab_identity.compartment_id
  display_name   = "${var.gitlab_oci_general.label_prefix}-gitlab"
  vcn_id         = var.gitlab_network.vcn_id

  egress_security_rules {
    protocol    = local.all_protocols
    destination = local.anywhere
  }

  ingress_security_rules {
    # ssh
    protocol = local.tcp_protocol
    source   = var.gitlab_network.vcn_cidr

    tcp_options {
      min = local.ssh_port
      max = local.ssh_port
    }
  }
  ingress_security_rules {
    # http port
    protocol = local.tcp_protocol
    source   = var.gitlab_network.vcn_cidr

    tcp_options {
      min = local.http_port
      max = local.http_port
    }
  }
  ingress_security_rules {
    # https port
    protocol = local.tcp_protocol
    source   = var.gitlab_network.vcn_cidr

    tcp_options {
      min = local.https_port
      max = local.https_port
    }
  }
  ingress_security_rules {
    # health check port for lb
    protocol = local.tcp_protocol
    source   = var.gitlab_network.vcn_cidr

    tcp_options {
      min = local.health_check_port
      max = local.health_check_port
    }
  }
}
