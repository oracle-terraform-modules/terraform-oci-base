locals {
  logdef   = { for k, v in var.logdefinition : k => v if contains(values(v), "flowlogs") == true }
  loggroup = [for k, v in var.logdefinition : v.loggroup if contains(values(v), "flowlogs") == true]
}

resource "oci_logging_log" "vcn_log" {
  for_each = local.logdef

  display_name = each.key
  log_group_id = var.loggroup[each.value.loggroup].id
  log_type     = "SERVICE"
  configuration {
    source {
      category    = "all"
      resource    = data.oci_core_subnets.this[each.key].subnets.0.id
      service     = "flowlogs"
      source_type = "OCISERVICE"
    }
  }

  is_enabled         = var.log_is_enabled
  retention_duration = var.log_retention_duration


}

data "oci_core_subnets" "this" {

  for_each       = local.logdef
  compartment_id = var.compartment_ocid

  #Optional
  display_name = each.value.resource
  state        = "AVAILABLE"
  #vcn_id       = oci_core_vcn.test_vcn.id
}

