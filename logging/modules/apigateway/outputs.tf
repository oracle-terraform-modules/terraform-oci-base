output "apigwaccesslogid" {
  value = { for v in oci_logging_log.apigw_access_log : v.display_name => v.id }
}

output "apigwexeclogid" {
  value = { for v in oci_logging_log.apigw_exec_log : v.display_name => v.id }
}

output "apigwloggroupid" {
  value = { for k, v in var.loggroup : v.display_name => v.id }
}
