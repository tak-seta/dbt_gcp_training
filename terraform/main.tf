provider "google" {
  credentials = file("../sa_keyfile.json")
  project = var.gcp_project_id
  region  = var.region
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.71.0"
    }
  }

  required_version = ">= 1.5.2"
}
