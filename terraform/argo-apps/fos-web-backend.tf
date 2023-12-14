


data "kubernetes_service" "nginx_lb" {
  metadata {
    name      = "nginx-ingress-controller"  
    namespace = "default"              
  }
}


data "digitalocean_domain" "fos" {
  name = "fosforescent.com"
}

resource "digitalocean_record" "fos_info_cname_record" {
  domain = data.digitalocean_domain.fos.name
  type   = "CNAME"
  name   = "info"
  value  = "fosforescent.github.io."  # Ensure the value ends with a dot (.)
  ttl    = 3600
}


resource "digitalocean_record" "fos_api_a_record" {
  domain = data.digitalocean_domain.fos.name
  type   = "A"
  name   = "api"
  value  = data.kubernetes_service.nginx_lb.status.0.load_balancer.0.ingress.0.ip
  ttl    = 3600
  depends_on = [ kubectl_manifest.fos_argo_app ]
}



resource "argocd_project" "fos-project" {
  metadata {
    name = "fos-project"
  }
  spec {
    description = "fos project"
    source_repos = ["*"]
    source_namespaces = ["*"]

    destination {
      server = "https://kubernetes.default.svc"
      namespace = "fos"
    }

    destination {
      server = "https://kubernetes.default.svc"
      namespace = "argocd"
    }

  }
}

resource "random_password" "jwt_secret" {
  length  = 16  # You can adjust the length as needed
  special = true
  # You can also set other parameters like `lower`, `upper`, `number` based on your requirements
}

resource "kubernetes_secret" "fos_web_jwt_secret" {
  metadata {
    name      = "fos-web-jwt-secret"
    namespace = "fos"  # Update the namespace as needed
  }

  data = {
    "jwt_secret" = random_password.jwt_secret.result
  }
}


resource "kubectl_manifest" "fos_argo_app" {
  yaml_body = file("../../argo/apps/fos-web-backend/app.yml")
  depends_on = [ argocd_project.fos-project, kubernetes_secret.fos_web_jwt_secret]
}


# resource "argocd_application" "fos" {


#   metadata {
#     name      = "fos-web-backend"
#     namespace = "argocd"
#   }

#   spec {
#     project = "fos-project"


#     destination {
#       server    = "https://kubernetes.default.svc"
#       namespace = "fos"
#     }

#     source {
#       repo_url        = "https://github.com/syc-tech/infra"
#       path            = "helm-charts/temporal"

#       helm {
#         release_name = "fos-backend01"


#         values = yamlencode({
#           someparameter = {
#             enabled   = true
#             someArray = ["foo", "bar"]
#           }
#         })


#       }
#     }
#   }
#   depends_on = [ kubectl_manifest.argo_temporal_project_config ]
# }
