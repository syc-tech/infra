
resource "kubernetes_namespace" "fos-backend" {
  metadata {
    name = "fos"
  }
}

resource "digitalocean_record" "app-fos" {
  domain = "fosforescent.com"
  type = "CNAME"
  name = "app"
  value = "fos-pages-0.pages.dev."
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