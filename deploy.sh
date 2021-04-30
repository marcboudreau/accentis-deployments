#!/bin/bash
set -eu${DEBUG:+x}o pipefail

command=${1:-apply}

case $command in
apply|destroy)
    ;;
*)
    echo "Error: unsupported command passed to deploy.sh: $command"
    exit 1
    ;;
esac

export TF_WORKSPACE=$TF_VAR_deployment_name

# Initialize Terraform workspace
terraform init -input=false ${CI:+"-no-color"} -get=true

if [[ ${ACCENTIS_DEPLOYMENT_PROTECTED:-false} != true ]] && [[ $command == destroy ]]; then
    # Destroy Terraform configuration (targetting infrastructure module, since
    # it will take down all component tiers above it)
    terraform destroy -input=false -target=module.infrastructure
elif [[ $command == apply ]]; then
    # Apply Terraform configuration for the Infrastructure component
    terraform apply -input=false ${CI:+"-no-color"} -target=module.infrastructure

    # Apply Terraform configuration for the Cluster Utilities component
    #terraform apply -input=false ${CI:+"-no-color"} -target=module.cluster_utils

    # Apply Terraform configuration for the Services component
    #terraform apply -input=false ${CI:+"-no-color"} -target=module.services

    # Apply Terraform configuration for the User Interface component
    #terraform apply -input=false ${CI:+"-no-color"} -target=module.user_interface
fi
