#!/bin/bash

# Function to get the health status code
get_health_status() {
    akuity argocd instance list -o json | jq -r '.[0].healthStatus.code'
}

ORG_ID=$(akuity org list | awk 'NR==2 {print $1}')
# Set the organization id in the cli config so users donn't have to set it.
akuity config set --organization-id=${ORG_ID}
echo "Set the org id to \"${ORG_ID}\"."

# Apply the declarative akuity platform configuration.
echo "Creating an Argo CD instance from the contents of the \"akuity-platform\" folder."
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

# Deploy agent to kind clusters.
echo "Deploying Akuity Agent manifests to dev cluster."
kubectl config use-context kind-dev
akuity argocd cluster get-agent-manifests \
  --instance-name=cluster-addons dev | kubectl apply -f -

echo "Deploying Akuity Agent manifests to prod cluster."
kubectl config use-context kind-prod
akuity argocd cluster get-agent-manifests \
  --instance-name=cluster-addons prod | kubectl apply -f -

echo "Workshop environment setup!"