#!/bin/bash

export NAMESPACE=workshop

# create a new project
oc new-project $NAMESPACE
oc new-project $NAMESPACE-guide

# create a build configuration
oc create -f deployments/workshopper-image.yaml -n $NAMESPACE-guide
oc start-build workshopper-image -n $NAMESPACE-guide

# create a deployment configuration
oc create -f deployments/workshopper-deploy.yaml -n $NAMESPACE-guide
