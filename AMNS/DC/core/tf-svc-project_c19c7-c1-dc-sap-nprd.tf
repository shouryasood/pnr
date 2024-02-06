/**************************************
Create SAP NPROD project
**************************************/


resource "google_project" "c19c7-c1-dc-sap-nprd" {
  name       = "C19C7-C1-DC-SAP-NPRD"
  project_id = "c19c7-c1-dc-sap-nprd"
  folder_id  = google_folder.c19c7c1dc-folders["C19C7-C1-DC-SAP"].name
  billing_account = var.amnsDcBillingAccount
  auto_create_network = false
}

resource "google_compute_shared_vpc_service_project" "c19c7-c1-dc-sap-nprd" {
  host_project    = google_compute_shared_vpc_host_project.dchost.project
  service_project = google_project.c19c7-c1-dc-sap-nprd.project_id
}

resource "google_project_service" "c19c7-c1-dc-sap-nprd-services" {
  for_each = toset([
      "iam.googleapis.com",
      "compute.googleapis.com",
      "cloudresourcemanager.googleapis.com"
  ])  
  project = google_project.c19c7-c1-dc-sap-nprd.project_id
  service = each.value
  disable_dependent_services = true
}

/********************************************************************************
Service Account and access confiration for Terraform to build resources in SAP NPROD Project - PD Region

********************************************************************************/

module "c19c7c1pdntf-sa-01" {
  source        = "../../modules/service_accounts"
  project_id    = google_project.c19c7-c1-dc-sap-nprd.project_id
  names         = ["c19c7c1pdntf-sa-01"]
  display_name  =  "c19c7c1pdntf-sa-01"
  description = "Service Account for Terraform to build resources in SAP NPROD Project - PD Region"
  project_roles = [
    "${google_project.c19c7-c1-dc-sap-nprd.project_id}=>roles/viewer",
    "${google_project.c19c7-c1-dc-sap-nprd.project_id}=>roles/storage.admin",
    "${google_project.c19c7-c1-dc-sap-nprd.project_id}=>roles/compute.instanceAdmin.v1",
    "${google_project.c19c7-c1-dc-sap-nprd.project_id}=>roles/iam.serviceAccountUser",
    "${google_project.c19c7-c1-dc-inf.project_id}=>roles/compute.imageUser"
  ]
}

resource "google_service_account_iam_member" "c19c7c1pdntf-sa-01-allow-impersonation" {
  for_each = toset([
      "group:c19c7c1-gp-ed@amns.in",
#      "user:vivek.anand@sifycorp.com",
      "group:c19c7c1-gp-am@amns.in"
  ])  
  service_account_id = module.c19c7c1pdntf-sa-01.service_accounts_map.c19c7c1pdntf-sa-01.name
  role               = "roles/iam.serviceAccountTokenCreator"
  member             = each.value
}




# Creating GCS bucket for IAC[Terraform] state Backend for this project

resource "google_storage_bucket" "c19c7c1pdpcs-04" {
  name          = "c19c7c1pdpcs-04"
  location      = "ASIA-SOUTH1"
  project       = google_project.c19c7-c1-dc-sap-nprd.project_id
  versioning {
      enabled = true
  }
}