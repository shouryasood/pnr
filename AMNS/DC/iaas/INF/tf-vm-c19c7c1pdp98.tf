# Create static lan  ip private
resource "google_compute_address" "c19c7c1pdpip-c19c7c1pdp98-ln" {
  name = "c19c7c1pdpip-c19c7c1pdp98-ln"
  subnetwork   = var.infSubNetwork
  address_type = "INTERNAL"
  region       = "asia-south1"
  address      = "10.165.18.249"
}



# Create c19c7c1pdp98 compute instance
resource "google_compute_instance" "c19c7c1pdp98" {
  name           = "c19c7c1pdp98"
  machine_type   = "n1-standard-1"
  zone           = "asia-south1-a"
  description = "Linux-jump"
  tags = ["c19c7c1pdpal-nt-02"]
  project = "c19c7-c1-dc-inf"

  deletion_protection = true

  boot_disk {
    auto_delete = false
    initialize_params {
      size = 20
      image = "centos-7"
      type = "pd-ssd"
    }
  }
  network_interface {
    subnetwork = var.infSubNetwork
    network_ip = google_compute_address.c19c7c1pdpip-c19c7c1pdp98-ln.address
  }

  service_account {
    email  = module.c19c7c1pdpci-sa-02.email
    scopes = ["userinfo-email","compute-ro","storage-ro"]
  }
  scheduling {
    automatic_restart = false
  }
  metadata = {
    "ssh-keys" = "gcpadmin:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC623ySTCQCasEvdN4pzILiUvs9s5eAxxwJlg4F6V24IHCrnXslJa86QpA72/hejJA+7dEXUVkWCwXnvCfdCz+0gcHFSJH6nztxs/49eFE3d7GFKweM5BB/OGnlx3ApMYkVcJAw31J23cPXssyk21RHZoa4bRytkat4vNjZNG/au+DW+2FsUAOVGRnX2W6kiatESjzLf1Vqn3B1IolzsJsKHqtbTwTM8/eXRl9fWSvzP/EIIvDDmJI1qMM/0HDii3GGNnvSVs1IRwjofcNE8NtHwuCuAZWDQBJOmJCzTNfwQlPsOM5hhIlq5MBYnIpl8V4VA0IJZQ6X8GRlTW1uVLn1 gcpadmin@sify.com"
  }
  labels =  {
      "environment" = "prd"
      "vmrole"      = "ap"
      "application"   = "linux-jump"
      "costcenter"  = "c19c7"
      "backup"      = "yes"
      "optimization"  = "no"
  }
}

