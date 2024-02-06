



# Create static WAN  ip private
resource "google_compute_address" "c19c7c1pdpip-c19c7c1pdp7-wn" {
  name = "c19c7c1pdpip-c19c7c1pdp7-wn"
  subnetwork   = module.c19c7c1pdpvc-01-subnets.subnets["asia-south1/c19c7c1pdpfw-sb-01"].id
  address_type = "INTERNAL"
  region       = "asia-south1"
  address      = "10.165.16.124"
}

# Create static  instance management ip
resource "google_compute_address" "c19c7c1pdpip-c19c7c1pdp7-mg" {
  name = "c19c7c1pdpip-c19c7c1pdp7-mg"
  subnetwork   = module.c19c7c1pdpvc-06-subnets.subnets["asia-south1/c19c7c1pdpmg-sb-01"].id
  address_type = "INTERNAL"
  region       = "asia-south1"
  address      = "10.165.16.252"
}


# Create static ip for Transit Network
resource "google_compute_address" "c19c7c1pdpip-c19c7c1pdp7-tr" {
  name = "c19c7c1pdpip-c19c7c1pdp7-tr"
  subnetwork   = module.c19c7c1pdpvc-02-subnets.subnets["asia-south1/c19c7c1pdpgw-sb-01"].id
  address_type = "INTERNAL"
  region       = "asia-south1"
  address      = "10.165.17.124"
}

# Create static ip for HA Network
resource "google_compute_address" "c19c7c1pdpip-c19c7c1pdp7-ha" {
  name = "c19c7c1pdpip-c19c7c1pdp7-ha"
  subnetwork   = module.c19c7c1pdpvc-07-subnets.subnets["asia-south1/c19c7c1pdpha-sb-01"].id
  address_type = "INTERNAL"
  region       = "asia-south1"
  address      = "10.165.17.252"
}

# Create static ip for Shared Network
resource "google_compute_address" "c19c7c1pdpip-c19c7c1pdp7-ln" {
  name = "c19c7c1pdpip-c19c7c1pdp7-ln"
  subnetwork   = module.c19c7c1pdpvc-03-subnets.subnets["asia-south1/c19c7c1pdpis-sb-01"].id
  address_type = "INTERNAL"
  region       = "asia-south1"
  address      = "10.165.18.252"
}


# Create external static ip in Management Network
resource "google_compute_address" "c19c7c1pdpip-c19c7c1pdp7-mg-ex" {
  name = "c19c7c1pdpip-c19c7c1pdp7-mg-ex"
  address_type = "EXTERNAL"
  region       = "asia-south1"
}

/*

# Firewall Rule Internal
resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal-${random_string.random_name_post.result}"
  network = google_compute_network.vpc_network2.name

  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-internal"]
}

# Firewall Rule Internal
resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal-${random_string.random_name_post.result}"
  network = google_compute_network.vpc_network2.name

  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["allow-internal"]
}

*/

# Create log disk for for Fortinate VM c19c7c1pdp7
resource "google_compute_disk" "c19c7c1pdppd-c19c7c1pdp7-01" {
  name = "c19c7c1pdppd-c19c7c1pdp7-01"
  size = 30
  type = "pd-ssd"
  zone = "asia-south1-b"
}

# Create FGTVM compute instance
resource "google_compute_instance" "c19c7c1pdp7" {
  name           = "c19c7c1pdp7"
  machine_type   = "n2-standard-8"
  zone           = "asia-south1-b"
  can_ip_forward = "true"
  description = "Fortigate Server in HA"
  tags = ["c19c7c1pdpfg-nt-01","c19c7c1pdpal-nt-01","c19c7c1pdpal-nt-02","c19c7c1pdpal-nt-03","c19c7c1pdpal-nt-04","c19c7c1pdpfg-nt-02","c19c7c1pdpal-nt-05","c19c7c1pdpal-nt-06","c19c7c1pdpal-nt-07"]
  /* #Not Supported for Fortigate image.
  shielded_instance_config {
      enable_secure_boot = true
      enable_vtpm = true
      enable_integrity_monitoring = true
  }
  */
  deletion_protection = true

  boot_disk {
    auto_delete = false
    initialize_params {
      image = "projects/fortigcp-project-001/global/images/fortinet-fgt-705-20220211-001-w-license"
      type = "pd-ssd"
    }
  }
  attached_disk {
    source = google_compute_disk.c19c7c1pdppd-c19c7c1pdp7-01.name
  }
  network_interface {
    subnetwork = module.c19c7c1pdpvc-01-subnets.subnets["asia-south1/c19c7c1pdpfw-sb-01"].id
    network_ip = google_compute_address.c19c7c1pdpip-c19c7c1pdp7-wn.address
  }
  network_interface {
    subnetwork = module.c19c7c1pdpvc-02-subnets.subnets["asia-south1/c19c7c1pdpgw-sb-01"].id
    network_ip = google_compute_address.c19c7c1pdpip-c19c7c1pdp7-tr.address
  }
  network_interface {
    subnetwork = module.c19c7c1pdpvc-03-subnets.subnets["asia-south1/c19c7c1pdpis-sb-01"].id
    network_ip = google_compute_address.c19c7c1pdpip-c19c7c1pdp7-ln.address

  }

  network_interface {
    subnetwork = module.c19c7c1pdpvc-06-subnets.subnets["asia-south1/c19c7c1pdpmg-sb-01"].id
    network_ip = google_compute_address.c19c7c1pdpip-c19c7c1pdp7-mg.address
    access_config {
        nat_ip = google_compute_address.c19c7c1pdpip-c19c7c1pdp7-mg-ex.address
    }
  }

  network_interface {
    subnetwork = module.c19c7c1pdpvc-07-subnets.subnets["asia-south1/c19c7c1pdpha-sb-01"].id
    network_ip = google_compute_address.c19c7c1pdpip-c19c7c1pdp7-ha.address
  }

  metadata = {
      "serial-port-enable" = true
  }
  service_account {
    email  = module.c19c7c1pdpci-sa-07.email
    scopes = ["userinfo-email", "cloud-platform","compute-rw","storage-ro"]
  }
  scheduling {
    automatic_restart = false
  }
  labels =  {
      "environment" = "prd"
      "vmrole"      = "fw"
      "costcenter"  = "c19c7"
      "backup"      = "yes"
      "optimization"  = "no"
  }
  allow_stopping_for_update = true
}
