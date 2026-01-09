module vpc {
  source = "./modules/vpc"
  project_id = var.project_id
  region    = var.region
  vpc_name  = "vault-vpc"
}

module gke {
  source     = "./modules/gke"
  project_id = var.project_id
  region     = var.region
  network_id = module.vpc.vpc_id
  subnetwork_id = module.vpc.private_subnet_id
  cluster_secondary_name = module.vpc.private_subnet_cidr_pods_name
  services_secondary_name = module.vpc.private_subnet_cidr_services_name
  labels = var.labels
  vpc_subnet_cidr = module.vpc.vpc_subnet_cidr
}

module cloudbuild {
  source     = "./modules/cloudbuild"
  project_id = var.project_id
  region     = var.region
  network_id = module.vpc.vpc_id
  gke_peering_name = module.gke.gke_peering_name
  vpc_name = module.vpc.vpc_name
}