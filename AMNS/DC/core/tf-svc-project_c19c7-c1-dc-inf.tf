/**************************************
Create INFRA project
**************************************/


resource "google_project" "c19c7-c1-dc-inf" {
  name       = "C19C7-C1-DC-INF"
  project_id = "c19c7-c1-dc-inf"
  folder_id  = google_folder.c19c7c1dc-folders["C19C7-C1-DC-INFRA"].name
  billing_account = var.amnsDcBillingAccount
  auto_create_network = false
}


resource "google_compute_shared_vpc_service_project" "c19c7-c1-dc-inf" {
  host_project    = google_compute_shared_vpc_host_project.dchost.project
  service_project = google_project.c19c7-c1-dc-inf.project_id
}

resource "google_project_service" "c19c7-c1-dc-inf-services" {
  for_each = toset([
        "compute.googleapis.com",
        "sourcerepo.googleapis.com",
        "iam.googleapis.com",
        "cloudresourcemanager.googleapis.com"
        ])
  project = google_project.c19c7-c1-dc-inf.project_id
  service = each.value
  disable_dependent_services = true
}


/********************************************************************************
Service Account and access confiration for Terraform to build resources in SAP INF Project - PD Region

********************************************************************************/

module "c19c7c1pdptf-sa-02" {
  source        = "../../modules/service_accounts"
  project_id    = google_project.c19c7-c1-dc-inf.project_id
  names         = ["c19c7c1pdptf-sa-02"]
  display_name  =  "c19c7c1pdptf-sa-02"
  description = "Service Account for Terraform to build resources in SAP PROD Project - PD Region"
  project_roles = [
    "${google_project.c19c7-c1-dc-inf.project_id}=>roles/viewer",
    "${google_project.c19c7-c1-dc-inf.project_id}=>roles/storage.admin",
    "${google_project.c19c7-c1-dc-inf.project_id}=>roles/compute.instanceAdmin.v1",
    "${google_project.c19c7-c1-dc-inf.project_id}=>roles/iam.serviceAccountUser"
  ]
}

resource "google_service_account_iam_member" "c19c7c1pdptf-sa-02-allow-impersonation" {
  for_each = toset([
      "group:c19c7c1-gp-ed@amns.in",
#      "user:vivek.anand@sifycorp.com",
      "group:c19c7c1-gp-am@amns.in"
  ])  
  service_account_id = module.c19c7c1pdptf-sa-02.service_accounts_map.c19c7c1pdptf-sa-02.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = each.value
}


# Creating GCS bucket for IAC[Terraform] state Backend for this project

resource "google_storage_bucket" "c19c7c1pdpcs-02" {
  name          = "c19c7c1pdpcs-02"
  location      = "ASIA-SOUTH1"
  project       = google_project.c19c7-c1-dc-inf.project_id
  versioning {
      enabled = true
  }
}
