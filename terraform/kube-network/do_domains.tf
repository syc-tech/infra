resource "digitalocean_domain" "dmn" {
  name = local.dmn_domain[terraform.workspace]
}



resource "digitalocean_domain" "syc" {
  name = local.syc_domain[terraform.workspace]
}


resource "digitalocean_domain" "fos" {
  name = local.fos_domain[terraform.workspace]
}


