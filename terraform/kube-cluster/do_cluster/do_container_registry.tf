resource "digitalocean_container_registry" "dmn_kubernetes_registry" {
  name     = "dmn-kubernetes-registry"
  subscription_tier_slug = "starter"
}


resource "digitalocean_container_registry_docker_credentials" "kubernetes_registry_credentials" {
  registry_name = digitalocean_container_registry.dmn_kubernetes_registry.name
}

