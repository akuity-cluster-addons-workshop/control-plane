#!/bin/bash
set -e  # Exit on non-zero exit code from commands

# Function to get the health status code
get_health_status() {
    akuity argocd instance list -o json | jq -r '.[0].healthStatus.code'
}

ORG_ID=$(akuity org list | awk 'NR==2 {print $1}')
# Set the organization id in the cli config so users don't have to set it.
akuity config set --organization-id=${ORG_ID}
echo "Set the org id to \"${ORG_ID}\"."

# Apply the declarative akuity platform configuration.
echo "Creating an Argo CD instance on the Akuity Platform,"
echo "from the declarative configuring in the \"akuity-platform\" folder."
akuity argocd apply -f akuity-platform/

# Loop until the instance becomes healthly.
while true; do
    health_status=$(get_health_status)
    # echo "Current health status: $health_status"
    if [ "$health_status" = "STATUS_CODE_HEALTHY" ]; then
        echo "The Argo CD instance is healthy. Exiting loop."
        break
    fi
    echo "The Argo CD instance is still progressing. Waiting 30 seconds..."
    sleep 30  # Average 90 seconds
done

# Deploy agent to clusters.
echo "Deploying Akuity Agent manifests to dev cluster."
kubectl config use-context k3d-dev
akuity argocd cluster get-agent-manifests \
  --instance-name=cluster-addons dev | kubectl apply -f -

echo "Deploying Akuity Agent manifests to prod cluster."
kubectl config use-context k3d-prod
akuity argocd cluster get-agent-manifests \
  --instance-name=cluster-addons prod | kubectl apply -f -

domain=$(awk -F'[/:]' '{print $4}' <<< "$AKUITY_SERVER_URL")
argocd login \
  "$(akuity argocd instance get cluster-addons -o json | jq -r '.id').cd.${domain}" \
  --username admin \
  --password akuity-argocd \
  --grpc-web 
echo "Configured the \"argocd\" cli."

# Trigger refresh since app may get deployed before repo server is up (stuck with ComparisonError).
argocd app get bootstrap --refresh > /dev/null

echo "Workshop environment setup!"