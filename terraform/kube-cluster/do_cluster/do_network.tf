

// TODO - point dmn domain to load balancer


resource "digitalocean_loadbalancer" "do_lb" {
  name   = "do-lb"
  region = "sfo3"
  algorithm = "round_robin"
  redirect_http_to_https = true

  forwarding_rule {
    entry_port     = 80
    entry_protocol = "http"

    target_port     = 80
    target_protocol = "http"
  }

  forwarding_rule {
    entry_port     = 443
    entry_protocol = "https"

    target_port     = 443
    target_protocol = "https"
    tls_passthrough = true
  }
}

# digitalocean_firewall.do_firewall_k8s_external:
resource "digitalocean_firewall" "do_firewall_k8s_external" {
    droplet_ids     = []
    name            = "k8s-public-access-35cb2d60-a9fc-4132-b37f-3ff2e7a8f8aa"
    tags            = [
        "k8s:35cb2d60-a9fc-4132-b37f-3ff2e7a8f8aa",
    ]

    outbound_rule {
        destination_addresses          = [
            "0.0.0.0/0",
            "::/0",
        ]
        destination_droplet_ids        = []
        destination_load_balancer_uids = []
        destination_tags               = []
        protocol                       = "icmp"
    }
    outbound_rule {
        destination_addresses          = [
            "0.0.0.0/0",
            "::/0",
        ]
        destination_droplet_ids        = []
        destination_load_balancer_uids = []
        destination_tags               = []
        port_range                     = "all"
        protocol                       = "tcp"
    }
    outbound_rule {
        destination_addresses          = [
            "0.0.0.0/0",
            "::/0",
        ]
        destination_droplet_ids        = []
        destination_load_balancer_uids = []
        destination_tags               = []
        port_range                     = "all"
        protocol                       = "udp"
    }
}

# digitalocean_firewall.do_firewall_k8s_internal:
resource "digitalocean_firewall" "do_firewall_k8s_internal" {
    droplet_ids     = []
    name            = "k8s-35cb2d60-a9fc-4132-b37f-3ff2e7a8f8aa-worker"
    tags            = [
        "k8s:35cb2d60-a9fc-4132-b37f-3ff2e7a8f8aa",
    ]

    inbound_rule {
        protocol                  = "icmp"
        source_addresses          = [
            "10.0.0.0/8",
            "172.16.0.0/12",
            "192.168.0.0/16",
        ]
        source_droplet_ids        = []
        source_load_balancer_uids = []
        source_tags               = []
    }
    inbound_rule {
        port_range                = "all"
        protocol                  = "tcp"
        source_addresses          = [
            "10.0.0.0/8",
            "172.16.0.0/12",
            "192.168.0.0/16",
        ]
        source_droplet_ids        = []
        source_load_balancer_uids = []
        source_tags               = []
    }
    inbound_rule {
        port_range                = "all"
        protocol                  = "udp"
        source_addresses          = [
            "10.0.0.0/8",
            "172.16.0.0/12",
            "192.168.0.0/16",
        ]
        source_droplet_ids        = []
        source_load_balancer_uids = []
        source_tags               = []
    }

    outbound_rule {
        destination_addresses          = [
            "0.0.0.0/0",
        ]
        destination_droplet_ids        = []
        destination_load_balancer_uids = []
        destination_tags               = []
        protocol                       = "icmp"
    }
    outbound_rule {
        destination_addresses          = [
            "0.0.0.0/0",
        ]
        destination_droplet_ids        = []
        destination_load_balancer_uids = []
        destination_tags               = []
        port_range                     = "all"
        protocol                       = "tcp"
    }
    outbound_rule {
        destination_addresses          = [
            "0.0.0.0/0",
        ]
        destination_droplet_ids        = []
        destination_load_balancer_uids = []
        destination_tags               = []
        port_range                     = "all"
        protocol                       = "udp"
    }
}