#!/bin/bash
set -eu${DEBUG:+x}o pipefail

#
# developer.sh
#   This script is a wrapper script around deploy.sh to be used to deploy
#   developer deployments.
#

base_directory="$( cd -- "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 ; pwd -P )"

#
# prompt_value:
#   Prompts the operator for a value using the provided prompt message and
#   default value, if provided.  The function will continue to repeat the
#   prompt until a non-empty value is provided.
#
#   Parameters:
#   1:  The prompt message to display
#   2:  (Optional) A default value to use if the operator simply hits ENTER
#       at the prompt.
#
#   Output:
#       Once a non-empty value is answered for the prompt it will be written
#       to stdout.
#
function prompt_value {
    local message=$1
    local default=${2:-}

    if [[ $default ]]; then
        message="$message [$default] "
    fi

    answer=
    while [[ -z $answer ]]; do
        read -p "$message" answer
        
        if [[ -z $answer ]] && [[ $default ]]; then
            answer="$default"
        fi
    done

    echo "$answer"
}

# Provide the ability to set variables ahead of time in an rc file.
if [[ -r ~/.accentis/deploymentsrc ]]; then
    source ~/.accentis/deploymentsrc
fi

# Sets the TF_VAR_deployment_name environment variable's value to the value of
# the ACCENTIS_DEPLOYMENT_NAME environment variable, if it's already set, 
# otherwise it uses the output from the prompt_value function.
export TF_VAR_deployment_name=${ACCENTIS_DEPLOYMENT_NAME:-$(prompt_value "Enter deployment name:" "$(whoami)-dev")}
export ACCENTIS_DEPLOYMENT_TYPE=developer
export ACCENTIS_DEPLOYMENT_PROTECTED=false

command=${1:-apply}

# Hide the backend.tf file since it defines a remote backend, which is not used
# for developer deployments.  Also set a trap to restore the file whenever this
# script exits (success or failure).
mv "$base_directory/backend.tf" "$base_directory/backend.tf.hidden"
trap 'mv "'$base_directory'/backend.tf.hidden" "'$base_directory'/backend.tf"' EXIT

# Run the main deploy script.
"$base_directory/deploy.sh" "$command"

# After a successful destroy remove the Terraform workspace related files
if [[ $command == destroy ]]; then
    rm -rf $base_directory/.terraform &> /dev/null || true
    rm -f $base_directory/.terraform.lock.hcl &> /dev/null || true
    rm -f $base_directory/terraform.tfstate &> /dev/null || true
    rm -f $base_directory/terraform.tfstate.backup &> /dev/null || true
    rm -f $base_directoty/.terraform.tfstate.lock.info &> /dev/null || true
fi
