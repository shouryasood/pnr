provider "google" {
  alias = "impersonate"
  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email"
  ]
}


provider "google" {
  version      = "~> 3.11"
}

provider "google-beta" {
  version      = "~> 3.11"
}

provider "null" {
  version = "~> 3.1.0"
}

provider "random" {
  version = "~> 3.1.0"
}
