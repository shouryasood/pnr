
/*********************************************************************
	VPC and subnet configuration Transit Network VPC (Gateway) network
 ********************************************************************/
module "c19c7c1pdpvc-04" {
  source                                 = "../../../modules/vpc"
  network_name                           = "c19c7c1pdpvc-04"
  auto_create_subnetworks                = false
  project_id                             = var.hstProjectId
  description                            = "SAP Prod VPC (Spoke)"
  delete_default_internet_gateway_routes = true
}

module "c19c7c1pdpvc-04-subnets" {
  source           = "../../../modules/subnets"
  project_id       = var.hstProjectId
  network_name     = module.c19c7c1pdpvc-04.network_name
  subnets          = [
        {
            subnet_name           = "c19c7c1pdpap-sb-01"
            subnet_ip             = "10.165.19.0/25"
            subnet_region         = "asia-south1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "App Subnet (Prod)"
        },
        {
            subnet_name           = "c19c7c1pdpdb-sb-01"
            subnet_ip             = "10.165.19.128/25"
            subnet_region         = "asia-south1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "DB subnet (Prod)"
        }
    ]
}


resource "google_compute_subnetwork_iam_member" "c19c7c1pdptf-sa-03-prod-subnet-access" {
  for_each = toset([
      module.c19c7c1pdpvc-04-subnets.subnets["asia-south1/c19c7c1pdpap-sb-01"].id,
      module.c19c7c1pdpvc-04-subnets.subnets["asia-south1/c19c7c1pdpdb-sb-01"].id
  ])
  project = var.hstProjectId
  region = "asia-south1"
  subnetwork = each.value
  role = "roles/compute.networkUser"
  member = "serviceAccount:${var.prodTfServiceAccount}"
}