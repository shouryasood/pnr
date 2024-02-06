variable "amnsOrgId" {
  description = "Org ID for AMNS"
  type        = string
}

variable "hstProjectId" {
  description = "Host Project ID for AMNS DC"
  type        = string
}

variable "hstTfServiceAccount" {
  description = "Terraform Service Account email to be used to deploy resources in HST PD Region "
  type        = string
}

variable "infTfServiceAccount" {
  description = "Terraform Service Account email to be used to deploy resources in INF "
  type        = string
}

variable "nprodTfServiceAccount" {
  description = "Terraform Service Account email to be used to deploy resources in NProd "
  type        = string
}

variable "prodTfServiceAccount" {
  description = "Terraform Service Account email to be used to deploy resources in Prod "
  type        = string
}



