output gke_cluster_name {
  value       = module.gke.gke_cluster_name
  description = "The name of the GKE cluster"
}

output gke_cluster_location {
  value       = module.gke.gke_cluster_location
  description = "The location of the GKE cluster"
}
