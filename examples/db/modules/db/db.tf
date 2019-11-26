# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl/

resource "oci_database_db_system" "test_db_system" {
  availability_domain = element(var.db_oci_general.ad_names, var.db_oci_general.availability_domain)
  compartment_id      = var.db_identity.compartment_id
  cpu_core_count      = var.db_config.cpu_core_count
  database_edition    = var.db_config.db_edition

  db_home {
    database {
      admin_password = var.db_config.db_admin_password
      db_name        = var.db_config.db_name
      character_set  = var.db_config.character_set
      ncharacter_set = var.db_config.n_character_set
      db_workload    = var.db_config.db_workload
      pdb_name       = var.db_config.pdb_name

      db_backup_config {
        auto_backup_enabled     = false
        recovery_window_in_days = 10

        # backup_destination_details {
        #   id   = oci_database_backup_destination.test_backup_destination_nfs1.id
        #   type = "NFS"
        # }
      }

      freeform_tags = {
        "Department" = "Finance"
      }
    }

    db_version   = var.db_config.db_version
    display_name = var.db_config.db_home_display_name
  }

  disk_redundancy = var.db_config.db_disk_redundancy
  shape           = var.db_config.db_system_shape
  subnet_id       = oci_core_subnet.db.id
  ssh_public_keys = [file(var.db_ssh_keys.ssh_public_key_path)]
  display_name    = var.db_config.db_system_display_name

  hostname                = var.db_config.hostname
  data_storage_percentage = var.db_config.data_storage_percentage
  data_storage_size_in_gb = var.db_config.data_storage_size_in_gb
  license_model           = var.db_config.license_model
  node_count              = var.db_config.node_count
  # nsg_ids                 = [oci_core_network_security_group.test_network_security_group.id]

  #To use defined_tags, set the values below to an existing tag namespace, refer to the identity example on how to create tag namespaces
  #defined_tags = map("example-tag-namespace-all.example-tag", "originalValue")

  freeform_tags = {
    "Department" = "Finance"
  }
}
