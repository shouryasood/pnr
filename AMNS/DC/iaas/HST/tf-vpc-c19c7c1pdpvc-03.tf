
/*********************************************************************
	VPC and subnet configuration Transit Network VPC (Gateway) network
 ********************************************************************/
module "c19c7c1pdpvc-03" {
  source                                 = "../../../modules/vpc"
  network_name                           = "c19c7c1pdpvc-03"
  auto_create_subnetworks                = false
  project_id                             = var.hstProjectId
  description                            = "Infra & Shared subnet (Hub)"
  delete_default_internet_gateway_routes = true
}

module "c19c7c1pdpvc-03-subnets" {
  source           = "../../../modules/subnets"
  project_id       = var.hstProjectId
  network_name     = module.c19c7c1pdpvc-03.network_name
  subnets          = [
        {
            subnet_name           = "c19c7c1pdpis-sb-01"
            subnet_ip             = "10.165.18.0/24"
            subnet_region         = "asia-south1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "Infra Subnet"
        }
    ]
}


resource "google_compute_subnetwork_iam_member" "c19c7c1pdpvc-03-subnet-access" {
  for_each = toset([
      var.nprodTfServiceAccount,
      var.prodTfServiceAccount,
      var.infTfServiceAccount
  ])
  project = var.hstProjectId
  region = "asia-south1"
  subnetwork = module.c19c7c1pdpvc-03-subnets.subnets["asia-south1/c19c7c1pdpis-sb-01"].id
  role = "roles/compute.networkUser"
  member = "serviceAccount:${each.value}"
}