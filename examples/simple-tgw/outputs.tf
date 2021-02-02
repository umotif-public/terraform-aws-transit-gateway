#################
# Transit Gateway
#################
output "transit_gateway_arn" {
  description = "Transit Gateway Amazon Resource Name (ARN)"
  value       = module.transit_gateway.transit_gateway_arn
}

output "transit_gateway_id" {
  description = "Transit Gateway Identifier"
  value       = module.transit_gateway.transit_gateway_id
}

output "transit_gateway_asn" {
  description = "The Private Autonomous System Number (ASN) of the Transit Gateway"
  value       = module.transit_gateway.transit_gateway_asn
}

##############################
# Attachments and Route Tables
##############################
output "transit_gateway_attachments_ids" {
  description = "List of VPC Attachments identifiers"
  value       = module.transit_gateway.transit_gateway_attachments_ids
}

output "transit_gateway_route_table_id" {
  description = "Transit Gateway Route Table Identifier"
  value       = module.transit_gateway.transit_gateway_route_table_id
}

output "transit_gateway_route_table_arn" {
  description = "Transit Gateway Route Table ARN"
  value       = module.transit_gateway.transit_gateway_route_table_arn
}

output "transit_gateway_route_table_association_ids" {
  description = "List of Transit Gateway Route Table identifiers combined with Transit Gateway Attachment identifiers"
  value       = module.transit_gateway.transit_gateway_route_table_association_ids
}

output "transit_gateway_route_table_association_resource_ids" {
  description = "List of identifiers of the resources"
  value       = module.transit_gateway.transit_gateway_route_table_association_resource_ids
}

output "transit_gateway_route_table_association_resource_types" {
  description = "List of types of resources"
  value       = module.transit_gateway.transit_gateway_route_table_association_resource_types
}

output "transit_gateway_route_table_propagation_ids" {
  description = "List of Transit Gateway Route Table identifiers combined with Transit Gateway Attachment identifiers"
  value       = module.transit_gateway.transit_gateway_route_table_propagation_ids
}

output "transit_gateway_route_table_propagation_resource_ids" {
  description = "List of identifiers of the resources"
  value       = module.transit_gateway.transit_gateway_route_table_propagation_resource_ids
}

output "transit_gateway_route_table_propagation_resource_types" {
  description = "List of types of resources"
  value       = module.transit_gateway.transit_gateway_route_table_propagation_resource_types
}