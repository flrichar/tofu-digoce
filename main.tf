## Jan 2025 DO_TF

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.49"
    }
  }
}

// Set first variable value in *.tfvars file
// or using -var="do_token=..." CLI option
// or export TF_VAR_do_token=... 
variable "do_token" {}

// Other environment vars from terraform.tfvars
variable droplet_name {}
variable droplet_size {}
variable droplet_image {}
variable droplet_region {}
variable droplet_ipv6 {}

// Configure the DigitalOcean Provider
provider "digitalocean" {
  token = var.do_token
}

// Tagging your resources
resource "digitalocean_tag" "user" {
  name = "user:fredr"
}

// Reuse an existing ssh-key pair
resource "digitalocean_ssh_key" "digoce" {
  name       = "digoce-fredr-rsa"
  public_key = file("/home/flr/.ssh/digoce.pub")
}

// extra-volume
resource "digitalocean_volume" "fredr" {
  region                  = "tor1"
  name                    = "fred-volume"
  size                    = 10
  initial_filesystem_type = "ext4"
  description             = "fredr-test volume"
  tags                    = [digitalocean_tag.user.id]

}

// attach extra-volume to droplet
resource "digitalocean_volume_attachment" "extra-volume" {
  droplet_id = digitalocean_droplet.fredr.id
  volume_id  = digitalocean_volume.fredr.id
}

// droplet parameters
resource "digitalocean_droplet" "fredr" {
  name = var.droplet_name
  size = var.droplet_size
  image     = var.droplet_image
  region    = var.droplet_region
  ipv6      = var.droplet_ipv6
  tags      = [digitalocean_tag.user.id]
  ssh_keys  = [digitalocean_ssh_key.digoce.fingerprint]
  user_data = file("/home/flr/geexology/digoce/user-data.yaml")
}

###
