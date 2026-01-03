terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.14.1"
    }
  }
  backend "gcs" {
    bucket = "terraform-infra-vault"
    prefix = "terraform/state"
  }
}

provider "google" {
  project     = var.project_id
  region      = var.region
}