#VCN loggroup resource
resource "oci_logging_log_group" "vcnloggroup" {

  for_each = toset(local.vcnloggroup)


  compartment_id = var.compartment_ocid
  display_name   = each.value

  freeform_tags = var.log_group_freeform_tags

}

#Loadbalancer loggroup resource
resource "oci_logging_log_group" "lbloggroup" {

  for_each = toset(local.lbloggroup)


  compartment_id = var.compartment_ocid
  display_name   = each.value

  freeform_tags = var.log_group_freeform_tags

}

#ObjectStorage loggroup resource
resource "oci_logging_log_group" "osloggroup" {

  for_each = toset(local.osloggroup)


  compartment_id = var.compartment_ocid
  display_name   = each.value

  freeform_tags = var.log_group_freeform_tags

}

#APIGateway loggroup resource
resource "oci_logging_log_group" "apigwloggroup" {

  for_each = toset(local.apigwloggroup)


  compartment_id = var.compartment_ocid
  display_name   = each.value

  freeform_tags = var.log_group_freeform_tags

}

#Function loggroup resource
resource "oci_logging_log_group" "funcloggroup" {

  for_each = toset(local.funcloggroup)


  compartment_id = var.compartment_ocid
  display_name   = each.value

  freeform_tags = var.log_group_freeform_tags

}

#Event Service loggroup resource
resource "oci_logging_log_group" "eventloggroup" {

  for_each = toset(local.eventloggroup)


  compartment_id = var.compartment_ocid
  display_name   = each.value

  freeform_tags = var.log_group_freeform_tags

}

#VPN loggroup resource
resource "oci_logging_log_group" "vpnloggroup" {

  for_each = toset(local.vpnloggroup)


  compartment_id = var.compartment_ocid
  display_name   = each.value

  freeform_tags = var.log_group_freeform_tags

}

#Custom Linux loggroup resource
resource "oci_logging_log_group" "linuxloggroup" {

  for_each = toset(local.linuxloggroup)


  compartment_id = var.compartment_ocid
  display_name   = each.value

  freeform_tags = var.log_group_freeform_tags

}

#Custom windows loggroup resource
resource "oci_logging_log_group" "winloggroup" {

  for_each = toset(local.winloggroup)


  compartment_id = var.compartment_ocid
  display_name   = each.value

  freeform_tags = var.log_group_freeform_tags

}


module "vcnlog" {
  source                 = "./modules/vcn"
  compartment_ocid       = var.compartment_ocid
  logdefinition          = var.servicelogdefinition
  log_retention_duration = var.log_retention_duration
  log_is_enabled         = var.log_is_enabled
  loggroup               = oci_logging_log_group.vcnloggroup


  count = length(local.vcnlogdef) >= 1 ? 1 : 0

}

module "objectstorelog" {
  source                 = "./modules/objectstorage"
  compartment_ocid       = var.compartment_ocid
  logdefinition          = var.servicelogdefinition
  log_retention_duration = var.log_retention_duration
  log_is_enabled         = var.log_is_enabled
  loggroup               = oci_logging_log_group.osloggroup

  count = length(local.oslogdef) >= 1 ? 1 : 0

}

module "funclog" {
  source                 = "./modules/function"
  compartment_ocid       = var.compartment_ocid
  logdefinition          = var.servicelogdefinition
  log_retention_duration = var.log_retention_duration
  log_is_enabled         = var.log_is_enabled
  loggroup               = oci_logging_log_group.funcloggroup


  count = length(local.funclogdef) >= 1 ? 1 : 0

}

module "eventlog" {
  source                 = "./modules/event"
  compartment_ocid       = var.compartment_ocid
  logdefinition          = var.servicelogdefinition
  log_retention_duration = var.log_retention_duration
  log_is_enabled         = var.log_is_enabled
  loggroup               = oci_logging_log_group.eventloggroup


  count = length(local.eventlogdef) >= 1 ? 1 : 0

}

module "vpnlog" {
  source                 = "./modules/vpn"
  compartment_ocid       = var.compartment_ocid
  logdefinition          = var.servicelogdefinition
  log_retention_duration = var.log_retention_duration
  log_is_enabled         = var.log_is_enabled
  loggroup               = oci_logging_log_group.vpnloggroup


  count = length(local.vpnlogdef) >= 1 ? 1 : 0

}
module "apigwlog" {
  source                 = "./modules/apigateway"
  compartment_ocid       = var.compartment_ocid
  logdefinition          = var.servicelogdefinition
  log_retention_duration = var.log_retention_duration
  log_is_enabled         = var.log_is_enabled
  loggroup               = oci_logging_log_group.apigwloggroup


  count = length(local.apigwlogdef) >= 1 ? 1 : 0

}

module "lblog" {
  source                 = "./modules/lb"
  compartment_ocid       = var.compartment_ocid
  logdefinition          = var.servicelogdefinition
  log_retention_duration = var.log_retention_duration
  log_is_enabled         = var.log_is_enabled
  loggroup               = oci_logging_log_group.lbloggroup


  count = length(local.lblogdef) >= 1 ? 1 : 0

}

module "customlog" {
  source                 = "./modules/custom"
  compartment_ocid       = var.compartment_ocid
  linuxlogdefinition     = var.linuxlogdefinition
  winlogdefinition       = var.winlogdefinition
  log_retention_duration = var.log_retention_duration
  log_is_enabled         = var.log_is_enabled
  tenancy_ocid           = var.tenancy_ocid
  linuxloggroup          = oci_logging_log_group.linuxloggroup
  winloggroup            = oci_logging_log_group.winloggroup


  count = (length(var.linuxlogdefinition)) >= 1 || (length(var.winlogdefinition)) >= 1 ? 1 : 0

}


