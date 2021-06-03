locals {
  logdef   = { for k, v in var.logdefinition : k => v if contains(values(v), "cloudevents") == true }
  loggroup = [for k, v in var.logdefinition : v.loggroup if contains(values(v), "cloudevents") == true]
}


data "oci_events_rules" "event_rules" {
  for_each       = local.logdef
  compartment_id = var.compartment_ocid

  #Optional
  display_name = each.value.resource
  state        = "ACTIVE"
}

resource "oci_logging_log" "ruleexecution_log" {
  for_each = local.logdef

  display_name = each.key
  log_group_id = var.loggroup[each.value.loggroup].id
  log_type     = "SERVICE"
  configuration {
    source {
      category    = "ruleexecutionlog"
      resource    = data.oci_events_rules.event_rules[each.key].rules.0.id
      service     = "cloudevents"
      source_type = "OCISERVICE"
    }
  }

  is_enabled         = var.log_is_enabled
  retention_duration = var.log_retention_duration

}
