

# Create external static ip in WAN for Jump Box
resource "google_compute_address" "c19c7c1pdpip-c19c7c1pdp99-ex" {
  name = "c19c7c1pdpip-c19c7c1pdp99-ex"
  address_type = "EXTERNAL"
  region       = "asia-south1"
}



# Create Data disk for for c19c7c1pdp99
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp99-01" {
  name = "c19c7c1pdppd-c19c7c1pdp99-01"
  size = 50
  zone = "asia-south1-a"
  description = "Data"
}



# Create c19c7c1pdp99 compute instance
resource "google_compute_instance" "c19c7c1pdp99" {
  name           = "c19c7c1pdp99"
  machine_type   = "n2-standard-2"
  zone           = "asia-south1-a"
  description = "JumpBox"
  tags = ["c19c7c1pdprd-nt-01","c19c7c1pdpal-nt-02"]
  project = "c19c7-c1-dc-inf"

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
      image = "windows-2019"
    }
  }
  attached_disk {
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp99-01.name
  }
  network_interface {
    subnetwork = var.infSubNetwork
    network_ip = "10.165.18.250"
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
      "application" =  "jumpbox"
      "costcenter"  = "c19c7"
      "backup"      = "yes"
      "optimization"  = "no"
  }
}
