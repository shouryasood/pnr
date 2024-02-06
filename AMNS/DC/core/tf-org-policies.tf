
# https://cloud.google.com/resource-manager/docs/organization-policy/org-policy-constraints#available_constraints
/******************************************
  Organization Policies
*******************************************/





module "org_skip_default_network" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = true
  constraint      = "constraints/compute.skipDefaultNetworkCreation"
}

module "org_shared_vpc_lien_removal" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = true
  constraint      = "constraints/compute.restrictXpnProjectLienRemoval"
}



module "org_trusted_image_projects" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "list"
  constraint      = "constraints/compute.trustedImageProjects"
  allow           = ["projects/c19c7-c1-dc-inf","projects/amns-sap"]
  allow_list_length = "2"
}


module "org_disable_serial_port_access" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = false
  constraint      = "constraints/compute.disableSerialPortAccess"
}


module "org_disable_ipv6" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = true
  constraint      = "constraints/compute.disableAllIpv6"
}



module "org_disable_guest_attribute" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = true
  constraint      = "constraints/compute.disableGuestAttributesAccess"
}

module "org_disable_network_endpoint_group" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = true
  constraint      = "constraints/compute.disableInternetNetworkEndpointGroup"
}

module "org_disable_nested_virtualization" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = true
  constraint      = "constraints/compute.disableNestedVirtualization"
}

module "org_enable_os_login" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = true
  constraint      = "constraints/compute.requireOsLogin"
}


module "org_require_shielded_vms" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = true
  constraint      = "constraints/compute.requireShieldedVm"
}

/*
module "org_disable_service_account_use_across_project" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = true
  constraint      = "constraints/iam.disableCrossProjectServiceAccountUsage"
}

*/

module "org_disable_cross_project_svc_lien_removal" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = true
  constraint      = "constraints/iam.restrictCrossProjectServiceAccountLienRemoval"

}


module "org_enable_detailed_audit_logging" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = true
  constraint      = "constraints/gcp.detailedAuditLoggingMode"
}

module "org_disable_storage_public_access" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = true
  constraint      = "constraints/storage.publicAccessPrevention"
}


module "org_restrict_cloud_nat" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "list"
  constraint      = "constraints/compute.restrictCloudNATUsage"
  enforce = true
}

module "org_restrict_dedicated_interconnect" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "list"
  constraint      = "constraints/compute.restrictDedicatedInterconnectUsage"
  enforce = true
}


module "org_restrict_loadbalancer_type" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "list"
  constraint      = "constraints/compute.restrictLoadBalancerCreationForTypes"
  allow           =  ["GLOBAL_EXTERNAL_MANAGED_HTTP_HTTPS"]
  allow_list_length = "1"
}

module "org_restrict_partner_interconnect" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "list"
  constraint      = "constraints/compute.restrictPartnerInterconnectUsage"
  allow           =  ["under:projects/c19c7-c1-dc-inf","projects/c19c7-c1-dc-hst/global/networks/c19c7c1pdpvc-02"]
  allow_list_length = "2"
}


module "org_restrict_protocol_forwarding" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "list"
  constraint      = "constraints/compute.restrictProtocolForwardingCreationForTypes"
  enforce         = true
}

module "org_host_project" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "list"
  constraint      = "constraints/compute.restrictSharedVpcHostProjects"
  allow           =  ["projects/c19c7-c1-dc-hst","projects/c19c7-c1-dr-hst"]
  allow_list_length = "2"
}


module "org_shared_subnets" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "list"
  constraint      = "constraints/compute.restrictSharedVpcSubnetworks"
  allow           =  ["under:projects/c19c7-c1-dc-hst","under:projects/c19c7-c1-dr-hst"]
  allow_list_length = "2"
}


module "org_restrict_vpc_peering" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "list"
  constraint      = "constraints/compute.restrictVpcPeering"
  allow           =  ["projects/c19c7-c1-dc-hst/global/networks/c19c7c1pdpvc-03","projects/c19c7-c1-dc-hst/global/networks/c19c7c1pdpvc-04","projects/c19c7-c1-dc-hst/global/networks/c19c7c1pdpvc-05","projects/c19c7-c1-dr-hst/global/networks/c19c7c1drpvc-03","projects/c19c7-c1-dr-hst/global/networks/c19c7c1drpvc-04"]
  allow_list_length = "5"
}

module "org_restrict_vpn_peer" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "list"
  constraint      = "constraints/compute.restrictVpnPeerIPs"
  enforce         = true
}

module "org_restrict_ip_forwarding" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "list"
  constraint      = "constraints/compute.vmCanIpForward"
  allow           =  ["projects/c19c7-c1-dc-hst/zones/asia-south1-a/instances/c19c7c1pdp6","projects/c19c7-c1-dc-hst/zones/asia-south1-b/instances/c19c7c1pdp7","projects/c19c7-c1-dr-hst/zones/asia-south1-a/instances/c19c7c1drp1"]
  allow_list_length = "3"
}

module "org_restrict_external_identity_provider" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "list"
  constraint      = "constraints/iam.workloadIdentityPoolProviders"
  enforce         = true
}

module "org_restrict_region" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "list"
  constraint      = "constraints/gcp.resourceLocations"
  allow           =  ["in:asia-south1-locations","in:asia-south2-locations"]
  allow_list_length = "2"
}


module "org_require_vpc_flowlogs" {
  source          = "../../modules/policies"
  organization_id = var.amnsOrgId
  policy_for      = "organization"
  policy_type     = "list"
  constraint      = "constraints/compute.requireVpcFlowLogs"
  allow           =  ["LIGHT"]
  allow_list_length = "1"
}