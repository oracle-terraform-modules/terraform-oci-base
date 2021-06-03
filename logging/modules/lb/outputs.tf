output "lbaccesslogid" {
  value = { for v in oci_logging_log.lb_access_log : v.display_name => v.id }
}

output "lberrorlogid" {
  value = { for v in oci_logging_log.lb_error_log : v.display_name => v.id }
}

output "lbloggroupid" {
  value = { for k, v in var.loggroup : v.display_name => v.id }
}
