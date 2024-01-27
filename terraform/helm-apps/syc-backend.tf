
resource "kubernetes_namespace" "syc-backend" {
  metadata {
    name = "syc"
  }
}