# Creating GCS bucket for IAC[Terraform] state Backend

resource "google_storage_bucket" "c19c7c1pdpcs-08" {
  name          = "c19c7c1pdpcs-08"
  location      = "ASIA-SOUTH1"
  project       = "c19c7-c1-dc-inf"
  versioning {
    enabled = true
  }
  }

  