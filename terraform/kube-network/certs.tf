resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  namespace  = "cert-manager"
  create_namespace = true
  repository = "https://charts.jetstack.io"
  chart      = "cert-manager"
  version    = "v1.7.1"

  set {
    name  = "installCRDs"
    value = "true"
  }
  set {
    name  = "namespace"
    value = "cert-manager"
  }
  set {
    name = "version"
    value = "v1.13.2"
  }
}

