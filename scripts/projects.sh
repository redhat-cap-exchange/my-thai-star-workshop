#!/bin/bash

for i in `seq $1 $2`;
do
  PROJECT_NAME="mythaistar-user$i"
  USER_NAME="user$i"

  # delete the project if it exists
  oc delete project $PROJECT_NAME

  # create a new one
  oc new-project $PROJECT_NAME

  # add the user
  oc adm policy add-role-to-user admin $USER_NAME -n $PROJECT_NAME
  oc policy add-role-to-user view -n $PROJECT_NAME -z default

  # increase resource limits
  oc delete limitrange $PROJECT_NAME-core-resource-limits
  oc create -f scripts/resource-limits.yaml

done    