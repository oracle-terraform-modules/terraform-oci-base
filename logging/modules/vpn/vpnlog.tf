locals {
  logdef   = { for k, v in var.logdefinition : k => v if contains(values(v), "oci_c3_vpn") == true }
  loggroup = [for k, v in var.logdefinition : v.loggroup if contains(values(v), "oci_c3_vpn") == true]
}



data "oci_core_ipsec_connections" "ip_sec_connections" {
  for_each       = local.logdef
  compartment_id = var.compartment_ocid
  filter {
    name   = "display_name"
    values = [each.value.resource]
  }

  #Optional
  # cpe_id = oci_core_cpe.test_cpe.id
  # drg_id = oci_core_drg.test_drg.id
}

resource "oci_logging_log" "oci_c3_vpn_log" {
  for_each = local.logdef

  display_name = each.key
  log_group_id = var.loggroup[each.value.loggroup].id
  log_type     = "SERVICE"
  configuration {
    source {
      category    = "read"
      resource    = data.oci_core_ipsec_connections.ip_sec_connections[each.key].connections.0.id
      service     = "oci_c3_vpn"
      source_type = "OCISERVICE"
    }
  }

  is_enabled         = var.log_is_enabled
  retention_duration = var.log_retention_duration

}
