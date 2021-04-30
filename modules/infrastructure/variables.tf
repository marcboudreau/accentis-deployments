################################################################################
#
# deployments / modules - infrastructure
#   This Terraform module represents the Infrastructure component for all
#   supported deployment types.
#
# variables.tf
#   Defines the input variables used in this component.
#
################################################################################

variable "deployment_name" {
    description = "The name used to identify the deployment of which this component is a part"
    type        = string
}

variable "default_compute_engine_service_account" {
    description = "The email address of the default service account used by Google Compute Engine"
    type        = string
}
