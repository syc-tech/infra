



data "digitalocean_domain" "syc" {
  name = local.syc_domain[terraform.workspace]
}



resource "digitalocean_record" "syc_api_a_record" {
  domain = data.digitalocean_domain.syc.name
  type   = "A"
  name   = "api"
  value  = data.kubernetes_service.nginx_lb.status.0.load_balancer.0.ingress.0.ip
  ttl    = 3600
  depends_on = [ kubectl_manifest.syc_argo_app ]
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
  yaml_body = file(local.syc_argo_manifest_path[terraform.workspace])
  depends_on = [ argocd_project.syc-project, kubernetes_secret.syc_web_jwt_secret, kubernetes_secret.syc_stripe_info, kubernetes_secret.syc_db_credentials]
}




resource "kubectl_manifest" "syc_clusterrole" {
  yaml_body = file("../../resources/syc-clusterrole.yaml")
  depends_on = [ ]
}

resource "kubectl_manifest" "syc_serviceaccount" {
  yaml_body = file("../../resources/syc-serviceaccount.yaml")
  depends_on = [ ]
}

resource "kubectl_manifest" "syc_clusterrolebinding" {
  yaml_body = file("../../resources/syc-clusterrolebinding.yaml")
  depends_on = [ kubectl_manifest.syc_clusterrole, kubectl_manifest.syc_serviceaccount ]
}





resource "argocd_repository" "syc_web_infra" {
  repo = "https://github.com/syc-tech/syc-web-infra"
  username = "davidmnoll"
  password = var.SYC_GITHUB_TOKEN
  name = "syc-web-infra"
}




data "digitalocean_database_user" "syc_web_user" {
  cluster_id = data.digitalocean_database_cluster.postgres_cluster.id
  name       = local.syc_db_user_name[terraform.workspace]
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
    dbname   = local.syc_db_name[terraform.workspace]
    url      = "postgresql://${data.digitalocean_database_user.syc_web_user.name}:${data.digitalocean_database_user.syc_web_user.password}@${data.digitalocean_database_cluster.postgres_cluster.host}:${tostring(data.digitalocean_database_cluster.postgres_cluster.port)}/${local.syc_db_name[terraform.workspace]}"
  }
}


resource "kubernetes_secret" "syc_stripe_info" {
  metadata {
    name      = "syc-stripe-secret"
    namespace = "syc"
  }

  data = {
    token = local.stripe_token[terraform.workspace]
    subscription-price-id = local.stripe_subscription_price_id[terraform.workspace]
    webhook-secret = local.stripe_webhook_secret[terraform.workspace]
    topup-price-id = local.stripe_topup_price_id[terraform.workspace]
  }
}


resource "kubernetes_secret" "syc_postmark_secret" {
  metadata {
    name      = "syc-postmark-secret"
    namespace = "syc"
  }

  data = {
    token = local.postmark_api_token[terraform.workspace]
  }
}


resource "kubernetes_secret" "syc_email_webhook_info" {
  metadata {
    name      = "syc-emailwebhook-secret"
    namespace = "syc"
  }

  data = {
    pwd = local.email_webhook_password[terraform.workspace]
  }
}


