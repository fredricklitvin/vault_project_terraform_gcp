variable "project_id" {
  description = "The ID of the project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources"
  type        = string
}

variable "private_subnet_cidr_range_pods" {
  description = "The CIDR range for the GKE pods"
  type        = string
  default     = "10.0.8.0/21"
}

variable "private_subnet_cidr_range_services" {
  description = "The CIDR range for the GKE services"
  type        = string
  default     = "10.0.2.0/24"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "vault-vpc"
}

variable "vpc_subnet" {
  description = "The subnet for the VPC"
  type        = string
  default     = "10.0.0.0/24"
}
