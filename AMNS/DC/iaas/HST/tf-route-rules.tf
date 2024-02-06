

module "c19c7c1pdpvc-02-routes" {
    source  = "../../../modules/routes"
    project_id   = var.hstProjectId
    network_name = module.c19c7c1pdpvc-02.network_name

    routes = [
        {
            name                   = "c19c7c1pdprt-01"
            description            = "Default Route towards FortiGate Firewall from Transit VPC in DC"
            destination_range      = "0.0.0.0/0"
            next_hop_ip            = "10.165.17.125"
        }
    ]
}

module "c19c7c1pdpvc-02-routes-private" {
    source  = "../../../modules/routes"
    project_id   = var.hstProjectId
    network_name = module.c19c7c1pdpvc-02.network_name

    routes = [
        {
            name                   = "c19c7c1pdprt-04"
            description            = "Route towards Google Private IP range from Transit VPC in DC"
            destination_range      = "199.36.153.4/30"
            next_hop_internet      = true
            priority               = 900
        }
    ]
}

module "c19c7c1pdpvc-03-routes" {
    source  = "../../../modules/routes"
    project_id   = var.hstProjectId
    network_name = module.c19c7c1pdpvc-03.network_name

    routes = [
        {
            name                   = "c19c7c1pdprt-02"
            description            = "Default Route towards FortiGate Firewall  From Shared Services VPC  in DC"
            destination_range      = "0.0.0.0/0"
            next_hop_ip            = "10.165.18.253"
        }
    ]
}

module "c19c7c1pdpvc-03-routes-private" {
    source  = "../../../modules/routes"
    project_id   = var.hstProjectId
    network_name = module.c19c7c1pdpvc-03.network_name

    routes = [
        {
            name                   = "c19c7c1pdprt-05"
            description            = "Route towards Google Private IP range From Shared Services VPC  in DC"
            destination_range      = "199.36.153.4/30"
            next_hop_internet      = true
            priority               = 900
        }
    ]
}

module "c19c7c1pdpvc-04-routes-private" {
    source  = "../../../modules/routes"
    project_id   = var.hstProjectId
    network_name = module.c19c7c1pdpvc-04.network_name

    routes = [
        {
            name                   = "c19c7c1pdprt-07"
            description            = "Route towards Google Private IP range From Prod VPC  in DC"
            destination_range      = "199.36.153.4/30"
            next_hop_internet      = true
            priority               = 900
        }
    ]
}

module "c19c7c1pdnvc-05-routes-private" {
    source  = "../../../modules/routes"
    project_id   = var.hstProjectId
    network_name = module.c19c7c1pdnvc-05.network_name

    routes = [
        {
            name                   = "c19c7c1pdnrt-01"
            description            = "Route towards Google Private IP range From Nprod VPC  in DC"
            destination_range      = "199.36.153.4/30"
            next_hop_internet      = true
            priority               = 900
        }
    ]
}

module "c19c7c1pdpvc-07-routes" {
    source  = "../../../modules/routes"
    project_id   = var.hstProjectId
    network_name = module.c19c7c1pdpvc-07.network_name

    routes = [
        {
            name                   = "c19c7c1pdprt-03"
            description            = "Default Route towards FortiGate Firewall  From Firewall Sync VPC  in DC"
            destination_range      = "0.0.0.0/0"
            next_hop_ip            = "10.165.17.253"
        }
    ]
}


module "c19c7c1pdpvc-07-routes-private" {
    source  = "../../../modules/routes"
    project_id   = var.hstProjectId
    network_name = module.c19c7c1pdpvc-07.network_name

    routes = [
        {
            name                   = "c19c7c1pdprt-06"
            description            = "Route towards Google Private IP range From Firewall Sync VPC  in DC"
            destination_range      = "199.36.153.4/30"
            next_hop_internet      = true
            priority               = 900
        }
    ]
}

