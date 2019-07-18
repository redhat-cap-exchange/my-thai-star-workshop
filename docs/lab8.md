## Lab 8 - Service Resilience and Fault Tolerance

In this lab you will learn about how you can build service resilience and fault tolerance into 
the applications both at the infrastructure level using OpenShift capabilities as well as 
at the application level using circuit breakers to prevent cascading failures when 
downstream dependencies fail.

#### Scaling Up Applications

An application's capacity for serving clients is bounded by the amount of computing power 
allocated to them and although it's possible to increase the computing power per instance, 
it's far easier to keep the application instances within reasonable sizes and 
instead add more instances to increase serving capacity. Traditionally, due to 
the stateful nature of most monolithic applications, increasing capacity had been achieved 
via scaling up the application server and the underlying virtual or physical machine by adding 
more cpu and memory (vertical scaling). Cloud-native apps however are stateless and can be 
easily scaled up by spinning up more application instances and load-balancing requests 
between those instances (horizontal scaling).

image:{% image_path fault-scale-up-vs-out.png %}[Scaling Up vs Scaling Out,500]

In previous labs, you learned how to build container images from your application code and 
deploy them on OpenShift. Container images on OpenShift follow the 
[immutable server](https://martinfowler.com/bliki/ImmutableServer.html) pattern which guarantees 
your application instances will always start from a known well-configured state and makes 
deploying instances a repeatable practice. Immutable server pattern simplifies scaling out 
application instances to starting a new instance which is guaranteed to be identical to the 
existing instances and adding it to the load-balancer.

Now, let's use the `oc scale` command to scale up the Web UI pod in the CoolStore retail 
application to 2 instances. In OpenShift, deployment config is responsible for starting the 
application pods and ensuring the specified number of instances for each application pod 
is running. Therefore the number of pods you want to scale to should be defined on the 
deployment config.

TIP: You can scale pods up and down via the OpenShift Web Console by clicking on the up and 
down arrows on the right side of each pods blue circle.

First, get list of deployment configs available in the project.

```bash
oc project basic-userXY
oc get dc

NAME               REVISION   DESIRED   CURRENT   TRIGGERED BY
spring-boot-java   17         1         1         config,image(spring-boot-java:latest)

```

And then, scale the `spring-boot-java` deployment config to 2 pods:

```bash
oc scale dc/spring-boot-java --replicas=2
```

The `--replicas` option specified the number of pods that should be running. If you look 
at the OpenShift Web Console, you can see a new pod is being started for the Web UI and as soon 
as the health probes pass, it will be automatically added to the load-balancer.

image:{% image_path fault-scale-up.png %}[Scaling Up Pods,740]

You can verify that the new pod is added to the load balancer by checking the details of the 
Web UI service object:

```bash
oc describe svc/spring-boot-java

...
Endpoints:         10.1.2.102:8080,10.1.4.51:8080
...
```

*_Endpoints_* shows the IPs of the 2 pods that the load-balancer is sending traffic to.


#### Scaling Applications on Auto-pilot

Although scaling up and scaling down pods are automated and easy using OpenShift, however it still 
requires a person or a system to run a command or invoke an API call (to OpenShift REST API. Yup! there
is a REST API for all OpenShift operations) to scale the applications. That in turn needs to be in response 
to some sort of increase to the application load and therefore the person or the system needs to be aware of 
how much load the application is handling at all times to make the scaling decision.

OpenShift automates this aspect of scaling as well via automatically scaling the application pods up 
and down within a specified min and max boundary based on the container metrics such as cpu and memory 
consumption. In that case, if there is a surge of users visiting the CoolStore online shop due to 
holiday season coming up or a good deal on a product, OpenShift would automatically add more pods to 
handle the increased load on the application and after the load goes back down, the application is automatically scaled down to free up compute resources.

In order to define auto-scaling for a pod, we should first define how much cpu and memory a pod is 
allowed to consume which will act as a guideline for OpenShift to know when to scale the pod up or 
down. Since the deployment config is used when starting the application pods, the application pod resource 
(cpu and memory) containers should also be defined on the deployment config.

When allocating compute resources to application pods, each container may specify a *request*
and a *limit* value each for CPU and memory. The 
[request](https://docs.openshift.com/container-platform/3.11/dev_guide/compute_resources.html#dev-memory-requests)
values define how much resource should be dedicated to an application pod so that it can run. It's 
the minimum resources needed in other words. The 
[limit](https://docs.openshift.com/container-platform/3.11/dev_guide/compute_resources.html#dev-memory-limits) values 
defines how much resource an application pod is allowed to consume, if there is more resources 
on the node available than what the pod has requested. This is to allow various quality of service 
tiers with regards to compute resources. You can read more about these quality of service tiers 
in [OpenShift Documentation](https://docs.openshift.com/container-platform/3.11/dev_guide/compute_resources.html#quality-of-service-tiers).

Set the following resource constraints on the spring-boot-java pod:

* Memory Request: 128 Mi
* Memory Limit: 200 Mi
* CPU Request: 100 millicore
* CPU Limit: 250 millicore

TIP: CPU is measured in units called millicores. Each node in a cluster inspects the 
operating system to determine the amount of CPU cores on the node, then multiplies 
that value by 1000 to express its total capacity. For example, if a node has 2 cores, 
the node’s CPU capacity would be represented as 2000m. If you wanted to use 1/10 of 
a single core, it would be represented as 100m. Memory is measured in 
bytes and is specified with [SI suffices](https://docs.openshift.com/container-platform/3.11/dev_guide/compute_resources.html#dev-compute-resources) 
(E, P, T, G, M, K) or their power-of-two-equivalents (Ei, Pi, Ti, Gi, Mi, Ki).

```bash
oc set resources dc/spring-boot-java --limits=cpu=250m,memory=200Mi --requests=cpu=100m,memory=128Mi
```

```bash
oc autoscale dc/spring-boot-java --min 1 --max 5 --cpu-percent=40
```

All set! Now the Web UI can scale automatically to multiple instances if the load on the CoolStore 
online store increases. You can verify that using for example the `siege` command-line utility, which 
is a handy tool for running load tests against web endpoints and is already 
installed within your CodeReady Workspaces workspace. 

Run the following command in the **Terminal** window.

```bash
siege -c80 -d2 -t5M siege -c80 -d2 -t5M http://example-basic-user1.apps.devonfw2-a868.openshiftworkshop.com/load
```

As the load is generated, you will notice that it will create a spike in the 
Web UI cpu usage and trigger the autoscaler to scale the Web UI container to 5 pods (as configured 
on the deployment config) to cope with the load.

TIP: Depending on the resources available on the OpenShift cluster in the lab environment, 
the Web UI might scale to fewer than 5 pods to handle the extra load. Run the command again 
to generate more load.

You can see the aggregated cpu metrics graph of all 5 Web UI pods by going to the OpenShift Web Console and clicking on 
**Monitoring** and then the arrow (**>**) on the left side of **web-n** under **Deployments**.

When the load on Web UI disappears, after a while OpenShift scales the Web UI pods down to the minimum 
or whatever this needed to cope with the load at that point.

#### Self-healing Failed Application Pods

We looked at how to build more resilience into the applications through scaling in the 
previous sections. In this section, you will learn how to recover application pods when 
failures happen. In fact, you don't need to do anything because OpenShift automatically 
recovers failed pods when pods are not feeling healthy. The healthiness of application pods is determined via the 
[health probes](https://docs.openshift.com/container-platform/3.11/dev_guide/application_health.html#container-health-checks-using-probes) 
which was discussed in the previous labs.

There are three auto-healing scenarios that OpenShift handles automatically:

##### Application Pod Temporary Failure
When an application pod fails and does not pass its 
[liveness health probe](https://docs.openshift.com/container-platform/3.11/dev_guide/application_health.html#container-health-checks-using-probes),  
OpenShift restarts the pod in order to give the application a chance to recover and start functioning 
again. Issues such as deadlocks, memory leaks, network disturbance and more are all examples of issues 
that can most likely be resolved by restarting the application despite the potential bug remaining in the 
application.

##### Application Pod Permanent Failure
When an application pod fails and does not pass its 
[readiness health probe](https://docs.openshift.com/container-platform/3.11/dev_guide/application_health.html#container-health-checks-using-probes), 
it signals that the failure is more severe and restart is unlikely to help to mitigate the issue. OpenShift then 
removes the application pod from the load-balancer to prevent sending traffic to it.

##### Application Pod Removal
If an instance of the application pods gets removed, OpenShift automatically 
starts new identical application pods based on the same container image and configuration so that the 
specified number of instances are running at all times.