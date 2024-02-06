# Provide details for gcs bucket location where state files will be stored.



terraform {
  backend "gcs" {
    bucket = "c19c7c1pdpcs-08"
    # GCS bucket name where  tf state will be stored centrally
    prefix = "TF-STATE/CORE"
    # Folder name to separately store nprod env state files.This will reduce blast radius and accidental changes to prod env.
  }
}

