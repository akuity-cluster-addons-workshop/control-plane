#!/bin/bash

echo "post-create start" >> ~/status

# this runs in background after UI is available

echo 'alias cluster-dev="kubectl config use-context kind-dev"' >> /home/vscode/.bashrc
echo 'alias cluster-prod="kubectl config use-context kind-prod"' >> /home/vscode/.bashrc

echo "post-create complete" >> ~/status