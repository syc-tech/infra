terraform {

  required_version = "~> 1.6.3"

  required_providers {

    docker = {
      source = "kreuzwerker/docker"
    }
    helm = {
      source = "hashicorp/helm"
      version = "~>2.11.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~>2.23.0"
    }

    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "2.4.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }


  }
  

  backend "s3" {
    endpoints                   = {
      s3 = "https://sfo3.digitaloceanspaces.com/" 
    }
    region                      = "us-west-1" 
    key                         = "tfstate/kube-network/terraform.tfstate"
    bucket                      = "dmn-infra" 
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true 
    skip_s3_checksum            = true
    skip_region_validation      = true
  }
  
}

resource "random_id" "cluster_name" {
  byte_length = 5
}



data "digitalocean_kubernetes_cluster" "primary" {
  name = "main-cluster"
}

data "digitalocean_container_registry" "primary" {
  name = "dmn-kubernetes-registry"
}

# data "digitalocean_container_registry_docker_credentials" "primary" {
#   registry_id = data.digitalocean_container_registry.primary.id
# }

module "kubernetes_config" {
  source = "./kubernetes_config"
  kube_config = data.digitalocean_kubernetes_cluster.primary.kube_config
  cluster_name     = data.digitalocean_kubernetes_cluster.primary.name
  cluster_id       = data.digitalocean_kubernetes_cluster.primary.id
  write_kubeconfig = true
  domain = local.dmn_dev_domain
}

