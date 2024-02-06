


module "c19c7c1pdpcr-01" {
  depends_on = [module.c19c7c1pdpvc-02-subnets]
  source = "../../../modules/cloud-router"
  name = "c19c7c1pdpcr-01"
  project = module.c19c7c1pdpvc-02.project_id
  region = "asia-south1"
  network = module.c19c7c1pdpvc-02.network_name
  description = "PD Router for TATA VLAN 01"
  bgp = {
      asn : "16550"
      advertised_groups : ["ALL_SUBNETS"]
  }
}

module "c19c7c1pdpcr-02" {
  depends_on = [module.c19c7c1pdpvc-02-subnets]
  source = "../../../modules/cloud-router"
  name = "c19c7c1pdpcr-02"
  project = module.c19c7c1pdpvc-02.project_id
  region = "asia-south1"
  network = module.c19c7c1pdpvc-02.network_name
  description = "PD Router for  TATA VLAN 02"
  bgp = {
      asn : "16550"
      advertised_groups : ["ALL_SUBNETS"]
  }
}

module "c19c7c1pdpcr-03" {
  depends_on = [module.c19c7c1pdpvc-02-subnets]
  source = "../../../modules/cloud-router"
  name = "c19c7c1pdpcr-03"
  project = module.c19c7c1pdpvc-02.project_id
  region = "asia-south1"
  network = module.c19c7c1pdpvc-02.network_name
  description = "PD Router for  AIRTEL VLAN 03"
  bgp = {
      asn : "16550"
      advertised_groups : ["ALL_SUBNETS"]
  }
}

module "c19c7c1pdpcr-04" {
  depends_on = [module.c19c7c1pdpvc-02-subnets]
  source = "../../../modules/cloud-router"
  name = "c19c7c1pdpcr-04"
  project = module.c19c7c1pdpvc-02.project_id
  region = "asia-south1"
  network = module.c19c7c1pdpvc-02.network_name
  description = "PD Router for  AIRTEL VLAN 04"
  bgp = {
      asn : "16550"
      advertised_groups : ["ALL_SUBNETS"]
  }
}


