/**************************************
Create source repo for PD region
**************************************/

resource "google_sourcerepo_repository" "c19c7c1pdpsr-01" {
  depends_on = [
     google_project_service.c19c7-c1-dc-inf-services["sourcerepo.googleapis.com"]
  ]
  name = "c19c7c1pdpsr-01"
  project = google_project.c19c7-c1-dc-inf.project_id
}

