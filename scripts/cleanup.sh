#!/bin/bash

for i in `seq $1 $2`;
do
  oc delete project coolstore$i
  oc delete project infra$i
done    