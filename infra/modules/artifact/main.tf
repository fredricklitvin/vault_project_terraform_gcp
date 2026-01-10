resource "google_artifact_registry_repository" "repo" {
  for_each    = var.artifact_name
  location    = var.region
  repository_id = each.value
  description = "Artifact Registry for storing container images"
  format      = "DOCKER"
  mode        = "STANDARD_REPOSITORY"
}