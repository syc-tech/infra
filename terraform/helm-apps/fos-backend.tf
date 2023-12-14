
resource "kubernetes_namespace" "fos-backend" {
  metadata {
    name = "fos"
  }
}



# resource "docker_image" "example" {
#   name         = "registry.digitalocean.com/${data.digitalocean_container_registry.main_registry.name}/my-image:latest"
#   build {
#     context    = "../../fos-web-backend"
#   }
# }

# resource "docker_registry_image" "example" {
#   name = "registry.digitalocean.com/${data.digitalocean_container_registry.main_registry.name}/my-image:latest"
# }