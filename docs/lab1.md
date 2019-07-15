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
