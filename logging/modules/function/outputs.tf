output "funclogid" {
  value = { for v in oci_logging_log.function_log : v.display_name => v.id }
}

output "funcloggroupid" {
  value = { for k, v in var.loggroup : v.display_name => v.id }
}
