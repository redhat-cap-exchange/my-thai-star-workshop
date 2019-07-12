## Appendix B: Workshop Setup

Instructions how to prepare the cluster for the workshop ...

### Setup the workshop environment

```bash

export WORKSPACE=workshop

# create a new project
oc new-project $WORKSPACE
oc project $WORKSPACE

# create a build configuration
oc create -f deployments/workshopper-image.yaml
oc start-build workshopper-image

# create a deployment configuration
oc create -f deployments/workshopper-deploy.yaml

# create Nexus
oc new-app sonatype/nexus -n $WORKSPACE
oc rollout pause dc/nexus -n $WORKSPACE
oc expose svc/nexus
oc set probe dc/nexus --liveness --failure-threshold 3 --initial-delay-seconds 180 -- echo ok
oc set probe dc/nexus --readiness --failure-threshold 3 --initial-delay-seconds 120 --get-url=http://:8081/nexus/content/groups/public
oc set volume dc/nexus --add --name 'nexus-volume-1' --type 'pvc' --mount-path '/sonatype-work/' --claim-name 'nexus-data' --claim-size '10G' --overwrite
oc rollout resume dc/nexus -n $WORKSPACE

```

You can run script `scripts/setup.sh` to perform the above steps.

### Setup Red Hat CodeReady Workspaces

#### Prerequisites

1. Login with a `cluster-admin` role
2. Change to directory scripts/codeready

Now runt he following script:

```
./deploy.sh --deploy
```