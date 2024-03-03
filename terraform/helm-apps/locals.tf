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

  write_kubeconfig = {
    dev = false
    prod = false
  }
  


}
