#!/bin/bash

echo "post-start start" >> ~/status

# this runs in background each time the container starts

kind create cluster --name dev
kind create cluster --name prod

echo "post-start complete" >> ~/status