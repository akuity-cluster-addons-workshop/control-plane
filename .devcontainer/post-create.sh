#!/bin/bash

echo "post-create start" >> ~/status

# this runs in background after UI is available

echo alias k=kubectl >> /home/vscode/.bashrc
echo 'alias cluster-dev="kubectl config use-context dev"' >> /home/vscode/.bashrc
echo 'alias cluster-prod="kubectl config use-context prod"' >> /home/vscode/.bashrc

echo "post-create complete" >> ~/status