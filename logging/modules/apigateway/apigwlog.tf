locals {
  logdef   = { for k, v in var.logdefinition : k => v if contains(values(v), "apigateway") == true }
  loggroup = [for k, v in var.logdefinition : v.loggroup if contains(values(v), "apigateway") == true]
}

data "oci_apigateway_deployments" "test_deployments" {

  for_each       = local.logdef
  compartment_id = var.compartment_ocid

  #Optional
  display_name = each.value.resource
  #gateway_id   = oci_apigateway_gateway.test_gateway.id
  state = "ACTIVE"
}


resource "oci_logging_log" "apigw_access_log" {


  for_each = local.logdef

  display_name = format("%s-%s", each.key, "access")
  log_group_id = var.loggroup[each.value.loggroup].id
  log_type     = "SERVICE"
  configuration {
    source {
      category    = "access"
      resource    = data.oci_apigateway_deployments.test_deployments[each.key].deployment_collection.0.id
      service     = "apigateway"
      source_type = "OCISERVICE"
    }
  }

  is_enabled         = var.log_is_enabled
  retention_duration = var.log_retention_duration

}

resource "oci_logging_log" "apigw_exec_log" {
  for_each = local.logdef

  display_name = format("%s-%s", each.key, "exec")
  log_group_id = var.loggroup[each.value.loggroup].id
  log_type     = "SERVICE"
  configuration {
    source {
      category    = "execution"
      resource    = data.oci_apigateway_deployments.test_deployments[each.key].deployment_collection.0.id
      service     = "apigateway"
      source_type = "OCISERVICE"
    }
  }

  is_enabled         = var.log_is_enabled
  retention_duration = var.log_retention_duration

}

