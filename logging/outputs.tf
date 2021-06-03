#VCN log and loggroup id
output "vcnlogid" {
  value       = try(module.vcnlog[0].vcnlogid, "")
  description = "VCN subnet flowlogs log id"

}

output "vcnloggroupid" {
  value       = try(module.vcnlog[0].vcnloggroupid, "")
  description = "VCN subnet flowlogs loggroup id"
}

#APIGW log and loggroup id
output "apigwexeclogid" {
  value       = try(module.apigwlog[0].apigwexeclogid, "")
  description = "APIGateway execution logs id"
}

output "apigwaccesslogid" {
  value       = try(module.apigwlog[0].apigwloggroupid, "")
  description = "APIGateway access logs id"
}

output "apigwloggroupid" {
  value       = try(module.apigwlog[0].apigwloggroupid, "")
  description = "APIGateway loggroup id"
}

#Function log and loggroup id
output "funclogid" {
  value       = try(module.funclog[0].functionlogid, "")
  description = "Function logs id"
}

output "functloggroupid" {
  value       = try(module.funclog[0].funcloggroupid, "")
  description = "Function loggroup id"
}

#Loadbalancer log and loggroup id
output "lbaccesslogid" {
  value       = try(module.lblog[0].lbaccesslogid, "")
  description = "Loadbalancer access logs id"
}

output "lberrorlogid" {
  value       = try(module.lblog[0].lberrorlogid, "")
  description = "Loadbalancer error logs id"
}

output "lbloggroupid" {
  value       = try(module.lblog[0].lbloggroupid, "")
  description = "Loadbalancer loggroup id"
}

#ObjectStorage log  and loggroup id
output "osreadlogid" {
  value       = try(module.objectstorelog[0].osreadlogid, "")
  description = "ObjectStorage read logs id"
}

output "oswritelogid" {
  value       = try(module.objectstorelog[0].oswritelogid, "")
  description = "ObjectStorage write logs id"
}

output "osloggroupid" {
  value       = try(module.objectstorelog[0].osloggroupid, "")
  description = "ObjectStorage loggroup id"
}

#vpn log and loggroup id
output "vpnlogid" {
  value       = try(module.vpnlog[0].vpnlogid, "")
  description = "VPN  IPSEC read logs id"
}

output "vpngroupid" {
  value       = try(module.vpnlog[0].vpnloggroupid, "")
  description = "VPN IPSEC loggroup id"

}

#event log and loggroup id
output "eventlogid" {
  value       = try(module.eventlog[0].eventlogid, "")
  description = "Event logs id"
}

output "eventloggroupid" {
  value       = try(module.eventlog[0].eventloggroupid, "")
  description = "Event loggroup id"

}