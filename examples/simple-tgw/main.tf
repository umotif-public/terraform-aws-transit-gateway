provider "aws" {
  region = "eu-west-1"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

#####
# VPC and Subnets
#####
module "vpc1" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = "vpc1"

  cidr = "10.0.0.0/16"

  azs            = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  enable_nat_gateway = false

  tags = {
    Environment = "test"
  }
}

module "vpc2" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = "vpc2"

  cidr = "10.1.0.0/16"

  azs            = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  public_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]

  enable_nat_gateway = false

  tags = {
    Environment = "test"
  }
}

####
# Transit Gateway
####
module "transit_gateway" {
  source = "../.."

  enable_default_route_table_association = false
  enable_default_route_table_propagation = false

  vpc_attachments = {
    vpc1 = {
      vpc_id     = module.vpc1.vpc_id
      subnet_ids = module.vpc1.public_subnets

      transit_gateway_routes = [
        {
          destination_cidr_block = module.vpc1.vpc_cidr_block
        }
      ]
    },

    vpc2 = {
      vpc_id     = module.vpc2.vpc_id
      subnet_ids = module.vpc2.public_subnets

      transit_gateway_routes = [
        {
          destination_cidr_block = module.vpc2.vpc_cidr_block
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

resource "aws_route" "vpc1_tgw_routes" {
  route_table_id         = module.vpc1.vpc_main_route_table_id
  destination_cidr_block = module.vpc2.vpc_cidr_block
  transit_gateway_id     = module.transit_gateway.transit_gateway_id

  depends_on = [module.vpc1.vpc_id]
}

resource "aws_route" "vpc2_tgw_routes" {
  route_table_id         = module.vpc2.vpc_main_route_table_id
  destination_cidr_block = module.vpc1.vpc_cidr_block
  transit_gateway_id     = module.transit_gateway.transit_gateway_id

  depends_on = [module.vpc2.vpc_id]
}