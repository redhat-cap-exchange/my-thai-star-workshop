# Lab 5 - Monitoring Application Health 

In this lab we will learn how to monitor application health using OpenShift 
health probes and how you can see container resource consumption using metrics.

When building microservices, monitoring becomes of extreme importance to make sure all services 
are running at all times, and when they don't there are automatic actions triggered to rectify 
the issues. 

OpenShift, using Kubernetes health probes, offers a solution for monitoring application 
health and trying to automatically heal faulty containers through restarting them to fix issues such as
a deadlock in the application which can be resolved by restarting the container. Restarting a container 
in such a state can help to make the application more available despite bugs.

Furthermore, there are of course a category of issues that can't be resolved by restarting the container. 
In those scenarios, OpenShift would remove the faulty container from the built-in load-balancer and send traffic 
only to the healthy containers that remain.

There are two types of health probes available in OpenShift: [liveness probes and readiness probes](https://docs.openshift.com/container-platform/3.11/dev_guide/application_health.html#container-health-checks-using-probes).

*Liveness probes* are to know when to restart a container and *readiness probes* to know when a 
Container is ready to start accepting traffic.

Health probes also provide crucial benefits when automating deployments with practices like rolling updates in 
order to remove downtime during deployments. A readiness health probe would signal OpenShift when to switch 
traffic from the old version of the container to the new version so that the users don't get affected during 
deployments.

There are [three ways to define a health probe](https://docs.openshift.com/container-platform/3.11/dev_guide/application_health.html#container-health-checks-using-probes) for a container:

* **HTTP Checks:** healthiness of the container is determined based on the response code of an HTTP 
endpoint. Anything between 200 and 399 is considered success. A HTTP check is ideal for applications 
that return HTTP status codes when completely initialized.

* **Container Execution Checks:** a specified command is executed inside the container and the healthiness is 
determined based on the return value (0 is success). 

* **TCP Socket Checks:** a socket is opened on a specified port to the container and it's considered healthy 
only if the check can establish a connection. TCP socket check is ideal for applications that do not 
start listening until initialization is complete.


###  Explore Health REST Endpoints

Let's add health probes to the microservices deployed so far.
Spring Boot provides out-of-the-box support for creating RESTful endpoints that
provide details on the health of the application. These endpoints by default provide basic data about the 
service however they all provide a way to customize the health data and add more meaningful information (e.g. 
database connection health, backoffice system availability, etc).

[Spring Boot Actuator](http://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#production-ready) is a 
sub-project of Spring Boot which adds health and management HTTP endpoints to the application. Enabling Spring Boot 
Actuator is done via adding **org.springframework.boot:spring-boot-starter-actuator** dependency to the Maven project 
dependencies:

```xml
<dependencies>
	<dependency>
		<groupId>org.springframework.boot</groupId>
		<artifactId>spring-boot-starter-actuator</artifactId>
	</dependency>
</dependencies>
```

Verify that the health endpoint works for **basic-spring-boot** using `*curl*`

```bash
$ curl http://example-basic-userXY.apps.$CLUSTER_ID.openshiftworkshop.com/health

{"status":"UP","diskSpace":{"status":"UP","total":53674487808,"free":27763781632,"threshold":10485760}}
```

###  Monitoring Catalog Service Health

Health probes are defined on the deployment config for each pod and can be added using OpenShift Web 
Console or OpenShift CLI. You will try both in this lab.

Like mentioned, health probes are defined on a deployment config for each pod. Review the available 
deployment configs in the project. 

```bash
$ oc get dc

NAME               REVISION   DESIRED   CURRENT   TRIGGERED BY
spring-boot-java   1          1         1         config,image(spring-boot-java:latest)
```

TIP: **dc** is a short-hand for `deployment config`


#### Add a Liveness Probe on the Catalog Deployment Config

```bash
oc set probe dc/spring-boot-java --liveness --initial-delay-seconds=60 --failure-threshold=3 --get-url=http://:8080/health
```

TIP: OpenShift automates deployments using [deployment triggers](https://docs.openshift.com/container-platform/3.11/dev_guide/deployments/basic_deployment_operations.html#triggers) 
that react to changes to the container image or configuration. 
Therefore, as soon as you define the probe, OpenShift automatically redeploys the 
spring-boot-java pod using the new configuration including the liveness probe. 

The `*--get-url*` defines the HTTP endpoint to use for check the liveness of the container. The ***http://:8080*** 
syntax is a convenient way to define the endpoint without having to worry about the hostname for the running 
container. 

TIP: It is possible to customize the probes even further using for example `*--initial-delay-seconds*` to specify how long 
to wait after the container starts and before to begin checking the probes. Run `*oc set probe --help*` to get 
a list of all available options.

Add a `Readiness Probe on the Deployment Config` using the same **/health** endpoint that you used for 
the liveness probe.

TIP: It's recommended to have separate endpoints for readiness and liveness to indicate to OpenShift when 
to restart the container and when to leave it alone and remove it from the load-balancer so that an administrator 
would  manually investigate the issue. 

```bash
oc set probe dc/spring-boot-java --readiness --initial-delay-seconds=60 --failure-threshold=3 --get-url=http://:8080/health
```

Voilà! OpenShift automatically restarts the basic-spring-boot pod and as soon as the health probes succeed, it is ready to receive traffic. 


### Monitoring Metrics

Metrics are another important aspect of monitoring applications which is required in order to 
gain visibility into how the application behaves and particularly in identifying issues.

OpenShift provides container metrics out-of-the-box and displays how much memory, cpu and network 
each container has been consuming over time. In the project overview, you can see three charts 
near each pod that shows the resource consumption by that pod.

image:{% image_path health-metrics-brief.png %}[Container Metrics,740]

`*Click on any of the pods*` (blue circle) which takes you to the pod details. `*Click on the 'Metrics' tab*`
to see a more detailed view of the metrics charts.

image:{% image_path health-metrics-detailed.png %}[Container Metrics,900]

Well done! You are ready to move on to the next lab.
