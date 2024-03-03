

output "kubeconfig_path" {
  value = local.write_kubeconfig[terraform.workspace] ? abspath("${path.root}/${terraform.workspace}/kubeconfig") : "none"
}



# output "registry_docker_credentials" {
#   value = digitalocean_container_registry_docker_credentials.kubernetes_registry_credentials
#   sensitive = true
# }