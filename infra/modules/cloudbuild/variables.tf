variable "network_id" {
  description = "The name of the VPC network"
  type        = string
}

variable "service_networking_prefix_length" {
  description = "The prefix length for the service networking range"
  type        = number
  default     = 16
}

variable "service_networking_range_address" {
  description = "The address for the service networking range"
  type        = string
  default     = "10.100.0.0"
}

variable "pool_worker_ip_range" {
  type        = string
  description = "A /24 CIDR from the Service Networking allocated range"
  default     = "10.100.10.0/24"
}

variable "project_id" {
  description = "The ID of the project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
}

variable "cloudbuild_sa_roles" {
  description = "The roles to assign to the Cloud Build service account"
  type        = set(string)
  default     = [
    "roles/iam.serviceAccountUser",
    "roles/cloudbuild.builds.editor",
    "roles/container.clusterAdmin",
    "roles/storage.objectAdmin",
    "roles/serviceusage.serviceUsageConsumer"
  ]
}

variable "cloudbuild_bucket_name" {
  description = "The name of the Cloud Build bucket"
  type        = string
  default     = "vault-cloudbuild-bucket"
}