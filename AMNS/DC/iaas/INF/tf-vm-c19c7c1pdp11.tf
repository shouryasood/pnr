


# Create Commmvault App disk for for c19c7c1pdp11
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp11-01" {
  name = "c19c7c1pdppd-c19c7c1pdp11-01"
  size = 200
  type = "pd-ssd"
  zone = "asia-south1-a"
  description = "Commmvault App disk"
}

# Create DR Backup disk for for c19c7c1pdp11
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp11-02" {
  name = "c19c7c1pdppd-c19c7c1pdp11-02"
  size = 200
  type = "pd-ssd"
  zone = "asia-south1-a"
  description = "DR Backup"
}


# Create c19c7c1pdp11 compute instance
resource "google_compute_instance" "c19c7c1pdp11" {
  name           = "c19c7c1pdp11"
  machine_type   = "e2-standard-4"
  zone           = "asia-south1-a"
  description = "Backup-Commserver"
  tags = ["c19c7c1pdpal-nt-02"]
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
      size = 100
      image = "windows-2019"
      type = "pd-ssd"
    }
  }
  attached_disk {
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp11-01.name
  }
  attached_disk {
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp11-02.name
  }
  network_interface {
    subnetwork = var.infSubNetwork
    network_ip = "10.165.18.243"
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
      "application" =  "backup-commserver"
      "costcenter"  = "c19c7"
      "backup"      = "yes"
      "optimization"  = "yes"
  }
}
