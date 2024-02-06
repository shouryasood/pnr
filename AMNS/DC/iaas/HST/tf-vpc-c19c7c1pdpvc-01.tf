
/*****************************************************
	VPC and subnet configuration prod egress network
 ****************************************************/
module "c19c7c1pdpvc-01" {
  source                                 = "../../../modules/vpc"
  network_name                           = "c19c7c1pdpvc-01"
  auto_create_subnetworks                = false
  project_id                             = var.hstProjectId
  description                            = "External Network VPC (Untrust)"
#  delete_default_internet_gateway_routes = true
}

module "c19c7c1pdpvc-01-subnets" {
  source           = "../../../modules/subnets"
  project_id       = var.hstProjectId
  network_name     = module.c19c7c1pdpvc-01.network_name
  subnets          = [
        {
            subnet_name           = "c19c7c1pdpfw-sb-01"
            subnet_ip             = "10.165.16.0/25"
            subnet_region         = "asia-south1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "FW Subnet (External)"
        }
    ]
}
