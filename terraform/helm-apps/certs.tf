

resource "kubectl_manifest" "clusterissuer_letsencrypt_prod" {
  yaml_body = <<YAML
  apiVersion: cert-manager.io/v1
  kind: ClusterIssuer
  metadata:
    name: letsencrypt-prod
  spec:
    acme:
      email: davidmnoll@gmail.com
      privateKeySecretRef:
        name: letsencrypt-prod
      server: https://acme-v02.api.letsencrypt.org/directory
      solvers:
        - http01:
            ingress:
              class: nginx
  YAML
  # depends_on = [helm_release.cert_manager, null_resource.cert_manager_crds]
}

data "kubernetes_ingress_v1" "main_web_ingress" {
  metadata {
    name      = "web-ingress"
    namespace = "default"
  }
}

resource "digitalocean_domain" "dmn_dev" {
  name       = local.dmn_dev_domain
  ip_address = data.kubernetes_ingress_v1.main_web_ingress.status.0.load_balancer.0.ingress.0.ip
}
