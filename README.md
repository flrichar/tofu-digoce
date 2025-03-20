### Tofu DigitalOcean Droplets & Volumes

Simple quick and easy introduction into tofu(/terraform) and DigOce Droplets (vm-instances) and their relative volumes.

_Suggested `terraform.tfvars` to get started:_
```
droplet_name   = "somename-node000"
droplet_size   = "s-4vcpu-16gb-amd"
droplet_image  = "rockylinux-9-x64"
droplet_region = "tor1"
droplet_ipv6   = "true"
```

Other files like `helmchartconfig`for rke2 custom-cluster, and `user-data.yaml` for cloud-init from the original video are left out,
so the end-user can provide their own.


