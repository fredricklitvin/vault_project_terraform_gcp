resource "google_service_account" "gke_node_sa" {
  account_id   = "gke-node-sa"
  display_name = "GKE Node Service Account"
}
resource "google_project_iam_member" "gke_node_sa_role" {
  for_each = var.gke_node_sa_roles
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.gke_node_sa.email}"
}

resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region
  deletion_protection = false
  remove_default_node_pool = true
  initial_node_count       = 1
  node_config {
    service_account = google_service_account.gke_node_sa.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    disk_size_gb = 15
  }

  network = var.network_id
  subnetwork = var.subnetwork_id
  ip_allocation_policy {
    cluster_secondary_range_name = var.cluster_secondary_name
    services_secondary_range_name = var.services_secondary_name
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
  }
  master_authorized_networks_config {
    cidr_blocks {
        cidr_block   = var.vpc_subnet_cidr
        display_name = "vpc-subnet"
      }
    }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
  }

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

logging_config {
  enable_components = ["SYSTEM_COMPONENTS", "WORKLOADS"]
}
monitoring_config {
  enable_components = ["SYSTEM_COMPONENTS"]
}

}

resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-primary-nodes"
  location   = var.region
  cluster    = google_container_cluster.primary.name
  node_count = 1

   management {
    auto_repair  = true
    auto_upgrade = true
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 3
  }

  node_config {
    machine_type    = "e2-medium"
    disk_size_gb    = 30
    service_account = google_service_account.gke_node_sa.email

    labels = var.labels
  }
}