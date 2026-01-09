output vpc_id {
  value       = google_compute_network.vpc_network.id
  description = "The ID of the VPC"
}
output private_subnet_id {
  value       = google_compute_subnetwork.private_subnet.id
  description = "The ID of the private subnet"
}
output private_subnet_cidr_pods_name{
  value       = "gke-pods"
  description = "The name of the CIDR range for the GKE pods"
}
output private_subnet_cidr_services_name {
  value       = "gke-services"
  description = "The name of the CIDR range for the GKE services"
}
output vpc_subnet_cidr {
  value       = google_compute_subnetwork.private_subnet.ip_cidr_range
  description = "The CIDR range for the VPC subnet"
}

output vpc_name {
  value       = google_compute_network.vpc_network.name
  description = "The name of the VPC"
}