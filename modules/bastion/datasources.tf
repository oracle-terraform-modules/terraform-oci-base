# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

data "oci_core_app_catalog_listings" "autonomous_linux" {
  display_name = "Oracle Autonomous Linux"
}

data "oci_core_app_catalog_listing_resource_versions" "autonomous_linux" {
  #Required
  listing_id = lookup(data.oci_core_app_catalog_listings.autonomous_linux.app_catalog_listings[0], "listing_id")
}

# Gets the Autonomous Linux image id
data "oci_core_app_catalog_subscriptions" "autonomous_linux" {
  #Required
  compartment_id = var.oci_base_identity.compartment_id

  #Optional
  listing_id = lookup(data.oci_core_app_catalog_listing_resource_versions.autonomous_linux.app_catalog_listing_resource_versions[0], "listing_id")
}

data "template_file" "tesseract_template" {
  template = file("${path.module}/scripts/tesseract.template.sh")

  vars = {
    bastion_ip       = join(",", data.oci_core_vnic.bastion_vnic.*.public_ip_address)
    user             = "opc"
    private_key_path = var.oci_base_ssh_keys.ssh_private_key_path
  }

  depends_on = ["oci_core_instance.bastion"]
  count      = var.oci_bastion.create_bastion == true ? 1 : 0
}

data "template_file" "bastion_template" {
  template = file("${path.module}/scripts/bastion.template.sh")

  vars = {
    notification_enabled = var.oci_bastion_notification.enable_notification
    topic_id = var.oci_bastion_notification.enable_notification == true ? oci_ons_notification_topic.bastion_notification[0].topic_id : "null"
  }
  count = var.oci_bastion.create_bastion == true ? 1 : 0
}

data "template_file" "bastion_cloud_init_file" {
  template = file("${path.module}/cloudinit/bastion.template.yaml")

  vars = {
    notification_sh_content = base64gzip(data.template_file.bastion_template[0].rendered)
    timezone                = var.oci_bastion.timezone
  }
  count = var.oci_bastion.create_bastion == true ? 1 : 0
}

# cloud init for bastion
data "template_cloudinit_config" "bastion" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "bastion.yaml"
    content_type = "text/cloud-config"
    content      = data.template_file.bastion_cloud_init_file[0].rendered
  }
  count = var.oci_bastion.create_bastion == true ? 1 : 0
}

# Gets a list of VNIC attachments on the bastion instance
data "oci_core_vnic_attachments" "bastion_vnics_attachments" {
  availability_domain = element(var.oci_bastion_infra.ad_names, (var.oci_bastion_infra.availability_domains - 1))
  compartment_id      = var.oci_base_identity.compartment_id
  instance_id         = oci_core_instance.bastion[0].id
  depends_on          = ["oci_core_instance.bastion"]
  count               = var.oci_bastion.create_bastion == true ? 1 : 0
}

# Gets the OCID of the first (default) VNIC on the bastion instance
data "oci_core_vnic" "bastion_vnic" {
  vnic_id    = lookup(data.oci_core_vnic_attachments.bastion_vnics_attachments[0].vnic_attachments[0], "vnic_id")
  depends_on = ["oci_core_instance.bastion"]
  count      = var.oci_bastion.create_bastion == true ? 1 : 0
}

data "oci_core_instance" "bastion" {
  #Required
  instance_id = oci_core_instance.bastion[0].id
  depends_on  = ["oci_core_instance.bastion"]
  count       = var.oci_bastion.create_bastion == true ? 1 : 0
}

data "oci_ons_notification_topic" "bastion_notification" {
  #Required
  topic_id = oci_ons_notification_topic.bastion_notification[0].topic_id
  count    = var.oci_bastion_notification.enable_notification == true ? 1 : 0
}
