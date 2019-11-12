# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/


locals {
  icmp_protocol = 1
  tcp_protocol  = 6
  all_protocols = "all"

  anywhere = "0.0.0.0/0"

  db_port = 1521

  ssh_port          = 22
}