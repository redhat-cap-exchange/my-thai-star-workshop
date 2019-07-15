## Lab 1 - A first build and first steps in OpenShift

Config java project and build it in CodeReady.

### In CodeReady workspace

* Project - Show/Hide hidden files

#### Config Maven

* Add snippets/pom.xml to java/mtsj/pom.xml
* Copy snippets/settings.xml to ~/.m2/settings.xml

#### Build

```shell
mvn install -DskipTests=true
```

#### Deploy the artifacts

```shell
mvn deploy -DskipTests=true
```

* Launch the java API service
* Test access to the service

```shell
curl http://localhost:8080
```

* Terminate the running process
 
### Access OpenShift from the command line
* Open a terminal window
* Login into OpenShift from command line
```shell
oc login https://<url_of_cluster>
```
* Create a new project from the comand line
```shell
oc new-project userXY
```

### A first deployment on OpenShift
* Open the OpenShift developer console
* Navigate to the new project
* Manually create a new Java app
* Complete the configuration wizzard
  - Name of the app
  - Point to you forked app code
  - Advanced options: git branch, context dir
* Watch the build process

**EXPECT AN ERROR !!**

### Introduction to S2i builds
* Add missing config variables
* Restart the build