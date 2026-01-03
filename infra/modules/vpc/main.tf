resource "google_compute_network" "vpc_network" {
  name                    = "vpc-vault"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "vault_private_subnet"
  ip_cidr_range = "10.0.0.0/24"
  region       = var.region
  network      = google_compute_network.vpc_network.id

  private_ip_google_access = true
  secondary_ip_range {
    range_name = "gke-pods"
    ip_cidr_range = "10.0.1.0/24"
  }
    secondary_ip_range {
    range_name = "gke-services"
    ip_cidr_range = "10.0.2.0/24"
  }
}

resource "google_compute_router" "vpc_router" {
  name    = "vault-router"
  region = var.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "vpc_nat" {
  name   = "vault-nat"
  region = var.region
  router = google_compute_router.vpc_router.id

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = ["ALL_SUBNETWORKS_ALL_IP_RANGES"]
}
