

module "c19c7c1pdpci-sa-01" {
  source        = "../../../modules/service_accounts"
  project_id    = var.hstProjectId
  names         = ["c19c7c1pdpci-sa-01"]
  display_name  =  "c19c7c1pdpci-sa-01"
  description = "Service Account For Compute Instances"
  project_roles = [
    "${var.hstProjectId}=>roles/editor"
  ]
}


/*******************************************************
Service account and permissions for Fortigate servers

*******************************************************/



resource "google_project_iam_custom_role" "c19c7c1pdpfg-ro-01" {
  role_id     = "c19c7c1pdpfgro01"
  title       = "Fortigate Firewall Compute Access"
  description = "Custom Role for Firewall to access backup stored in GCS"
  permissions = [
            "compute.addresses.get", 
            "compute.addresses.use", 
            "compute.instances.addAccessConfig",
            "compute.instances.deleteAccessConfig",
            "compute.instances.get",
            "compute.instances.list",
            "compute.instances.updateNetworkInterface",
            "compute.networks.updatePolicy",
            "compute.networks.useExternalIp",
            "compute.subnetworks.use",
            "compute.subnetworks.useExternalIp",
            "compute.routes.create",
            "compute.routes.delete",
            "compute.routes.get",
            "compute.routes.list"          
            ]
}

module "c19c7c1pdpci-sa-07" {
  source        = "../../../modules/service_accounts"
  project_id    = var.hstProjectId
  names         = ["c19c7c1pdpci-sa-07"]
  display_name  =  "c19c7c1pdpci-sa-07"
  description = "Service Account For Fortigate VMs with IAM access for HA Failover"
  project_roles = [
    "${var.hstProjectId}=>${google_project_iam_custom_role.c19c7c1pdpfg-ro-01.id}"
  ]
}

