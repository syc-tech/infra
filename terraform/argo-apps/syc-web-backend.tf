



data "digitalocean_domain" "syc" {
  name = "syctech.io"
}



resource "digitalocean_record" "syc_api_a_record" {
  domain = data.digitalocean_domain.syc.name
  type   = "A"
  name   = "api"
  value  = data.kubernetes_service.nginx_lb.status.0.load_balancer.0.ingress.0.ip
  ttl    = 3600
  depends_on = [ kubectl_manifest.fos_argo_app ]
}



resource "argocd_project" "syc-project" {
  metadata {
    name = "syc-project"
  }
  spec {
    description = "syc project"
    source_repos = ["*"]
    source_namespaces = ["*"]

    destination {
      server = "https://kubernetes.default.svc"
      namespace = "syc"
    }

    destination {
      server = "https://kubernetes.default.svc"
      namespace = "argocd"
    }

  }
}

resource "random_password" "jwt_secret_2" {
  length  = 16  # You can adjust the length as needed
  special = true
  # You can also set other parameters like `lower`, `upper`, `number` based on your requirements
}

resource "kubernetes_secret" "syc_web_jwt_secret" {
  metadata {
    name      = "syc-web-jwt-secret"
    namespace = "syc"  # Update the namespace as needed
  }

  data = {
    "jwt_secret" = random_password.jwt_secret_2.result
  }
}


resource "kubectl_manifest" "syc_argo_app" {
  yaml_body = file("../../argo/apps/syc-web-backend/app.yml")
  depends_on = [ argocd_project.syc-project, kubernetes_secret.syc_web_jwt_secret]
}



data "digitalocean_database_user" "syc_web_user" {
  cluster_id = data.digitalocean_database_cluster.postgres_cluster.id
  name       = "syc-web-backend-user"
}



resource "kubernetes_secret" "syc_db_credentials" {
  metadata {
    name      = "syc-web-db-credentials"
    namespace = "syc"
  }

  data = {
    username = data.digitalocean_database_user.syc_web_user.name
    password = data.digitalocean_database_user.syc_web_user.password
    host     = data.digitalocean_database_cluster.postgres_cluster.host
    port     = tostring(data.digitalocean_database_cluster.postgres_cluster.port)
    dbname   = "syc-web-backend"
    url      = "postgresql://${data.digitalocean_database_user.syc_web_user.name}:${data.digitalocean_database_user.syc_web_user.password}@${data.digitalocean_database_cluster.postgres_cluster.host}:${tostring(data.digitalocean_database_cluster.postgres_cluster.port)}/syc-web-backend"
  }
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
