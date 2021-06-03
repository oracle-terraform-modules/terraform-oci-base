locals {
  funclogdef   = { for k, v in var.servicelogdefinition : k => v if contains(values(v), "functions") == true }
  funcloggroup = [for k, v in var.servicelogdefinition : v.loggroup if contains(values(v), "functions") == true]
}

locals {
  eventlogdef   = { for k, v in var.servicelogdefinition : k => v if contains(values(v), "cloudevents") == true }
  eventloggroup = [for k, v in var.servicelogdefinition : v.loggroup if contains(values(v), "cloudevents") == true]
}

locals {
  vpnlogdef   = { for k, v in var.servicelogdefinition : k => v if contains(values(v), "oci_c3_vpn") == true }
  vpnloggroup = [for k, v in var.servicelogdefinition : v.loggroup if contains(values(v), "oci_c3_vpn") == true]
}
locals {
  lblogdef   = { for k, v in var.servicelogdefinition : k => v if contains(values(v), "loadbalancer") == true }
  lbloggroup = [for k, v in var.servicelogdefinition : v.loggroup if contains(values(v), "loadbalancer") == true]
}

locals {
  apigwlogdef   = { for k, v in var.servicelogdefinition : k => v if contains(values(v), "apigateway") == true }
  apigwloggroup = [for k, v in var.servicelogdefinition : v.loggroup if contains(values(v), "apigateway") == true]
}

locals {
  vcnlogdef   = { for k, v in var.servicelogdefinition : k => v if contains(values(v), "flowlogs") == true }
  vcnloggroup = [for k, v in var.servicelogdefinition : v.loggroup if contains(values(v), "flowlogs") == true]
}

locals {
  oslogdef   = { for k, v in var.servicelogdefinition : k => v if contains(values(v), "objectstorage") == true }
  osloggroup = [for k, v in var.servicelogdefinition : v.loggroup if contains(values(v), "objectstorage") == true]
}
