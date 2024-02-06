/**************************************
Create Org Folders
**************************************/

# Top-level folder under an organization.

resource "google_folder" "c19c7c1dc" {
  display_name = "C19C7-C1-DC"
  parent       = "organizations/${var.amnsOrgId}"
}


# folders under "C19C7-C1-DC" folder.

resource "google_folder" "c19c7c1dc-folders" {
  for_each = toset(["C19C7-C1-DC-HOST","C19C7-C1-DC-INFRA","C19C7-C1-DC-SAP"])
  display_name = each.value
  parent       = google_folder.c19c7c1dc.name
}