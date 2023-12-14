


data "digitalocean_database_cluster" "postgres_cluster" {
  name = "syc-postgres-cluster"
}

data "digitalocean_database_user" "fos_user" {
  cluster_id = data.digitalocean_database_cluster.postgres_cluster.id
  name       = "fos-web-backend-user"
}


resource "kubernetes_secret" "db_credentials" {
  metadata {
    name      = "fos-web-db-credentials"
    namespace = "default"
  }

  data = {
    username = data.digitalocean_database_user.fos_user.name
    password = data.digitalocean_database_user.fos_user.password
    host     = data.digitalocean_database_cluster.postgres_cluster.host
    port     = tostring(data.digitalocean_database_cluster.postgres_cluster.port)
    dbname   = "fos-web-backend"
    url      = "postgresql://${data.digitalocean_database_user.fos_user.name}:${data.digitalocean_database_user.fos_user.password}@${data.digitalocean_database_cluster.postgres_cluster.host}:${tostring(data.digitalocean_database_cluster.postgres_cluster.port)}/fos-web-backend"
  }
}