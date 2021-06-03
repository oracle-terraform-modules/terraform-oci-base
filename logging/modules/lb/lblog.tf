locals {
  logdef   = { for k, v in var.logdefinition : k => v if contains(values(v), "loadbalancer") == true }
  loggroup = [for k, v in var.logdefinition : v.loggroup if contains(values(v), "loadbalancer") == true]
}

data "oci_load_balancer_load_balancers" "test_load_balancers" {

  for_each       = local.logdef
  compartment_id = var.compartment_ocid

  #Optional
  #detail       = var.load_balancer_detail
  display_name = each.value.resource
  state        = "ACTIVE"
}
data "oci_logging_log_groups" "log_groups" {
  for_each = toset(local.loggroup)
  #Required
  compartment_id = var.compartment_ocid

  #Optional
  display_name                 = each.value
  is_compartment_id_in_subtree = false
}
resource "oci_logging_log" "lb_access_log" {


  for_each = local.logdef

  display_name = format("%s-%s", each.key, "access")
  log_group_id = var.loggroup[each.value.loggroup].id
  log_type     = "SERVICE"
  configuration {
    source {
      category    = "access"
      resource    = data.oci_load_balancer_load_balancers.test_load_balancers[each.key].load_balancers.0.id
      service     = "loadbalancer"
      source_type = "OCISERVICE"
    }
  }

  is_enabled         = var.log_is_enabled
  retention_duration = var.log_retention_duration

}

resource "oci_logging_log" "lb_error_log" {
  for_each = local.logdef

  display_name = format("%s-%s", each.key, "error")
  log_group_id = var.loggroup[each.value.loggroup].id
  log_type     = "SERVICE"
  configuration {
    source {
      category    = "error"
      resource    = data.oci_load_balancer_load_balancers.test_load_balancers[each.key].load_balancers.0.id
      service     = "loadbalancer"
      source_type = "OCISERVICE"
    }
  }

  is_enabled         = var.log_is_enabled
  retention_duration = var.log_retention_duration

}




