


# Create  Swap disk for for c19c7c1pdp19
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp19-01" {
  name = "c19c7c1pdppd-c19c7c1pdp19-01"
  size = 32
  type = "pd-ssd"
  zone = "asia-south1-a"
  description = "Swap Disk"
}


# Create static lan  ip private
resource "google_compute_address" "c19c7c1pdpip-c19c7c1pdp19-ln" {
  name = "c19c7c1pdpip-c19c7c1pdp19-ln"
  subnetwork   = var.infSubNetwork
  address_type = "INTERNAL"
  region       = "asia-south1"
  address      = "10.165.18.234"
}

# Create c19c7c1pdp19 compute instance
resource "google_compute_instance" "c19c7c1pdp19" {
  name           = "c19c7c1pdp19"
  machine_type   = "e2-standard-4"
  zone           = "asia-south1-a"
  description = "Arcon_PAM SGS"
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
      image = "rhel-7"
      type = "pd-ssd"
    }
  }
 
 attached_disk { 
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp19-01.name
    device_name = "Swap"

  }
 metadata = {
      ssh-keys = <<EOT
        gcpprdadmin:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtzHmkTE+lVLZ4IlhImDzFjSmCWITiIyTElGlHoUzAkxnpDVX4kd4m9Ozte6IMrJDnBkBJfSLwWG/dV/LZ0q7P3F15ZH+iDHeuHVJ1Iu8jcGf+83ORvDUONlrBwTuaVgFkZsO7ROqG3TodNOaEultsxoKCqaX7sbRzXGnIjrO4NHRI2AzGXCDJYs2SC6Wne7S+DB1haxJSuQWpOoA0jAtFgdwBgpI9vbiFKBqYvoaqJOZKVQVL9my6QQ6X3FNDTKIOgWOC37i7V11R5VQ4Hits8vR5XPWcYdgF3x52P/htkQ6RUXBpROccXvTAX4njnQWEVqcRTFNNgVnQ4tKMle7f gcpprdadmin@sify.com
         EOT     
        
  }
  
  network_interface {
    subnetwork = var.infSubNetwork
    network_ip = google_compute_address.c19c7c1pdpip-c19c7c1pdp19-ln.address
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
      "application" =  "arcon_pam_sg"
      "costcenter"  = "c19c7"
      "backup"      = "yes"
      "optimization"  = "yes"
  }
}
