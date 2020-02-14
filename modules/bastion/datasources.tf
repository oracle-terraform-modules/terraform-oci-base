# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

data "template_file" "autonomous_template" {
  template = file("${path.module}/scripts/notification.template.sh")

  vars = {
    notification_enabled = var.oci_bastion_notification.notification_enabled
    topic_id             = var.oci_bastion_notification.notification_enabled == true ? oci_ons_notification_topic.bastion_notification[0].topic_id : "null"
  }

  count = (var.oci_bastion.bastion_enabled == true && var.oci_bastion.bastion_image_id == "Autonomous") ? 1 : 0
}

data "template_file" "autonomous_cloud_init_file" {
  template = file("${path.module}/cloudinit/autonomous.template.yaml")

  vars = {
    notification_sh_content = base64gzip(data.template_file.autonomous_template[0].rendered)
    timezone                = var.oci_bastion.timezone
  }

  count = (var.oci_bastion.bastion_enabled == true && var.oci_bastion.bastion_image_id == "Autonomous") ? 1 : 0
}

data "oci_core_images" "autonomous_images" {
  compartment_id           = var.oci_base_identity.compartment_id
  operating_system         = "Oracle Autonomous Linux"
  operating_system_version = "7.7"
  shape                    = var.oci_bastion.bastion_shape
  sort_by                  = "TIMECREATED"
}

# cloud init for bastion
data "template_cloudinit_config" "bastion" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "bastion.yaml"
    content_type = "text/cloud-config"
    content      = data.template_file.autonomous_cloud_init_file[0].rendered
  }
  count = var.oci_bastion.bastion_enabled == true ? 1 : 0
}

# Gets a list of VNIC attachments on the bastion instance
data "oci_core_vnic_attachments" "bastion_vnics_attachments" {
  availability_domain = element(var.oci_bastion_network.ad_names, (var.oci_bastion_network.availability_domains - 1))
  compartment_id      = var.oci_base_identity.compartment_id
  depends_on          = [oci_core_instance.bastion]
  instance_id         = oci_core_instance.bastion[0].id

  count = var.oci_bastion.bastion_enabled == true ? 1 : 0
}

# Gets the OCID of the first (default) VNIC on the bastion instance
data "oci_core_vnic" "bastion_vnic" {
  depends_on = [oci_core_instance.bastion]
  vnic_id    = lookup(data.oci_core_vnic_attachments.bastion_vnics_attachments[0].vnic_attachments[0], "vnic_id")

  count = var.oci_bastion.bastion_enabled == true ? 1 : 0
}

data "oci_core_instance" "bastion" {
  depends_on  = [oci_core_instance.bastion]
  instance_id = oci_core_instance.bastion[0].id

  count = var.oci_bastion.bastion_enabled == true ? 1 : 0
}

data "oci_ons_notification_topic" "bastion_notification" {
  topic_id = oci_ons_notification_topic.bastion_notification[0].topic_id

  count = (var.oci_bastion.bastion_enabled == true && var.oci_bastion_notification.notification_enabled == true) ? 1 : 0
}
