output gke_cluster_name {
  value       = google_container_cluster.primary.name
  description = "The name of the GKE cluster"
  depends_on  = [google_container_cluster.primary]
}

output gke_cluster_location {
  value       = google_container_cluster.primary.location
  description = "The location of the GKE cluster"
  depends_on  = [google_container_cluster.primary]
}

output "gke_peering_name" {
  value       = google_container_cluster.primary.private_cluster_config[0].peering_name
  description = "The peering name for the GKE cluster"
  depends_on  = [google_container_cluster.primary]
}