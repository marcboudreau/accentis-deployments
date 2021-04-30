################################################################################
#
# deployments / modules - infrastructure
#   This Terraform module represents the Infrastructure component for all
#   supported deployment types.
#
# main.tf
#   Defines the actual child modules, including their specific versions, to use
#   in this component.
#
################################################################################

module "gke_cluster" {
    source = "git@github.com:marcboudreau/accentis-gke-cluster-module?ref=v0.1.1"

    cluster_id                  = var.deployment_name
    base_cidr_block             = "10.0.0.0/16"
    worker_node_service_account = var.default_compute_engine_service_account
}
