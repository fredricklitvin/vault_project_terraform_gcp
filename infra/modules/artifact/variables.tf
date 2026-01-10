variable artifact_name {
  type        = set(string)
  default     = [
    "vault-api-gateway-image"
  ]
  description = "a list of artifact registry names to create"
}
variable region {
  description = "The GCP region for the Artifact Registry."
  type        = string
}