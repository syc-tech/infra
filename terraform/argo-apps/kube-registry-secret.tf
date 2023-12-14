



data "digitalocean_container_registry" "primary" {
  name = "dmn-kubernetes-registry"
}

resource "digitalocean_container_registry_docker_credentials" "kubernetes_registry_credentials" {
  registry_name = data.digitalocean_container_registry.primary.name
}



resource "kubernetes_secret" "registry_credentials" {
  metadata {
    name = "syc-kubernetes-registry-credentials"
    namespace = "default"  # or any other namespace where you need to pull images
  }

  data = {
    ".dockerconfigjson" = digitalocean_container_registry_docker_credentials.kubernetes_registry_credentials.docker_credentials
  }

  type = "kubernetes.io/dockerconfigjson"
}