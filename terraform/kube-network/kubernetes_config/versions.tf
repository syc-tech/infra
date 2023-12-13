terraform {

  required_version = ">=1.5.7"

  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = ">=2.4.0"
    }

    helm = {
      source = "hashicorp/helm"
      version = "~>2.11.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~>2.23.0"
    }


  }
}
