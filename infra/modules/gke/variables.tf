variable "gke_node_sa_roles" {
  description = "The roles to assign to the GKE node service account"
  type        = set(string)
  default     = [
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/artifactregistry.reader",
  ]
}
variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "gke-vault"
}
variable "region" {
  description = "The GCP region to deploy resources"
  type        = string
}
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}
variable "network_id" {
  description = "The name of the VPC network"
  type        = string
}
variable "subnetwork_id" {
  description = "The name of the subnetwork"
  type        = string
}
variable "cluster_secondary_range" {
  description = "The name of the cluster's secondary range"
  type        = string
}
variable "services_secondary_range" {
  description = "The name of the services' secondary range"
  type        = string
}

variable "master_ipv4_cidr_block" {
  description = "The CIDR block for the master IPv4 range"
  type        = string
  default     = "172.16.0.0/28"
}
variable "labels" {
  description = "Labels to apply to resources"
  type        = map(string)
}
variable "vpc_subnet_cidr" {
  description = "The CIDR range for the VPC subnet"
  type        = string
}