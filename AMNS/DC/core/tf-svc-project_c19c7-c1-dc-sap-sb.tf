/**************************************
Create SAP PROD project
**************************************/


resource "google_project" "c19c7-c1-dc-sap-sb" {
  name       = "C19C7-C1-DC-SAP-SB"
  project_id = "c19c7-c1-dc-sap-sb"
  folder_id  = google_folder.c19c7c1dc-folders["C19C7-C1-DC-SAP"].name
  billing_account = var.amnsDcBillingAccount
  auto_create_network = false
}

resource "google_compute_shared_vpc_service_project" "c19c7-c1-dc-sap-sb" {
  host_project    = google_compute_shared_vpc_host_project.dchost.project
  service_project = google_project.c19c7-c1-dc-sap-sb.project_id
}

resource "google_project_service" "c19c7-c1-dc-sap-sb-services" {
  project = google_project.c19c7-c1-dc-sap-sb.project_id
  service = "compute.googleapis.com"
  disable_dependent_services = true
}


# Creating GCS bucket for IAC[Terraform] state Backend for this project

resource "google_storage_bucket" "c19c7c1pdpcs-05" {
  name          = "c19c7c1pdpcs-05"
  location      = "ASIA-SOUTH1"
  project       = google_project.c19c7-c1-dc-sap-sb.project_id
  versioning {
      enabled = true
  }
}
