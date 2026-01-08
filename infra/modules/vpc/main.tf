resource "google_compute_network" "vpc_network" {
  name                    = var.vpc_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "${var.vpc_name}-private-subnet"
  ip_cidr_range = var.vpc_subnet
  region       = var.region
  network      = google_compute_network.vpc_network.id

  private_ip_google_access = true
  secondary_ip_range {
    range_name = "gke-pods"
    ip_cidr_range = var.private_subnet_cidr_range_pods
  }
    secondary_ip_range {
    range_name = "gke-services"
    ip_cidr_range = var.private_subnet_cidr_range_services
  }
}

resource "google_compute_router" "vpc_router" {
  name    = "${var.vpc_name}-router"
  region = var.region
  network = google_compute_network.vpc_network.id
}

resource "google_compute_router_nat" "vpc_nat" {
  name   = "${var.vpc_name}-nat"
  region = var.region
  router = google_compute_router.vpc_router.name

  nat_ip_allocate_option = "AUTO_ONLY"

  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
  # subnetwork {
  #   name = google_compute_subnetwork.private_subnet.id
  #   source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  # }
  log_config {
    enable = true
    filter = "ALL"
  }
}

