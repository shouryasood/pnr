# Provide details for gcs bucket location where state files will be stored.



terraform {
  backend "gcs" {
    bucket = "c19c7c1pdpcs-02"
    # GCS bucket name where  tf state will be stored centrally
    prefix = "TF-STATE/IAAS/INF"
    # Folder name to separately store
  }
}
