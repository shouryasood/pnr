

variable "infProjectIdPd" {
  description = "INF Project ID for AMNS PD"
  type        = string
}


variable "infSubNetwork" {
  description = "Network to be used for Enteprise Servers in AMNS INF Project shared from HST Project"
  type        = string
}


variable "transitSubNetwork" {
  description = "Network to be used for Jump Server in AMNS INF Project shared from HST Project"
  type        = string
}

variable "infTfServiceAccount" {
  description = "Terraform Service Account email to be used to deploy resources in Prod "
  type        = string
}


