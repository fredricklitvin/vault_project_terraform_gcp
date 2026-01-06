variable "project_id" {
  type        = string
  default     = "brave-inn-477912-q1"
  description = "The ID of the GCP project"
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "The GCP region to deploy resources"
}
