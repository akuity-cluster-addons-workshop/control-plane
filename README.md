# Control Plane

This repository is used in [the Cluster Add-Ons with ApplicationSets tutorial](https://docs.akuity.io/tutorials/cluster-addons-with-applicationsets/) presented by Akuity.

Repository contains the following directories:

| Directory | Purpose |
|-|-|
| `.devcontainer` | [`devcontainer`](https://containers.dev/) used to create Kubernetes clusters with Minikube. |
| `.github` | GitHub Actions workflow to update the repository URL used in manifests when cloned. |
| `akuity` | Argo CD instance configuration for the Akuity Platform for use with `akuity argocd apply -f`. |
| `bootstrap` | `ApplicationSets` deployed by the `bootstrap` `Application`. |
| `charts/addons` | Helm Umbrella charts used for cluster add-ons. |
| `clusters` | Cluster-specific configurations, containing overrides for add-on chart values and `Applications` for the cluster. |