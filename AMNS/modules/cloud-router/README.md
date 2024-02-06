
This module handles Cloud Router.

## Usage

Basic usage of this module is as follows:

```hcl
module "cloud_router" {
  source  = "../modules/cloud-router"
  name    = "example-router"
  project = "<PROJECT ID>"
  region  = "us-central1"
  network = "default"
}
```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| bgp | BGP information specific to this router. | `any` | `null` | no |
| description | An optional description of this resource | `string` | `null` | no |
| name | Name of the router | `string` | n/a | yes |
| nats | NATs to deploy on this router. | `any` | `[]` | no |
| network | A reference to the network to which this router belongs | `string` | n/a | yes |
| project | The project ID to deploy to | `string` | n/a | yes |
| region | Region where the router resides | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| router | The created router |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->



### Software

The following dependencies must be available:

- Terraform v0.12 and above

### Service Account

A service account with the following roles must be used to provision
the resources of this module:

- Network Admin: `roles/compute.networkAdmin`


### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Google Cloud Compute Engine API: `compute.googleapis.com`


