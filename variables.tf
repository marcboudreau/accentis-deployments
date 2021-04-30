################################################################################
#
# deployments
#   A Terraform project for an entire accentis deployment.
#
# main.tf
#   Defines the terraform settings and the resources.
#
################################################################################

variable "deployment_name" {
  description = "The name used to identity the developer deployment"
  type        = string
}

