

/******************************************
  Organization policy (boolean constraint)
 *****************************************/
resource "google_organization_policy" "org_policy_boolean" {
  count = local.organization && local.boolean_policy ? 1 : 0

  org_id     = var.organization_id
  constraint = var.constraint

  boolean_policy {
    enforced = var.enforce != false
  }
}

/******************************************
  Folder policy (boolean constraint)
 *****************************************/
resource "google_folder_organization_policy" "folder_policy_boolean" {
  count = local.folder && local.boolean_policy ? 1 : 0

  folder     = var.folder_id
  constraint = var.constraint

  boolean_policy {
    enforced = var.enforce != false
  }
}

/******************************************
  Project policy (boolean constraint)
 *****************************************/
resource "google_project_organization_policy" "project_policy_boolean" {
  count = local.project && local.boolean_policy ? 1 : 0

  project    = var.project_id
  constraint = var.constraint

  boolean_policy {
    enforced = var.enforce != false
  }
}

/******************************************
  Exclude folders from policy (boolean constraint)
 *****************************************/
resource "google_folder_organization_policy" "policy_boolean_exclude_folders" {
  count = local.boolean_policy && ! local.project ? local.exclude_folders_list_length : 0

  folder     = var.exclude_folders[count.index]
  constraint = var.constraint

  boolean_policy {
    enforced = var.enforce == false
  }
}

/******************************************
  Exclude projects from policy (boolean constraint)
 *****************************************/
resource "google_project_organization_policy" "policy_boolean_exclude_projects" {
  count = local.boolean_policy && ! local.project ? local.exclude_projects_list_length : 0

  project    = var.exclude_projects[count.index]
  constraint = var.constraint

  boolean_policy {
    enforced = var.enforce == false
  }
}
