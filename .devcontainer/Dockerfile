# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.245.2/containers/ubuntu/.devcontainer/base.Dockerfile
FROM mcr.microsoft.com/vscode/devcontainers/base:0-ubuntu-22.04

# Select desired TAG from https://github.com/argoproj/argo-cd/releases
ENV ARGOCD_VERSION=v2.8.4
RUN curl -sSL -o /usr/local/bin/argocd "https://github.com/argoproj/argo-cd/releases/download/${ARGOCD_VERSION}/argocd-linux-amd64" \
    && chmod +x /usr/local/bin/argocd

ENV AKUITY_VERSION=v0.9.3
RUN curl -sSL -o /usr/local/bin/akuity "https://dl.akuity.io/akuity-cli/${AKUITY_VERSION}/linux/amd64/akuity" \
    && chmod +x /usr/local/bin/akuity