## Lab 2 - Source-to-Image (S2I) Build

### What is a Build?

A *build* in OpenShift Container Platform is the process of transforming input parameters into a resulting object. Most often, builds are used to transform source code into a runnable container image.

### Source-to-Image (S2I) Build

Source-to-Image (S2I) is a tool for building reproducible, Docker-formatted container images. It produces ready-to-run images by injecting application source into a container image and assembling a new image. The new image incorporates the base image (the builder) and built source and is ready to use with the docker run command. S2I supports incremental builds, which re-use previously downloaded dependencies, previously built artifacts, etc.

For more details, see [S2I Requirements](https://docs.openshift.com/container-platform/3.11/creating_images/s2i.html#creating-images-s2i).

### Create a new project in OpenShift

In the terminal window, in order to login, `issue the following command` and log in as `$OPENSHIFT_USER @ $OPENSHIFT_PASSWORD`

```bash
  $ oc login $OPENSHIFT_CONSOLE_URL
```

Now create a *project* in OpenShift.

**NOTE:**
Project share a global namespace on the cluster, i.e. project names must be unique. Therefor append your user's number to the project name!


```bash
oc new-project userXY
```

where `XY` is your user's number.

Switch to the OpenShift web console at `$OPENSHIFT_CONSOLE_URL` and navigate to the new project.

### Build the app in OpenShift

1. Navigate to the new project
2. Manually create a new Java app: `Browse Catalog - Red Hat OpenJDK8`
3. Complete the configuration wizzard:
  - Name of the app
  - Point to the repo: **$GOGS_REPO_URL**
  - Advanced options:
    - Branch: `develop`
    - Context: `java/mtsj`

Watch the build & deploy process ...

**EXPECT AN ERROR !!**

### Configure the Build and Deployment

The build- and deployment process can be altered by using environment variables.

#### Build: Add missing variables

1. Navigate to the build configuration: `Project 'userXY' - Builds - Builds - my-thai-star - Environment`
2. Add the following ENV variables:

  - MAVEN_MIRROR_URL: http://nexus.roadtocloudnative.svc:8081/repository/maven-public/
  - MAVEN_S2I_ARTIFACT_DIRS: server/target
  - S2I_SOURCE_DEPLOYMENTS_FILTER: *.war

#### Deployment: Add missing variables

1. Navigate to the build configuration: `Project 'userXY' - Applications - Deployments - my-thai-star - Environment`
2. Add the following ENV variable:

  - JAVA_APP_JAR: mythaistar-bootified.war

`Re-start the build process.`

### Reference

* [How Builds Work](https://docs.openshift.com/container-platform/3.11/dev_guide/builds/index.html)
* [Basic Build Operations](https://docs.openshift.com/container-platform/3.11/dev_guide/builds/basic_build_operations.html)
* [Triggering Builds](https://docs.openshift.com/container-platform/3.11/dev_guide/builds/triggering_builds.html)