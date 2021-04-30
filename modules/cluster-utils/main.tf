################################################################################
#
# deployments / modules - cluster-utils
#   This Terraform module represents the Cluster Utilities component for all
#   supported deployment types.
#
# main.tf
#   Defines the actual child modules, including their specific versions, to use
#   in this component.
#
################################################################################

module "vault" {
    source = "git@github.com:marcboudreau/accentis-vault-module?ref=v0.1.0"


}