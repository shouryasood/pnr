module "c19c7-dc-inf-sap-prd-peering" {
  source = "../../../modules/vpc-peering"
  depends_on = [
    module.c19c7c1pdpvc-03-subnets,
    module.c19c7c1pdpvc-04-subnets
  ]
  local_network = module.c19c7c1pdpvc-03.network_self_link
  peer_network = module.c19c7c1pdpvc-04.network_self_link
  export_local_custom_routes = true
}

module "c19c7-dc-inf-sap-nprd-peering" {
  source = "../../../modules/vpc-peering"
  depends_on = [
    module.c19c7c1pdpvc-03-subnets,
    module.c19c7c1pdnvc-05-subnets
  ]
  local_network = module.c19c7c1pdpvc-03.network_self_link
  peer_network = module.c19c7c1pdnvc-05.network_self_link
  export_local_custom_routes = true
}
