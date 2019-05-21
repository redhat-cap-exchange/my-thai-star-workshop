# "Road to cloud-native" workshop

The "Road to cloud-native" workshop is a 1-day event with a series of hands-on-labs which are designed to familiarize participants with cloud-native concepts and give them a taste of using OpenShift 4 for building and managing cloud-native applications.

## Outline of the day
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

## Intro to the lab environment
* Overview CodeReady Workspaces
* Overview of other tools
  - Nexus
  - Gogs
  - Jenkins

## Lab 0

#### Introduction to devonfw and the reference app
* https://github.com/devonfw
* https://github.com/devonfw/my-thai-star

#### Introduction to workshop assets
* https://github.com/redhat-capgemini-exchange
* https://github.com/redhat-capgemini-exchange/my-thai-star
* https://github.com/redhat-capgemini-exchange/my-thai-star-workshop
  
#### Setup your workspace
* Create a fork of the “My Thai Star” reference application code
* Create a new Java workspace
* Import code
* Finalize the setup
** config Git
** config Maven
** modify POM to use Nexus

## Lab 1 - A first build and first steps in OpenShift

#### In CodeReady workspace
* Manually build the java code -> mvn install
* Launch the java API service
* Test access to the service -> curl ...
* Terminate the running process
* Access OpenShift from the command line
** Open a terminal window
** Login into OpenShift from the CodeReady workspace
** Create a new project from the comand line
*** oc new-project userXY
* A first deployment on OpenShift
    Open the OpenShift developer console
    Navigate to the new project
    Manually create a new Java app
      Add to project ... Red Hat Java 8
      Complete the configuration wizzard
        Name of the app
        Point to you forked app code
        Advanced options
          Git branch
          context dir
    Watch the build process
      EXPECT AN ERROR !!
    Introduction to S2i builds
      add missing config variables
      restart the build

## Lab 2 - Automation of the setup, build & deployment
  Import ‘redhat-capgemini-exchange/my-thai-star-workshop’ into the CodeReady workspace
  Create a new project: oc new-project my-thai-star-userXY
  Introduce templates
    build
    deploy
    others (service, routes, storage etc)
  Add build & deployment templates to the code base
    customize Git references etc
  Deploy build templates
    start build
  Create a deployment
  Add a route

## Lab 3 - Customizing the S2I build process
  Create a build setup for the frontend
    based on the default node.js builder image
  Explain how to customize the S2I process with scripts
    Show the original assemple & run script
    Show the matching docker files from the reference app
    Add custom scripts
  Discuss single page app issues
    how to customize the build to reflect the deployment
    how to serve content
  Build and deploy the frontend
  SHOW THE RUNNING APP !

## Lab 4 - CI/CD setup and Gitflow
  Explain & discuss build triggers
  Add webhooks to Git
  Discuss Gitflow & feature branches etc
    Create a branch
    Make a code change and commit
  Watch the build & deplyment cycle

## Lab 5 - Setup of a deployment pipeline
  Setup TEST and PROD projects
  Introduction to the integrated build pipeline & Jenkins
  Discuss forks, feature branches & pull requests
    Create a pull request against the upstream repo
    Merge changes in upstream
  Trigger CI 
  Setup CD
    Image sharing
    blue / green deployment concept
    Setup CD pipeline

## Additional Labs
* App monitoring and autoscaling
* Logging & distributed tracing
* Build a custom S2I container

## Links and resources
TBD

## Workshop setup
* Deploy an OpenShift cluster using RHPDS
* Deploy the CodeReady Workspace
* Deploy CI/CD apps (Gogs, Nexus, Jenkins)
