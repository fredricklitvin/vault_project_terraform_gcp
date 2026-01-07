resource "google_service_account" "cloudbuild_service_account" {
  account_id = "cloud-build-sa"
}

resource "google_project_iam_member" "act_as" {
  for_each = var.cloudbuild_sa_roles
  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
}

resource "google_storage_bucket" "cloudbuild_bucket" {
  name     = var.cloudbuild_bucket_name
  location = var.region
  storage_class = "STANDARD"
  force_destroy = true
}

resource "google_storage_bucket_iam_member" "cb_staging_uploader" {
  bucket = google_storage_bucket.cloudbuild_bucket.name
  role   = "roles/storage.admin"
  member = "serviceAccount:${google_service_account.cloudbuild_service_account.email}"
}

resource "google_compute_global_address" "svc-networking-range" {
  name          =  "svc-networking-range"
  purpose       = "VPC_PEERING"
  address_type  = "INTERNAL"
  prefix_length = var.service_networking_prefix_length
  address       = var.service_networking_range_address
  network       = var.network_id
}

resource "google_service_networking_connection" "default" {
  network                 = var.network_id
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.svc-networking-range.name]
  update_on_creation_fail = true
}

resource "google_cloudbuild_worker_pool" "pool" {
  name     = "vault-cloudbuild-pool"
  location = var.region
  worker_config {
    disk_size_gb = 100
    machine_type = "e2-medium"
    no_external_ip = false
  }
  network_config {
    peered_network = var.network_id
    peered_network_ip_range = var.pool_worker_ip_range
  }
  depends_on = [google_service_networking_connection.default]
}


# resource "google_cloudbuild_trigger" "repo-trigger" {
#   location = var.region
#   name     = "vault-cloudbuild-trigger"
#   service_account = "projects/${var.project_id}/serviceAccounts/${google_service_account.cloudbuild_service_account.email}"
#   repository_event_config {
#     repository = "projects/brave-inn-477912-q1/locations/us-central1/connections/vault-repo-connection/repositories/fredricklitvin-vault_project_terraform_gcp"
#     push {
#       branch = "^main$"
#     }
#   }

#   filename = "cloudbuild/cloudbuild-infra.yaml"
# }