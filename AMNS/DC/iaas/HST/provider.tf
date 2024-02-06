provider "google" {
  alias = "impersonate"
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email"
  ]
}

data "google_service_account_access_token" "terraform_sa" {
  provider               = google.impersonate
  target_service_account = var.hstTfServiceAccount
  lifetime               = "300s"
  scopes = [
    "cloud-platform"
  ]
}


provider "google" {
  version      = "~> 3.11"
  project = var.hstProjectId
  access_token = data.google_service_account_access_token.terraform_sa.access_token

}

provider "google-beta" {
  version      = "~> 3.11"
  project = var.hstProjectId
  access_token = data.google_service_account_access_token.terraform_sa.access_token
}

provider "null" {
  version = "~> 3.1.0"
}

provider "random" {
  version = "~> 3.1.0"
}
