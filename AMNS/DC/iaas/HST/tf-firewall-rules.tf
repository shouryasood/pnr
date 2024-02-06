
/*********************************************************************
	Firewall Rules for  Untrust [c19c7c1pdpvc-01] network
 ********************************************************************/

resource "google_compute_firewall" "c19c7c1pdpbl-fr-01" {
  name    = "c19c7c1pdpbl-fr-01"
  network = module.c19c7c1pdpvc-01.network_name
  description = "Block All Ports"
  direction = "EGRESS"
  log_config {
      metadata = "EXCLUDE_ALL_METADATA"
  }


  deny {
    protocol = "all"
  }
  destination_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "c19c7c1pdpal-fr-06" {
  name    = "c19c7c1pdpal-fr-06"
  network = module.c19c7c1pdpvc-01.network_name
  description = "Allow Egress Traffic"
  direction = "EGRESS"
  priority = 900
  target_tags = ["c19c7c1pdpal-nt-06"]
  log_config {
      metadata = "EXCLUDE_ALL_METADATA"
  }
  allow {
    protocol = "all"
  }
}

resource "google_compute_firewall" "c19c7c1pdpfg-fr-01" {
  name    = "c19c7c1pdpfg-fr-01"
  network = module.c19c7c1pdpvc-01.network_name
  description = "Allow fortigate tcp ports"
  direction = "INGRESS"
  target_tags = ["c19c7c1pdpfg-nt-01"]
  log_config {
      metadata = "EXCLUDE_ALL_METADATA"
  }
  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
}


resource "google_compute_firewall" "c19c7c1pdpal-fr-08" {
  name    = "c19c7c1pdpal-fr-08"
  network = module.c19c7c1pdpvc-01.network_name

  allow {
    protocol = "tcp"
    ports    = []
  }

  source_ranges = ["35.191.0.0/16", "209.85.152.0/22", "209.85.204.0/22"]

  target_tags = var.target_tags

  target_service_accounts = var.target_service_accounts
}


/*********************************************************************
	Firewall Rules for  Transit [c19c7c1pdpvc-02] network
 ********************************************************************/


resource "google_compute_firewall" "c19c7c1pdpal-fr-01" {
  name    = "c19c7c1pdpal-fr-01"
  network = module.c19c7c1pdpvc-02.network_name
  description = "Allow All Ports"
  direction = "INGRESS"
  target_tags = ["c19c7c1pdpal-nt-01"]
  log_config {
      metadata = "EXCLUDE_ALL_METADATA"
  }
  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
}


/*********************************************************************
	Firewall Rules for  Shared [c19c7c1pdpvc-03] network
 ********************************************************************/

 resource "google_compute_firewall" "c19c7c1pdpal-fr-02" {
  name    = "c19c7c1pdpal-fr-02"
  network = module.c19c7c1pdpvc-03.network_name
  description = "Allow All Ports"
  direction = "INGRESS"
  target_tags = ["c19c7c1pdpal-nt-02"]
  log_config {
      metadata = "EXCLUDE_ALL_METADATA"
  }

  allow {
    protocol = "all"
  }
 }



 /*********************************************************************
	Firewall Rules for SAP Prod [c19c7c1pdpvc-04] network
 ********************************************************************/

 resource "google_compute_firewall" "c19c7c1pdpal-fr-03" {
  name    = "c19c7c1pdpal-fr-03"
  network = module.c19c7c1pdpvc-04.network_name
  description = "Allow All Ports"
  direction = "INGRESS"
  target_tags = ["c19c7c1pdpal-nt-03"]
  log_config {
      metadata = "EXCLUDE_ALL_METADATA"
  }

  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
 }



/*********************************************************************
	Firewall Rules for  SAP NProd [c19c7c1pdpvc-05] network
 ********************************************************************/

 resource "google_compute_firewall" "c19c7c1pdpal-fr-04" {
  name    = "c19c7c1pdpal-fr-04"
  network = module.c19c7c1pdnvc-05.network_name
  description = "Allow All Ports"
  direction = "INGRESS"
  target_tags = ["c19c7c1pdpal-nt-04"]
  log_config {
      metadata = "EXCLUDE_ALL_METADATA"
  }
  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
 }


 /*********************************************************************
	Firewall Rules for Management [c19c7c1pdpvc-06] network
 ********************************************************************/

resource "google_compute_firewall" "c19c7c1pdpbl-fr-02" {
  name    = "c19c7c1pdpbl-fr-02"
  network = module.c19c7c1pdpvc-06.network_name
  description = "Block All Ports"
  direction = "EGRESS"
  log_config {
      metadata = "EXCLUDE_ALL_METADATA"
  }

  deny {
    protocol = "all"
  }
  destination_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "c19c7c1pdpal-fr-07" {
  name    = "c19c7c1pdpal-fr-07"
  network = module.c19c7c1pdpvc-06.network_name
  description = "Allow Egress traffic to private google endpoint IPs"
  direction = "EGRESS"
  priority = 900
  log_config {
      metadata = "EXCLUDE_ALL_METADATA"
  }
  allow {
    protocol = "all"
  }
  target_tags = ["c19c7c1pdpal-nt-07"]
  destination_ranges = ["199.36.153.4/30"]
}

resource "google_compute_firewall" "c19c7c1pdpfg-fr-02" {
  name    = "c19c7c1pdpfg-fr-02"
  network = module.c19c7c1pdpvc-06.network_name
  description = "Allow fortigate tcp ports"
  direction = "INGRESS"
  target_tags = ["c19c7c1pdpfg-nt-02"]
  log_config {
      metadata = "EXCLUDE_ALL_METADATA"
  }

  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
}


 /*********************************************************************
	Firewall Rules for HA [c19c7c1pdpvc-07] network
 ********************************************************************/

 resource "google_compute_firewall" "c19c7c1pdpal-fr-05" {
  name    = "c19c7c1pdpal-fr-05"
  network = module.c19c7c1pdpvc-07.network_name
  description = "Allow All Ports"
  direction = "INGRESS"
  target_tags = ["c19c7c1pdpal-nt-05"]
  log_config {
      metadata = "EXCLUDE_ALL_METADATA"
  }
  allow {
    protocol = "all"
  }
  source_ranges = ["0.0.0.0/0"]
 }