


resource "google_compute_interconnect_attachment" "c19c7c1pdpvl-01" {
  project                  = var.hstProjectId
  name                     = "c19c7c1pdpvl-01"
  edge_availability_domain = "AVAILABILITY_DOMAIN_1"
  type                     = "PARTNER"
  router                   = module.c19c7c1pdpcr-01.router.id
  region                   = "asia-south1"
  mtu                      = 1500
  admin_enabled            = true
  description              = "PD TATA VLAN 01"
}


resource "google_compute_interconnect_attachment" "c19c7c1pdpvl-02" {
  project                  = var.hstProjectId
  name                     = "c19c7c1pdpvl-02"
  edge_availability_domain = "AVAILABILITY_DOMAIN_2"
  type                     = "PARTNER"
  router                   = module.c19c7c1pdpcr-02.router.id
  region                   = "asia-south1"
  mtu                      = 1500
  admin_enabled            = true
  description              = "PD TATA VLAN 02"
}


resource "google_compute_interconnect_attachment" "c19c7c1pdpvl-03" {
  project                  = var.hstProjectId
  name                     = "c19c7c1pdpvl-03"
  edge_availability_domain = "AVAILABILITY_DOMAIN_1"
  type                     = "PARTNER"
  router                   = module.c19c7c1pdpcr-03.router.id
  region                   = "asia-south1"
  mtu                      = 1500
  admin_enabled            = true
  description              = "PD AIRTEL VLAN 03"
}

resource "google_compute_interconnect_attachment" "c19c7c1pdpvl-04" {
  project                  = var.hstProjectId
  name                     = "c19c7c1pdpvl-04"
  edge_availability_domain = "AVAILABILITY_DOMAIN_2"
  type                     = "PARTNER"
  router                   = module.c19c7c1pdpcr-04.router.id
  region                   = "asia-south1"
  mtu                      = 1500
  admin_enabled            = true
  description              = "PD AIRTEL VLAN 04"
}



