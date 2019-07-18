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


### Webhook Triggers

Webhook triggers allow you to trigger a new build by sending a request to the OpenShift Container Platform API endpoint. You can define these triggers using GitHub, GitLab, Bitbucket, or Generic webhooks.

OpenShift Container Platform webhooks currently only support their analogous versions of the push event for each of the Git based source code management systems (SCMs). All other event types are ignored.

#### Add a simple Webhook

1. In the OpenShift Web UI, navigate to `Builds - spring-boo-java - Configuration`
2. Copy link `Generic Webhook URL`
3. In Gogs, navigate to `basic-spring-boot - Settings - Webhooks`
4. Click `Add Webhook` and then select `Gogs` as the type of Webhook
5. Paste the previously copied `Generic Wbhook URL` into `Payload URL`
6. Click `Add Webhook`

Now anytime you push code to your repository, it will trigger a re-build and re-deploy in OpenShift.

## Next steps

[Lab 6 - Monitoring Application Health ](lab6.md)