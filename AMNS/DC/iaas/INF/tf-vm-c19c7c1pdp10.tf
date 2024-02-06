


# Create App disk for for c19c7c1pdp10
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp10-01" {
  name = "c19c7c1pdppd-c19c7c1pdp10-01"
  size = 200
  type = "pd-ssd"
  zone = "asia-south1-a"
  description = "Commvault application drive"
}

# Create DDB Partition disk for for c19c7c1pdp10
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp10-02" {
  name = "c19c7c1pdppd-c19c7c1pdp10-02"
  size = 400
  type = "pd-ssd"
  zone = "asia-south1-a"
  description = "DDB Partition"
}


# Create Index Partition  disk for for c19c7c1pdp10
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp10-03" {
  name = "c19c7c1pdppd-c19c7c1pdp10-03"
  size = 400
  type = "pd-ssd"
  zone = "asia-south1-a"
  description = "Index Partition"
}

# Create c19c7c1pdp10 compute instance
resource "google_compute_instance" "c19c7c1pdp10" {
  name           = "c19c7c1pdp10"
  #machine_type   = "n2-standard-2"
  machine_type  = "custom-4-24576"
  zone           = "asia-south1-a"
  description = "Backup-MediaAgent"
  tags = ["c19c7c1pdpal-nt-02"]
  project = "c19c7-c1-dc-inf"
  #Not Supported for Fortigate image.

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
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp10-01.name
  }
  attached_disk {
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp10-02.name
  }
  attached_disk {
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp10-03.name
  }
  network_interface {
    subnetwork = var.infSubNetwork
    network_ip = "10.165.18.242"
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
      "application" =  "backup-mediaagent"
      "costcenter"  = "c19c7"
      "backup"      = "yes"
      "optimization"  = "yes"
  }
}
