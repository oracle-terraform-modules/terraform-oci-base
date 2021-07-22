output "vcnlogid" {
  value = { for k, v in oci_logging_log.vcn_log : v.display_name => v.id }
}

output "vcnloggroupid" {
  value = { for k, v in var.loggroup : v.display_name => v.id }
}
