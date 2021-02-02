locals {
  no_default_rt_association = { for k, v in var.vpc_attachments : k => v if var.enable_default_route_table_association == false }
  no_default_rt_propogation = { for k, v in var.vpc_attachments : k => v if var.enable_default_route_table_propagation == false }

  tgw_routes = chunklist(flatten([
    for k, v in var.vpc_attachments : setproduct([{ "vpc" = k }], v["transit_gateway_routes"]) if length(lookup(v, "transit_gateway_routes", {})) > 0
  ]), 2)
}