locals {
    
  env = terraform.workspace

  dmn_domain = { 
    dev = "dev.davidmnoll.com"
    prod = "davidmnoll.com"
  }

  syc_domain = {
    dev = "dev.syctech.io"
    prod = "syctech.io"
  }

  fos_domain = {
    dev = "dev.fosforescent.com"
    prod = "fosforescent.com"
  }

  cluster_name = { 
    dev = "dev-cluster"
    prod = "main-cluster"
  }

  cluster_version = {
    dev = "1.28"
    prod = "1.28"
  }

  worker_min = {
    dev = 3
    prod = 3
  }

  worker_max = {
    dev = 5
    prod = 5
  }

  worker_size = {
    dev = "s-2vcpu-4gb"
    prod = "s-2vcpu-4gb"
  }

  write_kubeconfig = {
    dev = false
    prod = false
  }

  db_cluster_name = {
    dev = "dev-syc-postgres-cluster"
    prod = "syc-postgres-cluster"
  }

  db_cluster_region = {
    dev = "nyc1"
    prod = "nyc1"
  }

  db_cluster_version = {
    dev = "12"
    prod = "12"
  }

  db_cluster_size = {
    dev = "db-s-1vcpu-1gb"
    prod = "db-s-1vcpu-1gb"
  }

  db_cluster_node_count = {
    dev = 1
    prod = 1
  }


  fos_db_name = {
    dev = "dev-fos-web-backend"
    prod = "fos-web-backend"
  }

  syc_db_name = {
    dev = "dev-syc-web-backend"
    prod = "syc-web-backend"
  }

  fos_db_user_name = {
    dev = "dev-fos-web-backend-user"
    prod = "fos-web-backend-user"
  }

  syc_db_user_name = {
    dev = "dev-syc-web-backend-user"
    prod = "syc-web-backend-user"
  }
  registry_name = { 
    dev = "syc-kubernetes-registry"
    prod = "syc-kubernetes-registry"
  }

  registry_tier = {
    dev = "basic"
    prod = "basic"
  }

  cf_pages_name = {
    dev = "fos-dev"
    prod = "fos-prod"
  }
  
  cf_pages_branch = {
    dev = "dev"
    prod = "main"
  }


}

