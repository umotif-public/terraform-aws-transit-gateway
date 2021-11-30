#################
# Transit Gateway
#################
output "transit_gateway_arn" {
  description = "Transit Gateway Amazon Resource Name (ARN)"
  value       = aws_ec2_transit_gateway.main.arn
}

output "transit_gateway_id" {
  description = "Transit Gateway Identifier"
  value       = aws_ec2_transit_gateway.main.id
}

output "transit_gateway_asn" {
  description = "The Private Autonomous System Number (ASN) of the Transit Gateway"
  value       = aws_ec2_transit_gateway.main.amazon_side_asn
}

output "transit_gateway_association_default_route_table_id" {
  description = "Identifier of the default association route table id"
  value       = concat(aws_ec2_transit_gateway.main[*].association_default_route_table_id, [""])[0]
}

output "transit_gateway_propagation_default_route_table_id" {
  description = "Identifier of the default propagation route table"
  value       = concat(aws_ec2_transit_gateway.main[*].propagation_default_route_table_id, [""])[0]
}

##############################
# Attachments and Route Tables
##############################
output "transit_gateway_attachments_ids" {
  description = "List of VPC Attachments identifiers"
  value       = [for k, v in aws_ec2_transit_gateway_vpc_attachment.main : v.id]
}

output "transit_gateway_route_table_id" {
  description = "Transit Gateway Route Table Identifier"
  value       = aws_ec2_transit_gateway_route_table.main.id
}

output "transit_gateway_route_table_arn" {
  description = "Transit Gateway Route Table ARN"
  value       = aws_ec2_transit_gateway_route_table.main.arn
}

output "transit_gateway_route_table_association_ids" {
  description = "List of Transit Gateway Route Table identifiers combined with Transit Gateway Attachment identifiers"
  value       = [for k, v in aws_ec2_transit_gateway_route_table_association.main : v.id]
}

output "transit_gateway_route_table_association_resource_ids" {
  description = "List of identifiers of the resources"
  value       = [for k, v in aws_ec2_transit_gateway_route_table_association.main : v.resource_id]
}

output "transit_gateway_route_table_association_resource_types" {
  description = "List of types of resources"
  value       = [for k, v in aws_ec2_transit_gateway_route_table_association.main : v.resource_type]
}

output "transit_gateway_route_table_propagation_ids" {
  description = "List of Transit Gateway Route Table identifiers combined with Transit Gateway Attachment identifiers"
  value       = [for k, v in aws_ec2_transit_gateway_route_table_propagation.main : v.id]
}

output "transit_gateway_route_table_propagation_resource_ids" {
  description = "List of identifiers of the resources"
  value       = [for k, v in aws_ec2_transit_gateway_route_table_propagation.main : v.resource_id]
}

output "transit_gateway_route_table_propagation_resource_types" {
  description = "List of types of resources"
  value       = [for k, v in aws_ec2_transit_gateway_route_table_propagation.main : v.resource_type]
}