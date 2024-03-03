

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
