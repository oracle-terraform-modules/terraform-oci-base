# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_ons_notification_topic" "bastion_notification" {
  #Required
  compartment_id = var.oci_base_identity.compartment_id
  name           = "${var.oci_bastion_general.label_prefix}-${var.oci_bastion_notification.notification_topic}"
  count          = var.oci_bastion_notification.enable_notification == true ? 1 : 0
}

resource "oci_ons_subscription" "bastion_notification" {
  #Required
  compartment_id = var.oci_base_identity.compartment_id
  endpoint       = var.oci_bastion_notification.notification_endpoint
  protocol       = var.oci_bastion_notification.notification_protocol
  topic_id       = oci_ons_notification_topic.bastion_notification[0].topic_id
  count = var.oci_bastion_notification.enable_notification == true ? 1 : 0
}
