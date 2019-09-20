# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

resource "oci_core_instance" "gitlab" {
  availability_domain = element(var.ad_names, 0)
  compartment_id      = var.gitlab_identity.compartment_id
  display_name        = "${var.gitlab_oci_general.label_prefix}-gitlab"

  source_details {
    source_type = "image"
    source_id   = lookup(data.oci_core_app_catalog_subscriptions.bitnami_app_catalog_subscriptions.app_catalog_subscriptions[0],"listing_resource_id")
  }

  shape = var.gitlab_config.gitlab_shape

  create_vnic_details {
    subnet_id        = oci_core_subnet.gitlab.id
    display_name     = "gitlab_vnic"
    # avoid git in hostname as per bitnami doc: https://docs.bitnami.com/oci/apps/gitlab/configuration/change-default-address/
    hostname_label   = "gl-ad1"
    assign_public_ip = "false"
  }

  extended_metadata {
    ssh_authorized_keys = file(var.gitlab_ssh_keys.ssh_public_key_path)
  }

  timeouts {
    create = "60m"
  }
}

resource null_resource "configure_gitlab" {
  depends_on = ["oci_core_instance.gitlab"]

  connection {
    type        = "ssh"
    host        = data.oci_core_vnic.gitlab_vnic.private_ip_address
    user        = "bitnami"
    private_key = file(var.gitlab_ssh_keys.ssh_private_key_path)
    timeout     = "40m"

    bastion_host        = element(compact(values(var.bastion_ips)),0)
    bastion_user        = "opc"
    bastion_private_key = file(var.gitlab_ssh_keys.ssh_private_key_path)
  }

  provisioner "file" {
    content     = data.template_file.reconfigure_gitlab.rendered
    destination = "~/reconfigure_gitlab.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x ~/reconfigure_gitlab.sh",
      "~/reconfigure_gitlab.sh",
    ]
  }
}