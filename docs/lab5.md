## Lab 5 - Simple CI/CD

### Prepare the sample app

1. Import `[basic-spring-boot](https://github.com/redhat-capgemini-exchange/basic-spring-boot)` into Gogs
2. Import `basic-spring-boot` into your CodeReady Workspace
3. In `build.yaml` change the `uri:` so that it points to your Gogs repository

Commit the changes and push to Gogs:

```bash
cd /projects/basic-spring-boot
git commit -am "updated build.yaml"
git push origin master
```

Create a new project in OpenShift first:

```bash
oc new-project basic-userXY
```

Now upload the build and deployment configuration:

```bash
cd /projects/basic-spring-boot
oc create -f build.yaml
oc create -f deploy.yaml
```

Once it is deployed, you can access the app at: 

http://example-basic-userXY.apps.$CLUSTER_ID.openshiftworkshop.com/example
 
## Next steps

[Lab 6 - Monitoring Application Health ](lab6.md)