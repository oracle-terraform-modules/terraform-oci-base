locals {
  logdef   = { for k, v in var.logdefinition : k => v if contains(values(v), "functions") == true }
  loggroup = [for k, v in var.logdefinition : v.loggroup if contains(values(v), "functions") == true]
}

data "oci_functions_applications" "test_applications" {

  for_each       = local.logdef
  compartment_id = var.compartment_ocid

  #Optional
  display_name = each.value.resource
  #id           = oci_functions_application.test_application.id
  #state = "AVAILABLE"
}


resource "oci_logging_log" "function_log" {
  for_each = local.logdef

  display_name = each.key
  log_group_id = var.loggroup[each.value.loggroup].id
  log_type     = "SERVICE"
  configuration {
    source {
      category    = "invoke"
      resource    = data.oci_functions_applications.test_applications[each.key].applications.0.id
      service     = "functions"
      source_type = "OCISERVICE"
    }
  }

  is_enabled         = var.log_is_enabled
  retention_duration = var.log_retention_duration

}


