## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| oci | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| apigwlog | ./modules/apigateway |  |
| eventlog | ./modules/event |  |
| funclog | ./modules/function |  |
| lblog | ./modules/lb |  |
| objectstorelog | ./modules/objectstorage |  |
| vcnlog | ./modules/vcn |  |
| vpnlog | ./modules/vpn |  |

## Resources

| Name |
|------|
| [oci_logging_log_group](https://registry.terraform.io/providers/hashicorp/oci/latest/docs/resources/logging_log_group) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| compartment\_ocid | compartment OCID | `string` | n/a | yes |
| log\_group\_freeform\_tags | Freeform Tags | `map` | <pre>{<br>  "Environment": "Dev"<br>}</pre> | no |
| log\_is\_enabled | log enabled | `bool` | `false` | no |
| log\_retention\_duration | Log retention duration | `number` | `30` | no |
| servicelogdefinition | Service Log Definition | `map(any)` | `{}` | no |
| tenancy\_ocid | Tenancy OCID | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| apigwaccesslogid | APIGateway access logs id |
| apigwexeclogid | APIGateway execution logs id |
| apigwloggroupid | APIGateway loggroup id |
| eventloggroupid | Event loggroup id |
| eventlogid | Event logs id |
| funclogid | Function logs id |
| functloggroupid | Function loggroup id |
| lbaccesslogid | Loadbalancer access logs id |
| lberrorlogid | Loadbalancer error logs id |
| lbloggroupid | Loadbalancer loggroup id |
| osloggroupid | ObjectStorage loggroup id |
| osreadlogid | ObjectStorage read logs id |
| oswritelogid | ObjectStorage write logs id |
| vcnloggroupid | VCN subnet flowlogs loggroup id |
| vcnlogid | VCN subnet flowlogs log id |
| vpngroupid | VPN IPSEC loggroup id |
| vpnlogid | VPN  IPSEC read logs id |
