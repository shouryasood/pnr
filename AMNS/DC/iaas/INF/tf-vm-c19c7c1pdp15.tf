


# Create c19c7c1pdp15 compute instance
resource "google_compute_instance" "c19c7c1pdp15" {
  name           = "c19c7c1pdp15"
  machine_type   = "n2-custom-4-8192"
  zone           = "asia-south1-a"
  description = "ADC"
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
      size = 150
      image = "windows-2019"
      type = "pd-ssd"
    }
  }

  network_interface {
    subnetwork = var.infSubNetwork
    network_ip = "10.165.18.247"
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
      "application" =  "adc"
      "costcenter"  = "c19c7"
      "backup"      = "yes"
      "optimization"  = "yes"
  }
}
