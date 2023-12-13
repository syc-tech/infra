

# resource "kubectl_manifest" "argo_config_cm" {
#   yaml_body = file("./argo_config/argo_config_cm.yaml")
# } 

resource "kubectl_manifest" "argo_temporal_project_config" {
  yaml_body = file("./apps/temporal/temporal-project.yaml")
  depends_on = [ argocd_repository.dmn-infra ]
} 


resource "argocd_repository" "dmn-infra" {
  repo = "https://github.com/davidmnoll/infra"
  username = "davidmnoll"
  password = var.GITHUB_TOKEN
  name = "dmn-infra"
}

resource "kubectl_manifest" "argo_temporal_app" {
  yaml_body = file("./apps/temporal/app.yml")
  depends_on = [ kubectl_manifest.argo_temporal_project_config ]
}


# # Helm application
# resource "argocd_application" "temporal" {


#   metadata {
#     name      = "temporal"
#     namespace = "argocd"
#   }

#   spec {
#     project = "temporal-project"


#     destination {
#       server    = "https://kubernetes.default.svc"
#       namespace = "temporal"
#     }

#     source {
#       repo_url        = "https://github.com/davidmnoll/infra"
#       path            = "helm-charts/temporal"

#       helm {
#         release_name = "temporal01"


#         values = yamlencode({
#           someparameter = {
#             enabled   = true
#             someArray = ["foo", "bar"]
#           }
#         })


#       }
#     }
#   }
#   depends_on = [ kubectl_manifest.argo_temporal_project_config ]
# }
