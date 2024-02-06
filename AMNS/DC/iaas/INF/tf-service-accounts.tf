

module "c19c7c1pdpci-sa-02" {
  source        = "../../../modules/service_accounts"
  project_id    = var.infProjectIdPd
  names         = ["c19c7c1pdpci-sa-02"]
  display_name  =  "c19c7c1pdpci-sa-02"
  description = "Service Account For Compute Instances in INF Project - PD Region"
  project_roles = [
    "${var.infProjectIdPd}=>roles/editor"
  ]
}

/*******************************************************
Service account and permissions for commvault media server

*******************************************************/


resource "google_project_iam_custom_role" "c19c7c1pdpcv-ro-01" {
  role_id     = "c19c7c1pdpcvro01"
  title       = "CommVault Storage Access"
  description = "Custom Role for Commvault to access backup stored in GCS"
  permissions = [
            "storage.buckets.get", 
            "storage.buckets.list", 
            "storage.buckets.update",
            "storage.objects.create",
            "storage.objects.delete",
            "storage.objects.list"           
            ]
}

module "c19c7c1pdpci-sa-06" {
  source        = "../../../modules/service_accounts"
  project_id    = var.infProjectIdPd
  names         = ["c19c7c1pdpci-sa-06"]
  display_name  =  "c19c7c1pdpci-sa-06"
  description = "Service Account For Commvault Media Server to access s3 bucket"
  project_roles = [
    "${var.infProjectIdPd}=>${google_project_iam_custom_role.c19c7c1pdpcv-ro-01.id}",
  ]
}

/*******************************************************
Service account and permissions for commvault media server

*******************************************************/

module "c19c7c1pdpls-sa-07" {
  source        = "../../../modules/service_accounts"
  project_id    = var.infProjectIdPd
  names         = ["c19c7c1pdpls-sa-07"]
  display_name  =  "c19c7c1pdpls-sa-07"
  description = "Service Account For pubsub access from SIEM server"
  project_roles = [
    "${var.infProjectIdPd}=>roles/pubsub.publisher",
  ]
}