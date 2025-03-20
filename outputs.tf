###

output "ipv4_address" {
  value = digitalocean_droplet.fredr.ipv4_address
}

output "ipv6_address" {
  value = digitalocean_droplet.fredr.ipv6_address
}

output "image" {
  value = digitalocean_droplet.fredr.image
}

output "size" {
  value = digitalocean_droplet.fredr.size
}

output "region" {
  value = digitalocean_droplet.fredr.region
}

output "vpc_uuid" {
  value = digitalocean_droplet.fredr.vpc_uuid
}

output "volume_attachment-volume_ids" {
  value = [digitalocean_volume_attachment.extra-volume.volume_id]
}

###
