resource "kubernetes_service_v1" "web_ingress_service" {
  metadata {
    name = "web-ingress"
  }
  spec {
    port {
      port        = 80
      target_port = 80
      protocol    = "TCP"
    }
    type = "NodePort"
  }
}


resource "kubernetes_ingress_v1" "web_ingress" {
  wait_for_load_balancer = true
  metadata {
    name      = "web-ingress"
    namespace = "default"
    annotations = {
      "kubernetes.io/ingress.class" = "nginx"
    }
  }
  spec {
    rule {
      host = var.domain
      http {
        path {
          backend {
            service {
              name = "web-ingress"
              port {
                number = 80
              }
            }
          }
          path     = "/*"
        }
      }
    }
  }
  # tls {
  #   secret_name = "tls-secret"
  # }
  
}
