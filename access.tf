###

resource "digitalocean_firewall" "fredr" {
  name = "fredr-trusted-services"

  droplet_ids = [digitalocean_droplet.fredr.id]
  tags        = [digitalocean_tag.user.id]

  inbound_rule {
    protocol         = "tcp"
    port_range       = "22"
    source_addresses = ["75.117.248.31/32", "10.118.0.0/20", "::/0"]
  }

  inbound_rule {
    protocol         = "tcp"
    port_range       = "443"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "icmp"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  // avoid common k8s ports 6443, 9345, 10250

  inbound_rule {
    protocol         = "tcp"
    port_range       = "16384-65535"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  inbound_rule {
    protocol         = "udp"
    port_range       = "16384-65535"
    source_addresses = ["0.0.0.0/0", "::/0"]
  }

  // catchall outbound

  outbound_rule {
    protocol              = "tcp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "udp"
    port_range            = "1-65535"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }

  outbound_rule {
    protocol              = "icmp"
    destination_addresses = ["0.0.0.0/0", "::/0"]
  }
}

###
