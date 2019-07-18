## Lab 5 - Simple CI/CD

### Prepare the sample app

1. Import `https://github.com/redhat-capgemini-exchange/basic-spring-boot` into Gogs
2. Import `basic-spring-boot` into your CodeReady Workspace, using the Gogs repository URL
3. In `build.yaml`, change `uri:` so that it points to your Gogs repository

Commit the changes and push them to Gogs:

```bash
cd /projects/basic-spring-boot
git commit -am "updated build.yaml"
git push origin master
```

Next, Create a new project in OpenShift:

```bash
oc new-project basic-userXY
```

where `XY` is your user's number. 

Upload the build and deployment configuration:

```bash
cd /projects/basic-spring-boot
oc create -f build.yaml
oc create -f deploy.yaml
```

Once it is deployed, you can access the app at: 

http://example-basic-userXY.apps.$CLUSTER_ID.openshiftworkshop.com/example

where `XY` is your user's number and `$CLUSTER_ID` the name of the current OpenShift cluster.

## Next steps

[Lab 6 - Monitoring Application Health ](lab6.md)