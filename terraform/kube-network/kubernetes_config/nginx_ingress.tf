

resource "helm_release" "nginx_ingress_chart" {
  name       = "nginx-ingress-controller"
  namespace  = "default"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "nginx-ingress-controller"
  set {
    name  = "service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "service.annotations.kubernetes\\.digitalocean\\.com/load-balancer-name"
    value = "do-lb"
  }

  set {
    name  = "controller.extraArgs.enable-ssl-passthrough"
    value = "true"
  }
}

