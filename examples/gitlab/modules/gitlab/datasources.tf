# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

# Gets the partner image listing
data "oci_core_app_catalog_listings" "bitnami_app_catalog_listings" {
  filter {
    name   = "display_name"
    values = ["GitLab CE Certified by Bitnami"]
  }
}

data "oci_core_app_catalog_listing_resource_versions" "bitnami_app_catalog_listing_resource_versions" {
  #Required
  listing_id = lookup(data.oci_core_app_catalog_listings.bitnami_app_catalog_listings.app_catalog_listings[0], "listing_id")
}

# Gets the partner image
data "oci_core_app_catalog_subscriptions" "bitnami_app_catalog_subscriptions" {
  #Required
  compartment_id = var.gitlab_identity.compartment_id

  #Optional
  listing_id = lookup(data.oci_core_app_catalog_listing_resource_versions.bitnami_app_catalog_listing_resource_versions.app_catalog_listing_resource_versions[0], "listing_id")
}

data "oci_core_vnic" "gitlab_vnic" {
  vnic_id = lookup(data.oci_core_vnic_attachments.gitlab_vnic.vnic_attachments[0], "vnic_id")
}

data "oci_core_vnic_attachments" "gitlab_vnic" {
  compartment_id      = var.gitlab_identity.compartment_id
  availability_domain = element(var.ad_names, 0)
  instance_id         = oci_core_instance.gitlab.id
}

# Escape the / on the subnet mask so sed can work
data "template_file" "reconfigure_gitlab" {
  template = file("${path.module}/scripts/reconfigure_gitlab.template.sh")

  vars = {
    gitlab_url = var.gitlab_config.gitlab_url
    lb_cidr    = replace(cidrsubnet(var.gitlab_network.vcn_cidr, var.gitlab_network.newbits["lb"], var.gitlab_network.subnets["lb"]), "/", "\\/")
  }
}
