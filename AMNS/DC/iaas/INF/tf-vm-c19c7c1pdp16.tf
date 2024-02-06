

# Create static lan  ip private
resource "google_compute_address" "c19c7c1pdpip-c19c7c1pdp16-ln" {
  name = "c19c7c1pdpip-c19c7c1pdp16-ln"
  subnetwork   = var.infSubNetwork
  address_type = "INTERNAL"
  region       = "asia-south1"
  address      = "10.165.18.248"
}

# Create additional disk for for c19c7c1pdp16
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp16-01" {
  name = "c19c7c1pdppd-c19c7c1pdp16-01"
  size = 150
  type = "pd-ssd"
  zone = "asia-south1-a"
  description = "UIM-GCP-CLOUD-HUB-L1 Addiotional drive"
}

# Create c19c7c1pdp16 compute instance
resource "google_compute_instance" "c19c7c1pdp16" {
  name           = "c19c7c1pdp16"
  machine_type   = "n2-standard-4"
  zone           = "asia-south1-a"
  description = "UIM-GCP-CLOUD-HUB-L1 - Prod"
  tags = ["c19c7c1pdpal-nt-02"]
  hostname = "c19c7c1pdp16.amns.in"
  project = var.infProjectIdPd

  shielded_instance_config {
      enable_secure_boot = true
      enable_vtpm = true
      enable_integrity_monitoring = true
  }
  deletion_protection = true

  boot_disk {
    auto_delete = false
    initialize_params {
      size = 150
      image = "windows-2016"
      type = "pd-ssd"
    }
  }
  attached_disk {
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp16-01.name
    device_name = "app"
  }
    
  network_interface {
    subnetwork = var.infSubNetwork
    network_ip = google_compute_address.c19c7c1pdpip-c19c7c1pdp16-ln.address
  }

  service_account {
    email  = module.c19c7c1pdpci-sa-02.email
    scopes = ["userinfo-email","compute-ro","storage-ro"]
  }
  scheduling {
    automatic_restart = false
  }
  labels =  {
      "environment" = "prd"
      "vmrole"      = "ap"
      "application" =  "uim_gcp_cloud_hub_l1"
      "costcenter"  = "c19c7"
      "backup"      = "yes"
      "optimization"  = "yes"
      "apowner"       = "geeta_patil"
      "owneremail"   = "geeta_patil_amns_in"
  }
}
