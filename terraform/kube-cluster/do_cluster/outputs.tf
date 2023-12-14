
output "registry_server_url" {
  value = digitalocean_container_registry.dmn_kubernetes_registry.server_url
}

# output "load_balancer_id" {
#   value = digitalocean_loadbalancer.do_lb.id
# }

output "cluster_id" {
  value = digitalocean_kubernetes_cluster.main_cluster.id
}

output "cluster_name" {
  value = digitalocean_kubernetes_cluster.main_cluster.name
}

output "kube_config" {
  value = data.digitalocean_kubernetes_cluster.primary.kube_config
}

output "cluster_endpoint" {
  value = data.digitalocean_kubernetes_cluster.primary.endpoint
}
output "cluster_ip" { 
  value = digitalocean_kubernetes_cluster.main_cluster.ipv4_address
}
