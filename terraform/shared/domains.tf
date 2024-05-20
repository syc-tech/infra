


data "digitalocean_domain" "syc" {
  name = "syctech.io"
}

data "digitalocean_domain" "fos" {
  name = "fosforescent.com"
}

data "digitalocean_domain" "dmn" {
  name = "davidmnoll.com"
}


resource "digitalocean_record" "fos_app_record" {
  domain = data.digitalocean_domain.fos.name
  type   = "CNAME"
  name   = "www"
  value  = "fos-prod.pages.dev."
  ttl    = 3600
  depends_on = [ ]
}


resource "digitalocean_record" "fos_mail_record" {
  domain = data.digitalocean_domain.fos.name
  type   = "MX"
  name   = "@"
  priority = 10
  value  = "inbound.postmarkapp.com."
  ttl    = 3600
  depends_on = [ ]
}



resource "digitalocean_record" "dev_fos_ns_record1" {
  domain = data.digitalocean_domain.fos.name
  type   = "NS"
  name   = "dev"
  value  = "ns1.digitalocean.com."
  ttl    = 3600
  depends_on = [ ]
}

resource "digitalocean_record" "dev_fos_ns_record2" {
  domain = data.digitalocean_domain.fos.name
  type   = "NS"
  name   = "dev"
  value  = "ns2.digitalocean.com."
  ttl    = 3600
  depends_on = [ ]
}

resource "digitalocean_record" "dev_fos_ns_record3" {
  domain = data.digitalocean_domain.fos.name
  type   = "NS"
  name   = "dev"
  value  = "ns3.digitalocean.com."
  ttl    = 3600
  depends_on = [ ]
}



resource "digitalocean_record" "dev_syc_ns_record1" {
  domain = data.digitalocean_domain.syc.name
  type   = "NS"
  name   = "dev"
  value  = "ns1.digitalocean.com."
  ttl    = 3600
  depends_on = [ ]
}

resource "digitalocean_record" "dev_syc_ns_record2" {
  domain = data.digitalocean_domain.syc.name
  type   = "NS"
  name   = "dev"
  value  = "ns2.digitalocean.com."
  ttl    = 3600
  depends_on = [ ]
}

resource "digitalocean_record" "dev_syc_ns_record3" {
  domain = data.digitalocean_domain.syc.name
  type   = "NS"
  name   = "dev"
  value  = "ns3.digitalocean.com."
  ttl    = 3600
  depends_on = [ ]
}


resource "digitalocean_record" "dmn__gh_page_record" {
  domain = data.digitalocean_domain.dmn.name
  type   = "CNAME"
  name   = "www"
  value  = "davidmnoll.github.io."
  ttl    = 3600
  depends_on = [ ]
}


# resource "digitalocean_record" "dev_dmn_ns_record1" {
#   domain = data.digitalocean_domain.dmn.name
#   type   = "NS"
#   name   = "dev"
#   value  = "ns1.digitalocean.com."
#   ttl    = 3600
#   depends_on = [ ]
# }

# resource "digitalocean_record" "dev_dmn_ns_record2" {
#   domain = data.digitalocean_domain.dmn.name
#   type   = "NS"
#   name   = "dev"
#   value  = "ns2.digitalocean.com."
#   ttl    = 3600
#   depends_on = [ ]
# }

# resource "digitalocean_record" "dev_dmn_ns_record3" {
#   domain = data.digitalocean_domain.dmn.name
#   type   = "NS"
#   name   = "dev"
#   value  = "ns3.digitalocean.com."
#   ttl    = 3600
#   depends_on = [ ]
# }

