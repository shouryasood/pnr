

# Creating GCS bucket for IAC[Terraform] state Backend for this project

resource "google_storage_bucket" "c19c7c1pdpcs-07" {
  name          = "c19c7c1pdpcs-07"
  location      = "ASIA-SOUTH1"
  project       = var.infProjectIdPd
  
}

