

output "kubeconfig_path" {
  value = var.write_kubeconfig ? abspath("${path.root}/kubeconfig") : "none"
}

# output "registry_docker_credentials" {
#   value = digitalocean_container_registry_docker_credentials.kubernetes_registry_credentials
#   sensitive = true
# }