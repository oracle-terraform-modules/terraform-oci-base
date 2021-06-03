output "osreadlogid" {
  value = { for v in oci_logging_log.os_read_log : v.display_name => v.id }
}

output "oswritelogid" {
  value = { for v in oci_logging_log.os_write_log : v.display_name => v.id }
}

output "osloggroupid" {
  value = { for k, v in var.loggroup : v.display_name => v.id }
}
