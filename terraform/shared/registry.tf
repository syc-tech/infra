resource "digitalocean_container_registry" "dmn_kubernetes_registry" {
  name     = local.registry_name["prod"]
  subscription_tier_slug = local.registry_tier["prod"]
}

