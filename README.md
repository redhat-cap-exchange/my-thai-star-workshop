# "Road to cloud-native" workshop

The "Road to cloud-native" workshop is a 1-day event with a series of hands-on-labs which are designed to familiarize participants with cloud-native concepts and give them a taste of using OpenShift for building and managing cloud-native applications.

### Outline of the day

* Overview (60min)
* Intro to the lab environment (30min)
* Labs (240min)
* Additional labs, if time permits

## Pre-requisites

### Audience

* Architects
* Developers

### Preparation

* Complete “Red Hat OpenShift 3 Foundations”
* Bring your own laptop

# Workshop Content



## Missing parts

* Config Maps, Secrets
* Monitoring endpoints
* Logging
* Storage
* Using existing containers, e.g. databases

## Additional Labs

* App monitoring and autoscaling
* Logging & distributed tracing
* Build a custom S2I container

## Links and resources

#### OpenShift Console
https://master.$CLUSTER.openshiftworkshop.com

#### CodeReady Workspace
http://codeready-workspaces.apps.$CLUSTER.openshiftworkshop.com

#### Gogs
http://gogs-workspaces.apps.$CLUSTER.openshiftworkshop.com

#### Nexus
http://nexus-workspaces.apps.$CLUSTER.openshiftworkshop.com
http://nexus-workspaces.apps.$CLUSTER.openshiftworkshop.com/nexus/#welcome

#### Devonfw on GitHub
https://github.com/devonfw/my-thai-star

## Workshop setup

NOTE: The workshop targets OpenShift 3.11 at the moment. A version supporting OpenShift 4 will follwo later.

### Deploy an OpenShift cluster using RHPDS

Go to https://rhpds.redhat.com/ and create an OpenShift 3.11 cluster.

### Deploy the CodeReady Workspaces and other tools

Run the setup script:

```shell
cd scripts
./setup.sh <name_of_the_cluster> <namespace>
```

### Prepare Git

* Create a new organization 'devonfw'
* Import the upstream 'My Thai Star' reference app
* Import the upstream workshop project
