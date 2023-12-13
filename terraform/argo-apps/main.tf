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

    argocd = {
      source = "oboukili/argocd"
      version = ">= 6.0.3"
    }


  }


  backend "s3" {
    endpoints                   = {
      s3 = "https://sfo3.digitaloceanspaces.com/" 
    }
    region                      = "us-west-1" 
    key                         = "tfstate/argo-apps/terraform.tfstate"
    bucket                      = "dmn-infra" 
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true 
    skip_s3_checksum            = true
    skip_region_validation      = true
  }
  
}



