################################################################################
#
# deployments
#   A Terraform project for an entire accentis deployment.
#
# backend.tf
#   Defines the terraform backend settings.
#
################################################################################

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "accentis"

    workspaces {
      prefix = "deployment-"
    }
  }
}
