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
  cluster_secondary_range = module.vpc.private_subnet_cidr_range_pods
  services_secondary_range = module.vpc.private_subnet_cidr_range_services
  labels = var.labels
  vpc_subnet_cidr = module.vpc.vpc_subnet_cidr
}