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

  registry_name = { 
    dev = "syc-kubernetes-registry"
    prod = "syc-kubernetes-registry"
  }

  registry_tier = {
    dev = "basic"
    prod = "basic"
  }
  # cluster_version = {
  #   type = string
  #   dev = "1.28"
  #   prod = "1.28"
  # }

  # worker_count = {
  #   type = number
  #   dev = 3
  #   prod = 3
  # }

  # worker_size = {
  #   type = string
  #   dev = "s-2vcpu-4gb"
  #   prod = "s-2vcpu-4gb"
  # }

  write_kubeconfig = {
    dev = false
    prod = false
  }

}
