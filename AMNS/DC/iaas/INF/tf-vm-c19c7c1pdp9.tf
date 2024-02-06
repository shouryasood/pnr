# Create static lan  ip private
resource "google_compute_address" "c19c7c1pdpip-c19c7c1pdp9-ln" {
  name = "c19c7c1pdpip-c19c7c1pdp9-ln"
  subnetwork   = var.infSubNetwork
  address_type = "INTERNAL"
  region       = "asia-south1"
  address      = "10.165.18.241"
}



# Create c19c7c1pdp9 compute instance
resource "google_compute_instance" "c19c7c1pdp9" {
  name           = "c19c7c1pdp9"
  machine_type   = "n2-standard-4"
  zone           = "asia-south1-a"
  description = "DSM-Smart Protection Server"
  tags = ["c19c7c1pdpal-nt-02"]
  project = "c19c7-c1-dc-inf"

  deletion_protection = true

  boot_disk {
    auto_delete = false
    initialize_params {
      size = 200
      image = "trendmicro-imported-image"
      type = "pd-ssd"
    }
  }
  network_interface {
    subnetwork = var.infSubNetwork
    network_ip = google_compute_address.c19c7c1pdpip-c19c7c1pdp9-ln.address
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
      "application"   = "dsm-smart-protection-server"
      "costcenter"  = "c19c7"
      "backup"      = "yes"
      "optimization"  = "yes"
  }
}

