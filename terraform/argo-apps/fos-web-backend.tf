




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



resource "kubectl_manifest" "fos_argo_app" {
  yaml_body = file("../../argo/apps/fos-web-backend/app.yml")
  depends_on = [ argocd_project.fos-project]
}




data "digitalocean_database_user" "fos_web_user" {
  cluster_id = data.digitalocean_database_cluster.postgres_cluster.id
  name       = "fos-web-backend-user"
}




resource "kubernetes_secret" "fos_db_credentials" {
  metadata {
    name      = "fos-web-db-credentials"
    namespace = "fos"
  }

  data = {
    username = data.digitalocean_database_user.fos_web_user.name
    password = data.digitalocean_database_user.fos_web_user.password
    host     = data.digitalocean_database_cluster.postgres_cluster.host
    port     = tostring(data.digitalocean_database_cluster.postgres_cluster.port)
    dbname   = "fos-web-backend"
    url      = "postgresql://${data.digitalocean_database_user.fos_web_user.name}:${data.digitalocean_database_user.fos_web_user.password}@${data.digitalocean_database_cluster.postgres_cluster.host}:${tostring(data.digitalocean_database_cluster.postgres_cluster.port)}/fos-web-backend"
  }
}


resource "kubernetes_secret" "fos_openai_credentials" {
  metadata {
    name      = "fos-openai-credentials"
    namespace = "fos"
  }

  data = {
    key       = var.OPENAI_API_KEY
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
