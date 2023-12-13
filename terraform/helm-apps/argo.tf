
resource "kubectl_manifest" "argo_rbac_cm" {
  yaml_body = file("../../argo-resources/argocd-rbac-cm.yaml")
  depends_on = [ helm_release.argo_cd ]
} 


resource "kubectl_manifest" "argo_clusterrolebinding" {
  yaml_body = file("../../argo-resources/argocd-clusterrolebinding.yaml")
  depends_on = [ helm_release.argo_cd ]
} 



resource "kubectl_manifest" "argo_cm" {
  yaml_body = file("../../argo-resources/argocd-cm.yaml")
  depends_on = [ helm_release.argo_cd ]
} 



resource "helm_release" "argo_cd" {
  name       = "argo-cd"
  namespace  = "argocd"
  dependency_update = true
  chart     = "./../../helm-charts/argo/charts/argo-cd"
  # TODO: set
  # - allowed namespaces for project
  # - allowed namespaces in CM
  # - allowed namespaces for app 
  # - allowed namespaces for something else? 
  set {
    name  = "admin.enabled"
    value = true
  }

  set {
    name = "application.resourceTrackingMethod"
    value = "annotation"
  }

  set {
    name  = "application.namespaces"
    value = "*"
  }



}

data "kubernetes_secret" "argocd_initial_admin_secret" {
  metadata {
    name      = "argocd-secret"  # Replace with the actual name of the secret
    namespace = "argocd"         # Replace with the correct namespace
  }
}

resource "kubernetes_namespace" "argocd_namespace" {
  metadata {
    annotations = {
      name = "argocd"
    }

    name = "argocd"
  }
}



resource "kubernetes_ingress_v1" "argocd_server_ingress" {
  metadata {
    name      = "argocd-server-ingress"
    namespace = "argocd"
    annotations = {
      "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
      "nginx.ingress.kubernetes.io/ssl-passthrough"    = "true"
      "cert-manager.io/cluster-issuer"                 = "letsencrypt-prod"
      "nginx.ingress.kubernetes.io/backend-protocol"   = "HTTPS"
    }
  }

  spec {
    ingress_class_name = "nginx"
    rule {
      host = "argocd.davidmnoll.com"
      http {
        path {
          backend {
            service {
              name = "argo-cd-argocd-server"
              port {
                name       = "https"
              }
              
            }
          }
          path     = "/"
          path_type = "Prefix"
        }
      }
    }
    tls {
      hosts      = ["argocd.davidmnoll.com"]
      secret_name = "argocd-server-tls"
    }
  }
}

resource "kubernetes_manifest" "argocd-certificate" {
  manifest = {
    apiVersion = "cert-manager.io/v1"
    kind       = "Certificate"
    metadata = {
      name      = "argocd-certificate"
      namespace = "argocd"
    }
    spec = {
      secretName = "argocd-server-tls"
      issuerRef = {
        name = "letsencrypt-prod"
        kind = "ClusterIssuer"
      }
      commonName = "argocd.davidmnoll.com"
      dnsNames = [
        "argocd.davidmnoll.com",
      ]
    }
  }
}

