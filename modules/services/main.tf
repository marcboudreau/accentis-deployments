################################################################################
#
# deployments / modules - services
#   This Terraform module represents the Services component for all
#   supported deployment types.
#
# main.tf
#   Defines the actual child modules, including their specific versions, to use
#   in this component.
#
################################################################################

module "identity" {
    source = "git@github.com:marcboudreau/accentis-identity-service?ref=v0.1.0"
    
}