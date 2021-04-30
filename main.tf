################################################################################
#
# deployments
#   A Terraform project for an entire accentis deployment.
#
# main.tf
#   Defines the terraform settings and the resources.
#
################################################################################

# Terraform settings
terraform {
  required_version = "~> 0.15.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.64"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.1.0"
    }
    helm = {
        source  = "hashicorp/helm"
        version = "~> 2.1.1"
    }
  }
}

# Provider settings
provider "google" {
  project = "accentis-288921"
  region  = "us-east1"
}

provider "google-beta" {
  project = "accentis-288921"
  region  = "us-east1"
}

provider "kubernetes" {
    config_context = ""
}

provider "helm" {
    kubernetes {
        config_path = "~/.kube/config"
    }
}

provider "vault" {

}

module "infrastructure" {
    source = "./modules/infrastructure"

    deployment_name = var.deployment_name
    default_compute_engine_service_account = "521113983161-compute@developer.gserviceaccount.com"
}

# module "cluster_utils" {
#     source = "../modules/cluster-utils"
# }

# module "services" {
#     source = "../modules/services"
# }

# module "user_interface" {
#     source = "../modules/user-interfaces"
# }
