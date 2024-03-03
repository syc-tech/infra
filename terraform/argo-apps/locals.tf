locals {
  env = terraform.workspace

  dmn_domain = { 
    dev = "dev.davidmnoll.com"
    prod = "davidmnoll.com"
  }

  syc_domain = {
    dev = "dev.syctech.io"
    prod = "syctech.io"
  }

  fos_domain = {
    dev = "dev.fosforescent.com"
    prod = "fosforescent.com"
  }

  cluster_name = { 
    dev = "dev-cluster"
    prod = "main-cluster"
  }

  registry_name = { 
    dev = "syc-kubernetes-registry"
    prod = "syc-kubernetes-registry"
  }

  write_kubeconfig = {
    dev = false
    prod = false
  }

  db_cluster_name = {
    dev = "dev-syc-postgres-cluster"
    prod = "syc-postgres-cluster"
  }

  fos_db_name = {
    dev = "dev-fos-web-backend"
    prod = "fos-web-backend"
  }

  syc_db_name = {
    dev = "dev-syc-web-backend"
    prod = "syc-web-backend"
  }

  fos_db_user_name = {
    dev = "dev-fos-web-backend-user"
    prod = "fos-web-backend-user"
  }

  syc_db_user_name = {
    dev = "dev-syc-web-backend-user"
    prod = "syc-web-backend-user"
  }

  syc_argo_manifest_path = {
    dev = "../../argo/apps/syc-web-backend/app-dev.yml"
    prod = "../../argo/apps/syc-web-backend/app-prod.yml"
  }

  fos_argo_manifest_path = {
    dev = "../../argo/apps/fos-web-backend/app-dev.yml"
    prod = "../../argo/apps/fos-web-backend/app-prod.yml"
  }


  argocd_address = {
    dev = "argocd.dev.syctech.io"
    prod = "argocd.syctech.io"
  }

  argocd_username = {
    dev = "admin"
    prod = "admin"
  }

  stripe_token = {
    dev = var.STRIPE_TOKEN
    prod = var.PROD_STRIPE_TOKEN
  }

  stripe_subscription_price_id = {
    dev = var.STRIPE_SUBSCRIPTION_PRICE_ID
    prod = var.PROD_STRIPE_SUBSCRIPTION_PRICE_ID
  }

  stripe_webhook_secret = {
    dev = var.STRIPE_WEBHOOK_SECRET
    prod = var.PROD_STRIPE_WEBHOOK_SECRET
  }

  stripe_topup_price_id = {
    dev = var.STRIPE_TOPUP_PRICE_ID
    prod = var.PROD_STRIPE_TOPUP_PRICE_ID
  }

  postmark_api_token = {
    dev = var.POSTMARK_API_TOKEN
    prod = var.PROD_POSTMARK_API_TOKEN
  }

  email_webhook_password = {
    dev = var.EMAIL_WEBHOOK_PASSWORD
    prod = var.PROD_EMAIL_WEBHOOK_PASSWORD
  }

}
