
/*********************************************************************
	VPC and subnet configuration SAP Non-Prod VPC (Spoke) network
 ********************************************************************/
module "c19c7c1pdnvc-05" {
  source                                 = "../../../modules/vpc"
  network_name                           = "c19c7c1pdnvc-05"
  auto_create_subnetworks                = false
  project_id                             = var.hstProjectId
  description                            = "SAP Non-Prod VPC (Spoke)"
  delete_default_internet_gateway_routes = true
}

module "c19c7c1pdnvc-05-subnets" {
  source           = "../../../modules/subnets"
  project_id       = var.hstProjectId
  network_name     = module.c19c7c1pdnvc-05.network_name
  subnets          = [
        {
            subnet_name           = "c19c7c1pdnap-sb-01"
            subnet_ip             = "10.165.20.0/25"
            subnet_region         = "asia-south1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "App Subnet (Non-Prod)"
        },
        {
            subnet_name           = "c19c7c1pdndb-sb-01"
            subnet_ip             = "10.165.20.128/25"
            subnet_region         = "asia-south1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "DB subnet (Non-Prod)"
        }
    ]
}

resource "google_compute_subnetwork_iam_member" "c19c7c1pdntf-sa-01-nprod-subnet-access" {
  for_each = toset([
      module.c19c7c1pdnvc-05-subnets.subnets["asia-south1/c19c7c1pdnap-sb-01"].id,
      module.c19c7c1pdnvc-05-subnets.subnets["asia-south1/c19c7c1pdndb-sb-01"].id
  ])
  project = var.hstProjectId
  region = "asia-south1"
  subnetwork = each.value
  role = "roles/compute.networkUser"
  member = "serviceAccount:${var.nprodTfServiceAccount}"
}
