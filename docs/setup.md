# Setup the Development Environment

### What is CodeReady Workspaces?

![CodeReady]( images/codeready.png)

[Red Hat CodeReady Workspaces](https://developers.redhat.com/products/codeready-workspaces/overview/){:target="_blank"} is a collaborative Kubernetes-native development platform that delivers OpenShift workspaces and an IDE for rapid cloud application development.

Built on the open Eclipse Che project, [Red Hat CodeReady Workspaces](https://developers.redhat.com/products/codeready-workspaces/overview/){:target="_blank"} provides developer workspaces on OpenShift with all the tools and the dependencies that are needed to code, build, test, run, and debug containerized applications. The entire product runs in the cloud and eliminates the need to install anything on a local machine.

* It offers fast onboarding capabilities for teams with powerful collaboration, workspace automation, and management at scale
* It removes inconsistencies and the “works on my machine” syndrome
* It protects source code from the hard-to-secure developer and personal laptops

### Logging in to CodeReady Workspaces

Go to [CodeReady Workspaces]( {{CODEREADY_WORKSPACES_URL}} ){:target="_blank"} then click on *'Openshift v3'* to log in through [OpenShift OAuth](https://docs.openshift.com/container-platform/3.11/architecture/additional_concepts/authentication.html#oauth){:target="_blank"}.

![CodeReady Workspaces - Log in]({% image_path codeready-oauth.png %})

Log in as `$OPENSHIFT_USER @ $OPENSHIFT_PASSWORD` and `click on 'Allow selected permissions'`

![CodeReady Workspaces - Log in]({% image_path codeready-login.png %})

![CodeReady Workspaces - Log in]({% image_path codeready-authorize-access.png %})

Finally, `enter your account information` and `click on 'Submit'`

![CodeReady Workspaces - Log in]({% image_path codeready-account-information.png %})
