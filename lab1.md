## Lab 1 - A first build and first steps in OpenShift

### In CodeReady workspace

* Manually build the java code

```shell
mvn install
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