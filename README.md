<!-- markdownlint-disable MD041 -->
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/umotif-public/terraform-aws-transit-gateway)](https://github.com/umotif-public/terraform-aws-transit-gateway/releases/latest)
[![Lint and Validate](https://github.com/umotif-public/terraform-aws-transit-gateway/workflows/Lint%20and%20Validate/badge.svg)](https://github.com/umotif-public/terraform-aws-transit-gateway/actions?query=workflow%3A%22Lint+and+Validate%22)

# Terraform AWS Transit Gateway

Terraform module to provision [AWS Transit Gateway](https://aws.amazon.com/transit-gateway/) resources.

## Terraform versions

Terraform 0.13. Pin module to version to `~> v1.0`. Submit pull-requests to `main` branch.

## Usage with VPC module

```terraform
module "transit_gateway" {
  source = "../.."

  vpc_attachments = {
    vpc = {
      vpc_id                                          = module.vpc.vpc_id
      subnet_ids                                      = module.vpc.private_subnets

      transit_gateway_routes = [
        {
          destination_cidr_block = "10.1.0.0/16"
        }
      ]
    }
  }

  transit_gateway_blackhole_routes = [
    "0.0.0.0/0"
  ]

  tags = {
    Project     = "test-tgw-terraform"
    Environment = "test"
  }
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = "vpc"

  cidr = "10.0.0.0/16"

  azs            = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  enable_nat_gateway = false

  tags = {
    Environment = "test"
  }
}

```

## Assumptions

Module is to be used with Terraform > 0.13.

## Examples

* [Simple Transit Gateway setup with two VPCs](https://github.com/umotif-public/terraform-aws-transit-gateway/tree/main/examples/simple-tgw)

## Authors

Module managed by:

* [Abdul Wahid](https://github.com/Ohid25) ([LinkedIn](https://www.linkedin.com/in/abdul-wahid))

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |
| aws | >= 3.11 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.11 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| amazon\_side\_asn | The Autonomous System Number (ASN) for the Amazon side of the gateway. By default the TGW is created with the current default Amazon ASN. | `string` | `"64512"` | no |
| description | Description of the Transit Gateway | `string` | `""` | no |
| enable\_auto\_accept\_shared\_attachments | Whether resource attachment requests are automatically accepted | `bool` | `false` | no |
| enable\_default\_route\_table\_association | Whether resource attachments are automatically associated with the default association route table | `bool` | `true` | no |
| enable\_default\_route\_table\_propagation | Whether resource attachments automatically propagate routes to the default propagation route table | `bool` | `true` | no |
| enable\_dns\_support | Should be true to enable DNS support in the TGW | `bool` | `true` | no |
| enable\_vpn\_ecmp\_support | Whether VPN Equal Cost Multipath Protocol support is enabled | `bool` | `true` | no |
| tags | A map of tags to add to all resources | `map(string)` | `{}` | no |
| transit\_gateway\_blackhole\_routes | Transit Gateway Blackhole Routes | `list(string)` | `[]` | no |
| transit\_gateway\_route\_table\_id | Identifier of EC2 Transit Gateway Route Table to use with the Target Gateway when reusing it between multiple TGWs | `string` | `null` | no |
| vpc\_attachments | Maps of maps of VPC details to attach to TGW. | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| transit\_gateway\_arn | Transit Gateway Amazon Resource Name (ARN) |
| transit\_gateway\_asn | The Private Autonomous System Number (ASN) of the Transit Gateway |
| transit\_gateway\_association\_default\_route\_table\_id | Identifier of the default association route table id |
| transit\_gateway\_attachments\_ids | List of VPC Attachments identifiers |
| transit\_gateway\_id | Transit Gateway Identifier |
| transit\_gateway\_propagation\_default\_route\_table\_id | Identifier of the default propagation route table |
| transit\_gateway\_route\_table\_arn | Transit Gateway Route Table ARN |
| transit\_gateway\_route\_table\_association\_ids | List of Transit Gateway Route Table identifiers combined with Transit Gateway Attachment identifiers |
| transit\_gateway\_route\_table\_association\_resource\_ids | List of identifiers of the resources |
| transit\_gateway\_route\_table\_association\_resource\_types | List of types of resources |
| transit\_gateway\_route\_table\_id | Transit Gateway Route Table Identifier |
| transit\_gateway\_route\_table\_propagation\_ids | List of Transit Gateway Route Table identifiers combined with Transit Gateway Attachment identifiers |
| transit\_gateway\_route\_table\_propagation\_resource\_ids | List of identifiers of the resources |
| transit\_gateway\_route\_table\_propagation\_resource\_types | List of types of resources |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## License

See LICENSE for full details.

## Pre-commit hooks

### Install dependencies

* [`pre-commit`](https://pre-commit.com/#install)
* [`terraform-docs`](https://github.com/segmentio/terraform-docs) required for `terraform_docs` hooks.
* [`TFLint`](https://github.com/terraform-linters/tflint) required for `terraform_tflint` hook.

#### MacOS

```bash
brew install pre-commit terraform-docs tflint

brew tap git-chglog/git-chglog
brew install git-chglog
```
