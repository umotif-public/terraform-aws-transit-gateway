##################
# Transit Gateway
##################
resource "aws_ec2_transit_gateway" "main" {

  description                     = var.description
  amazon_side_asn                 = var.amazon_side_asn
  default_route_table_association = var.enable_default_route_table_association ? "enable" : "disable"
  default_route_table_propagation = var.enable_default_route_table_propagation ? "enable" : "disable"
  auto_accept_shared_attachments  = var.enable_auto_accept_shared_attachments ? "enable" : "disable"
  dns_support                     = var.enable_dns_support ? "enable" : "disable"
  vpn_ecmp_support                = var.enable_vpn_ecmp_support ? "enable" : "disable"

  tags = var.tags
}

#################################
# VPC Attachements, Route Tables
#################################
resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  for_each = var.vpc_attachments

  vpc_id             = each.value["vpc_id"]
  subnet_ids         = each.value["subnet_ids"]
  transit_gateway_id = aws_ec2_transit_gateway.main.id

  appliance_mode_support                          = lookup(each.value, "application_mode_support", true) ? "enable" : "disable"
  dns_support                                     = lookup(each.value, "dns_support", true) ? "enable" : "disable"
  ipv6_support                                    = lookup(each.value, "ipv6_support", false) ? "enable" : "disable"
  transit_gateway_default_route_table_association = var.enable_default_route_table_association ? true : false
  transit_gateway_default_route_table_propagation = var.enable_default_route_table_propagation ? true : false

  tags = var.tags
}

resource "aws_ec2_transit_gateway_route_table" "main" {
  transit_gateway_id = aws_ec2_transit_gateway.main.id

  tags = var.tags
}

#########
# Routes
#########
resource "aws_ec2_transit_gateway_route" "main_routes" {
  count = length(local.tgw_routes)

  destination_cidr_block = local.tgw_routes[count.index][1]["destination_cidr_block"]

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main[local.tgw_routes[count.index][0]["vpc"]].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.main.id
}

resource "aws_ec2_transit_gateway_route" "blackhole_routes" {
  count = length(var.transit_gateway_blackhole_routes)

  destination_cidr_block = var.transit_gateway_blackhole_routes[count.index]
  blackhole              = true

  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.main.id
}

##########################
# Route Table Association
##########################
resource "aws_ec2_transit_gateway_route_table_association" "main" {
  for_each = local.no_default_rt_association

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main[each.key].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.main.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "main" {
  for_each = local.no_default_rt_propogation

  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.main[each.key].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.main.id
}
