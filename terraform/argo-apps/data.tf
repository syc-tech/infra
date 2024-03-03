data "kubernetes_service" "nginx_lb" {
  metadata {
    name      = "nginx-ingress-controller"  
    namespace = "default"              
  }
}



data "digitalocean_database_cluster" "postgres_cluster" {
  name = local.db_cluster_name[terraform.workspace]
}

