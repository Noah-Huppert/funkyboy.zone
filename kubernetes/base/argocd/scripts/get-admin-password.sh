#!/usr/bin/env bash
declare -r PROG_DIR=$(realpath $(dirname "$0"))

# Exit codes
declare -ri EXIT_CODE_UNKNOWN_OPT=10
declare -r EXIT_MSG_UNKNOWN_OPT="Unknown option"

declare -ri EXIT_CODE_KUBECTL_GET_SECRET=11
declare -r EXIT_MSG_KUBECTL_GET_SECRET="Failed to get ArgoCD admin password from secret"

# Common
source "$PROG_DIR/../../../../scripts/common.sh"

declare -r HELP_SCRIPT="get-admin-password.sh"
declare -r HELP_SCRIPT_BLURB="Retrieve the ArgoCD admin password"
declare -ra HELP_OPTIONS=("h?" "p?")
declare -ra HELP_OPTION_BLURBS=("Show help text" "Only output password and no other logs")
declare -r HELP_BEHAVIOR="Uses kubectl to retrieve the secret in which the ArgoCD operator stores the admin user's password"

# Options
declare opt_plain=""
while getopts "hp" opt; do
    case "$opt" in
	   h)
		  generate_help_msg
		  exit 0
		  ;;
	   p) opt_plain="y" ;;
	   '?') die "$EXIT_CODE_UNKNOWN_OPT" "$EXIT_MSG_UNKNOWN_OPT" ;;
    esac
done

# Get admin password
if [[ -z "$opt_plain" ]]; then
    log "Retrieving ArgoCD admin password"
fi

declare  admin_password
admin_password=$(run_check "kubectl -n argocd get secret argocd-cluster -o jsonpath='{.data.admin\.password}' | base64 -d" "$EXIT_CODE_KUBECTL_GET_SECRET" "$EXIT_MSG_KUBECTL_GET_SECRET") || exit

if [[ -z "$opt_plain" ]]; then
    log "ArgoCD admin password:"
    log "  '$admin_password'"
else
    echo "$admin_password"
fi
