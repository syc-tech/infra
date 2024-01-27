resource "digitalocean_database_cluster" "postgres_cluster" {
  name       = "syc-postgres-cluster"
  engine     = "pg"
  version    = "12"
  size       = "db-s-1vcpu-1gb"
  region     = "nyc1"
  node_count = 1
}

resource "digitalocean_database_db" "fos_db" {
  cluster_id = digitalocean_database_cluster.postgres_cluster.id
  name       = "fos-web-backend"
  depends_on = [ digitalocean_database_cluster.postgres_cluster ]
}


resource "digitalocean_database_user" "fos_user" {
  cluster_id = digitalocean_database_cluster.postgres_cluster.id
  name       = "fos-web-backend-user"
  depends_on = [ digitalocean_database_db.fos_db ]
}

resource "digitalocean_database_db" "syc_db" {
  cluster_id = digitalocean_database_cluster.postgres_cluster.id
  name       = "syc-web-backend"
  depends_on = [ digitalocean_database_cluster.postgres_cluster ]
}


resource "digitalocean_database_user" "syc_user" {
  cluster_id = digitalocean_database_cluster.postgres_cluster.id
  name       = "syc-web-backend-user"
  depends_on = [ digitalocean_database_db.fos_db ]
}
