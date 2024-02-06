


# Create  Data disk for for c19c7c1pdp14
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp14-01" {
  name = "c19c7c1pdppd-c19c7c1pdp14-01"
  size = 150
  type = "pd-ssd"
  zone = "asia-south1-a"
  description = "Commmvault App disk"
}



# Create c19c7c1pdp14 compute instance
resource "google_compute_instance" "c19c7c1pdp14" {
  name           = "c19c7c1pdp14"
  machine_type   = "e2-standard-8"
  zone           = "asia-south1-a"
  description = "Arcon_PAM"
  tags = ["c19c7c1pdpal-nt-02"]
  project = "c19c7-c1-dc-inf"

  allow_stopping_for_update = true

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
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp14-01.name
  }

   metadata = {
      ssh-keys = <<EOT
        gcpprdadmin:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCtzHmkTE+lVLZ4IlhImDzFjSmCWITiIyTElGlHoUzAkxnpDVX4kd4m9Ozte6IMrJDnBkBJfSLwWG/dV/LZ0q7P3F15ZH+iDHeuHVJ1Iu8jcGf+83ORvDUONlrBwTuaVgFkZsO7ROqG3TodNOaEultsxoKCqaX7sbRzXGnIjrO4NHRI2AzGXCDJYs2SC6Wne7S+DB1haxJSuQWpOoA0jAtFgdwBgpI9vbiFKBqYvoaqJOZKVQVL9my6QQ6X3FNDTKIOgWOC37i7V11R5VQ4Hits8vR5XPWcYdgF3x52P/htkQ6RUXBpROccXvTAX4njnQWEVqcRTFNNgVnQ4tKMle7f gcpprdadmin@sify.com
         EOT     
        
  }
  network_interface {
    subnetwork = var.infSubNetwork
    network_ip = "10.165.18.246"
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
      "application" =  "arcon_pam"
      "costcenter"  = "c19c7"
      "backup"      = "yes"
      "optimization"  = "yes"
  }
}
