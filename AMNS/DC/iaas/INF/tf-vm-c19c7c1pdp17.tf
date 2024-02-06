
# Create static lan  ip private
resource "google_compute_address" "c19c7c1pdpip-c19c7c1pdp17-ln" {
  name = "c19c7c1pdpip-c19c7c1pdp17-ln"
  subnetwork   = var.infSubNetwork
  address_type = "INTERNAL"
  region       = "asia-south1"
  address      = "10.165.18.233"
}

# Create Optional disk1 for for c19c7c1pdp17
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp17-01" {
  name = "c19c7c1pdppd-c19c7c1pdp17-01"
  size = 150
  type = "pd-ssd"
  zone = "asia-south1-a"
  description = "Optional Disk1"
}
# Create Optional disk2 for for c19c7c1pdp17
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp17-02" {
  name = "c19c7c1pdppd-c19c7c1pdp17-02"
  size = 150
  type = "pd-ssd"
  zone = "asia-south1-a"
  description = "Optional Disk2"
}
# Create Optional disk3 for for c19c7c1pdp17
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp17-03" {
  name = "c19c7c1pdppd-c19c7c1pdp17-03"
  size = 800
  type = "pd-ssd"
  zone = "asia-south1-a"
  description = "Optional Disk3"
}



# Create c19c7c1pdp17 compute instance
resource "google_compute_instance" "c19c7c1pdp17" {
  name           = "c19c7c1pdp17"
  machine_type   = "e2-custom-6-49152"
  zone           = "asia-south1-a"
  description = "Arcon_PAM_Db"
  tags = ["c19c7c1pdpal-nt-02"]
  project = "c19c7-c1-dc-inf"

  deletion_protection = true

  boot_disk {
    auto_delete = false
    initialize_params {
      size = 100
      image = "projects/windows-sql-cloud/global/images/sql-2019-standard-windows-2019-dc-v20220713"
      type = "pd-ssd"
    }
  }
  attached_disk {
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp17-01.name
  }
  
  attached_disk {
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp17-02.name
  }
  
  attached_disk {
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp17-03.name
  }

  network_interface {
    subnetwork = var.infSubNetwork
    network_ip = google_compute_address.c19c7c1pdpip-c19c7c1pdp17-ln.address
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
      "vmrole"      = "db"
      "application" =  "arcon_pam_db"
      "costcenter"  = "c19c7"
      "backup"      = "yes"
      "optimization"  = "yes"
      "apowner"       = "geeta_patil"
      "owneremail"   = "geeta_patil_amns_in"
 
  }
  
}
