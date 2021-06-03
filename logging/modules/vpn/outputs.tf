output "vpnlogid" {
  value = { for v in oci_logging_log.oci_c3_vpn_log : v.display_name => v.id }
}

output "vpnloggroupid" {
  value = { for k, v in var.loggroup : v.display_name => v.id }
}
