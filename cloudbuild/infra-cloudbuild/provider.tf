terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "7.14.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "3.0.1"
    }
    helm = {
      source = "hashicorp/helm"
      version = "3.1.1"
    }    
  }
  backend "gcs" {
    bucket = "terraform-infra-vault"
    prefix = "terraform/infra-cloudbuild"
  }
}
provider "google" {
  project     = var.project_id
  region      = var.region
}

data "terraform_remote_state" "infra" {
  backend = "gcs"
  config = {
    bucket = "terraform-infra-vault"          
    prefix = "terraform/state"                
  }
}

data "google_container_cluster" "target" {
  name     = data.terraform_remote_state.infra.outputs.gke_cluster_name
  location = data.terraform_remote_state.infra.outputs.gke_cluster_location
}

data "google_client_config" "default" {}

provider "kubernetes" {
  host                   = data.google_container_cluster.target.endpoint
  token                  = data.google_client_config.default.access_token
  cluster_ca_certificate = base64decode(data.google_container_cluster.target.master_auth[0].cluster_ca_certificate)
}
provider "helm" {
  kubernetes {
    host                   = data.google_container_cluster.target.endpoint
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(data.google_container_cluster.target.master_auth[0].cluster_ca_certificate)
  }
}
