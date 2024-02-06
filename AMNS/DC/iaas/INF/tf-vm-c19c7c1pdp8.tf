
# Create data disk for for c19c7c1pdp8
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp8-01" {
  name = "c19c7c1pdppd-c19c7c1pdp8-01"
  size = 100
  type = "pd-ssd"
  zone = "asia-south1-a"
  description = "DSM-AV Server Data Disk"
}


# Create c19c7c1pdp8 compute instance
resource "google_compute_instance" "c19c7c1pdp8" {
  name           = "c19c7c1pdp8"
  machine_type   = "n2-standard-4"
  zone           = "asia-south1-a"
  description = "DSM-AV Server"
  tags = ["c19c7c1pdpal-nt-02"]
  project = "c19c7-c1-dc-inf"

  shielded_instance_config {
      enable_secure_boot = true
      enable_vtpm = true
      enable_integrity_monitoring = true
  }
  #deletion_protection = true

  boot_disk {
    auto_delete = false
    initialize_params {
      size = 200
      image = "projects/windows-sql-cloud/global/images/sql-2019-standard-windows-2019-dc-v20220513"
      type = "pd-ssd"
    }
  }
  attached_disk {
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp8-01.name
  }

  network_interface {
    subnetwork = var.infSubNetwork
    network_ip = "10.165.18.240"
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
      "application"   = "dms-av-server"
      "costcenter"  = "c19c7"
      "backup"      = "yes"
      "optimization"  = "yes"
  }
}
