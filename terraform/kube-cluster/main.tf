terraform {
  required_version = "~> 1.6.3"
  
  required_providers {

    digitalocean = {
      source = "digitalocean/digitalocean"
      version = ">=2.34.0"
    }

    local = {
      source = "hashicorp/local"
    }

  }


  backend "s3" {
    endpoints                   = {
      s3 = "https://sfo3.digitaloceanspaces.com/" 
    }
    region                      = "us-west-1" 
    key                         = "tfstate/cluster/terraform.tfstate"
    bucket                      = "dmn-infra" 
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true 
    skip_s3_checksum            = true
    skip_region_validation      = true
  }
}

# resource "random_id" "cluster_name" {
#   byte_length = 5
# }


provider "digitalocean" {
  token = var.DO_TOKEN
}


module "cluster_setup_instance" {
  source             = "./do_cluster"
  cluster_name       = local.cluster_name
  cluster_region     = "sfo3"
  cluster_version    = var.cluster_version
  worker_size        = var.worker_size
  worker_count       = var.worker_count
  do_token           = var.DO_TOKEN
}



