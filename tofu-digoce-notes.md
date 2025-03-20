## Digital Ocean Droplets & Terraform
There are many way to manage Digital Ocean resources in an automated fashion without needing to log into the web interface. Switching from the CLI to a web UI can be very disruptive in a workflow, especially when you just need answers to simple questions. With the `doctl` command line interface and the Terraform Provider we can use the API to manage resources, create basic reports, and stand up simple labs for testing.


The first step is to create a PAT (Personal Access Token), browse to the UI and then your account, and choose API.  A very simple scope includes both Read and Write permissions. Recently the scopes option has changed for enhanced security, its easier to manage multiple tokens with different custom scopes.


One you have a token/PAT you are ready to work with both `doctl` and the terraform provider.
* [Creating a Personal Access Token](https://docs.digitalocean.com/reference/api/create-personal-access-token/)
* [A reference for installing and configuring the `doctl` binary.](https://docs.digitalocean.com/reference/doctl/how-to/install/)

```
doctl auth init
...

doctl vpcs list
...

doctl compute volume list
...

doctl compute droplet list
...

```

### Goals
I wanted to perform these main operations -
- commandline reports on Volumes and Droplets using `doctl`
- use OpenTofu/Terraform to manage my personal Volumes and Droplets
- create a single-node for an optional RKE2 Custom cluster

With the goals, automation testing is accelerated enabling faster API interactions. I chose not to create a new VPC but rather to use an existing VPC local to my region, from the output of `doctl vpcs list`.  For this the terraform plan does not have to be very complex! It can be as simple as we want to make it.
How do we want to make it?

### Checklist
- choose a local, existing, regional VPC (Toronto)
- create droplet parameters, including size, ipv6, tags with my user-id, make the environment modular for different options
- re-use existing ssh-key, cloud-init user-data, and preconfigured RKE2 `HelmChartConfig`
- create and attach an extra volume to the droplet, linked to the droplet, destroyed when the droplet is destroyed 
- design an access-list of trusted services
- display output values on refresh, reconfiguration, or output command

The tools make this process much easier than it may initially sound...
```
## This is the part where we look at the TF Plan and play!
...

```
