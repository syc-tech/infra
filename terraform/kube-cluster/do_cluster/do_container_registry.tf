resource "digitalocean_container_registry" "dmn_kubernetes_registry" {
  name     = "dmn-kubernetes-registry"
  subscription_tier_slug = "basic"
}

