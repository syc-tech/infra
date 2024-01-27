resource "digitalocean_kubernetes_cluster" "main_cluster" {
    auto_upgrade   = false
    surge_upgrade  = true
    tags           = []
    name           = var.cluster_name
    region         = var.cluster_region
    version        = data.digitalocean_kubernetes_versions.current.latest_version

    node_pool {
        auto_scale        = true
        labels            = {}
        max_nodes         = 5
        min_nodes         = 2
        name              = "pool-wcjf2cbdt"
        size              = var.worker_size
        tags              = []
    }
}

data "digitalocean_kubernetes_cluster" "primary" {
  name = digitalocean_kubernetes_cluster.main_cluster.name
} 


data "digitalocean_kubernetes_versions" "current" {
  version_prefix = var.cluster_version
}

