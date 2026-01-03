output vpc_id {
  value       = google_compute_network.vpc_network.id
  description = "The ID of the VPC"
}
output private_subnet_id {
  value       = google_compute_subnetwork.private_subnet.id
  description = "The ID of the private subnet"
}
output private_subnet_cidr_range_pods {
  value       = google_compute_subnetwork.private_subnet.secondary_ip_range[0].ip_cidr_range
  description = "The CIDR range for the GKE pods"
}
output private_subnet_cidr_range_services {
  value       = google_compute_subnetwork.private_subnet.secondary_ip_range[1].ip_cidr_range
  description = "The CIDR range for the GKE services"
}

