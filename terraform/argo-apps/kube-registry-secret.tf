



data "digitalocean_container_registry" "primary" {
  name = "dmn-kubernetes-registry"
}

resource "digitalocean_container_registry_docker_credentials" "kubernetes_registry_credentials" {
  registry_name = data.digitalocean_container_registry.primary.name
}



resource "kubernetes_secret" "fos_registry_credentials" {
  metadata {
    name = "fos-kubernetes-registry-credentials"
    namespace = "fos"  # or any other namespace where you need to pull images
  }

  data = {
    ".dockerconfigjson" = digitalocean_container_registry_docker_credentials.kubernetes_registry_credentials.docker_credentials
  }

  type = "kubernetes.io/dockerconfigjson"
}

resource "kubernetes_secret" "syc_registry_credentials" {
  metadata {
    name = "syc-kubernetes-registry-credentials"
    namespace = "syc"  # or any other namespace where you need to pull images
  }

  data = {
    ".dockerconfigjson" = digitalocean_container_registry_docker_credentials.kubernetes_registry_credentials.docker_credentials
  }

  type = "kubernetes.io/dockerconfigjson"
}