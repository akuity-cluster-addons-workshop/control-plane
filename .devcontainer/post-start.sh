#!/bin/bash

echo "post-start start" >> ~/status

# this runs in background each time the container starts

minikube start -p prod
minikube start -p dev

echo "post-start complete" >> ~/status