
# Create static lan  ip private
resource "google_compute_address" "c19c7c1pdpip-c19c7c1pdp13-ln" {
  name = "c19c7c1pdpip-c19c7c1pdp13-ln"
  subnetwork   = var.infSubNetwork
  address_type = "INTERNAL"
  region       = "asia-south1"
  address      = "10.165.18.245"
}

# Create Optional disk for for c19c7c1pdp13
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp13-01" {
  name = "c19c7c1pdppd-c19c7c1pdp13-01"
  size = 100
  type = "pd-ssd"
  zone = "asia-south1-a"
  description = "Optional Disk"
}



# Create c19c7c1pdp13 compute instance
resource "google_compute_instance" "c19c7c1pdp13" {
  name           = "c19c7c1pdp13"
  machine_type   = "n2-custom-8-12288"
  zone           = "asia-south1-a"
  description = "MDR_SIEM"
  tags = ["c19c7c1pdpal-nt-02"]
  project = "c19c7-c1-dc-inf"

  deletion_protection = true

  boot_disk {
    auto_delete = false
    initialize_params {
      size = 50
      image = "siem-image-15july"
      type = "pd-ssd"
    }
  }
  attached_disk {
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp13-01.name
  }

  network_interface {
    subnetwork = var.infSubNetwork
    network_ip = google_compute_address.c19c7c1pdpip-c19c7c1pdp13-ln.address
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
      "application" =  "mdr_siem"
      "costcenter"  = "c19c7"
      "backup"      = "yes"
      "optimization"  = "yes"
      "apowner"       = "geeta_patil"
      "owneremail"   = "geeta_patil_amns_in"
 
  }
  
}
