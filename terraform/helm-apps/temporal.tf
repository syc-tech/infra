




# resource "helm_release" "temporal-cluster" {
#   name       = "temporal-cluster"
#   namespace  = "temporal"
#   dependency_update = true
#   chart     = "../../helm-charts/temporal"
#   create_namespace = true

#   values = []

#   set {
#     name  = "server.replicaCount"
#     value = 1
#   }

#   set {
#     name  = "cassandra.config.cluster_size"
#     value = 2
#   }
#   set {
#     name  = "prometheus.enabled"
#     value = false
#   }
#   set {
#     name  = "grafana.enabled"
#     value = false
#   }
#   set {
#     name  = "elasticsearch.enabled"
#     value = false
#   }
#   set {
#     name = "schema.setup.enabled"
#     value = true
#   }
#   set {
#     name = "volumePermissions.enabled"
#     value = true
#   }
# }

# resource "kubernetes_ingress_v1" "temporal_server_ingress" {
#   metadata {
#     name      = "temporal-server-ingress"
#     namespace = "temporal"
#     annotations = {
#       "nginx.ingress.kubernetes.io/force-ssl-redirect" = "true"
#       "nginx.ingress.kubernetes.io/ssl-passthrough"    = "true"
#       "cert-manager.io/cluster-issuer"                 = "letsencrypt-prod"
#       "nginx.ingress.kubernetes.io/backend-protocol"   = "HTTPS"
#     }
#   }

#   spec {
#     ingress_class_name = "nginx"
#     rule {
#       host = "temporal.davidmnoll.com"
#       http {
#         path {
#           backend {
#             service {
#               name = "argo-cd-argocd-server"
#               port {
#                 name       = "https"
#               }
              
#             }
#           }
#           path     = "/"
#           path_type = "Prefix"
#         }
#       }
#     }
#     tls {
#       hosts      = ["temporal.davidmnoll.com"]
#       secret_name = "temporal-server-tls"
#     }
#   }
# }

# resource "kubernetes_manifest" "temporal-certificate" {
#   manifest = {
#     apiVersion = "cert-manager.io/v1"
#     kind       = "Certificate"
#     metadata = {
#       name      = "temporal-certificate"
#       namespace = "temporal"
#     }
#     spec = {
#       secretName = "temporal-server-tls"
#       issuerRef = {
#         name = "letsencrypt-prod"
#         kind = "ClusterIssuer"
#       }
#       commonName = "temporal.davidmnoll.com"
#       dnsNames = [
#         "temporal.davidmnoll.com",
#       ]
#     }
#   }
# }

