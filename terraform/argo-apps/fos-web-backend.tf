




data "digitalocean_domain" "fos" {
  name = local.fos_domain[terraform.workspace]
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
  depends_on = [ ]
}



resource "kubectl_manifest" "fos_argo_app" {
  yaml_body = file(local.fos_argo_manifest_path[terraform.workspace])
  depends_on = [ argocd_project.fos-project, kubernetes_secret.fos_db_credentials]
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

resource "argocd_repository" "fos_web_infra" {
  repo = "https://github.com/fosforescent/fos-web-infra"
  username = "davidmnoll"
  password = var.FOS_GITHUB_TOKEN
  name = "fos-web-infra"
}



# resource "kubectl_manifest" "fos_argo_app" {
#   yaml_body = file("../../argo/apps/fos-web-backend/app.yml")
#   depends_on = [ argocd_project.fos-project]
# }




data "digitalocean_database_user" "fos_web_user" {
  cluster_id = data.digitalocean_database_cluster.postgres_cluster.id
  name       = local.fos_db_user_name[terraform.workspace]
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
    dbname   = local.fos_db_name[terraform.workspace]
    url      = "postgresql://${data.digitalocean_database_user.fos_web_user.name}:${data.digitalocean_database_user.fos_web_user.password}@${data.digitalocean_database_cluster.postgres_cluster.host}:${tostring(data.digitalocean_database_cluster.postgres_cluster.port)}/${local.fos_db_name[terraform.workspace]}?connection_limit=5"
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


