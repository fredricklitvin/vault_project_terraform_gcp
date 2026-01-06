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
