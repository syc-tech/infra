

provider "digitalocean" {
  token = var.DO_TOKEN
}


# provider "docker" {
#   host = "tcp://127.0.0.1:1234/"

#   registry_auth {
#     address             = data.digitalocean_container_registry.primary.endpoint
#     config_file_content = data.digitalocean_container_registry_docker_credentials.primary.docker_credentials
#   }

# }


provider "kubernetes" {
  host             = data.digitalocean_kubernetes_cluster.primary.endpoint
  token            = data.digitalocean_kubernetes_cluster.primary.kube_config[0].token
  cluster_ca_certificate = base64decode(
    data.digitalocean_kubernetes_cluster.primary.kube_config[0].cluster_ca_certificate
  )
}



provider "helm" {
  kubernetes {
    host  = data.digitalocean_kubernetes_cluster.primary.endpoint
    token = data.digitalocean_kubernetes_cluster.primary.kube_config[0].token
    cluster_ca_certificate = base64decode(
      data.digitalocean_kubernetes_cluster.primary.kube_config[0].cluster_ca_certificate
    )
  }
}



provider "kubectl" {
  host                   = data.digitalocean_kubernetes_cluster.primary.endpoint
  cluster_ca_certificate = base64decode(
      data.digitalocean_kubernetes_cluster.primary.kube_config[0].cluster_ca_certificate
    )
  token                  = data.digitalocean_kubernetes_cluster.primary.kube_config[0].token
  load_config_file       = false
}



data "digitalocean_container_registry" "main_registry" {
  name = "dmn-kubernetes-registry"
}



provider "docker" {
  # Registry URL for DigitalOcean Container Registry
  registry_auth {
    address  = "registry.digitalocean.com/${data.digitalocean_container_registry.main_registry.name}"
    config_file_content = var.REGISTRY_CREDENTIALS
  }
}
