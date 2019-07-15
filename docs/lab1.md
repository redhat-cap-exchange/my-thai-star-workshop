# Lab 1 - A first build and first steps in OpenShift

### Prepare Maven

Open `my-thai-star/java/mtsj/pom.xml`. Add `snippets/pom.xm` to the end of project's pom.xml file. 

In the terminal window:

```bash
cd
cd .m2
vi settings.xml
```

Insert `snippets/settings.xml` and save the new file (ESC :wq). Switch back to the project location:

```bash
cd /projects/my-thai-star
```

Switch to the java component`s root location:

```bash
cd java/mtsj
```

### Build the app

```shell
mvn install -DskipTests=true
```

### Deploy the artifacts

```shell
mvn deploy -DskipTests=true
```

### Launch the app

Launch the app within the workspace:

```bash
java -jar server/target/mythaistar-bootified.war
```

You can now wath the Spring Boot application spin up.

#### How to terminate the app?

The easiest way to terminate the app is to kill it's process. Open a `open a second terminal` by clicking on the '+' next the current terminal window:

```bash
ps -u | grep java
````

![Lab1](images/lab1-terminal.png)

Copy the PID and kill the process:

```bash
kill -9 <PID>
```

### Create a new project in OpenShift

In the terminal window, in order to login, `issue the following command` and log in as `$OPENSHIFT_USER @ $OPENSHIFT_PASSWORD`

```bash
  $ oc login $OPENSHIFT_CONSOLE_URL
```

Now create a *project* in OpenShift:

```bash
oc new-project userXY
```

Switch to the OpenShift web console at `$OPENSHIFT_CONSOLE_URL` and navigate to the new project.





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