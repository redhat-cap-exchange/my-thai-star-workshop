## Lab 4 - Customizing the S2I build process

OpenShift Container Platform provides [S2I](https://docs.openshift.com/container-platform/3.11/architecture/core_concepts/builds_and_image_streams.html#source-build) enabled Node.js images for building and running Node.js applications. The Node.js S2I builder image assembles your application source with any required dependencies to create a new image containing your Node.js application. 

### Explore the Node.js S2I on GitHub

The source of the Node.js S2I Image is available on GitHub: [sclorg/s2i-nodejs-container](https://github.com/sclorg/s2i-nodejs-container)

### Build process

S2I produces ready-to-run images by injecting source code into a container and letting the container prepare that source code for execution. It performs the following steps:

1. Starts a container from the builder image.
2. Downloads the application source.
3. Streams the scripts and application sources into the builder image container.
4. Runs the assemble script (from the builder image).
5. Saves the final image.

### Customizing S2I Images

S2I builder images normally include *assemble* and *run* scripts, but the default behavior of those scripts may not be suitable for all users.

Typically, builder images provide their own version of the S2I scripts that cover the most common use-cases. If these scripts do not fulfill your needs, S2I provides a way of overriding them by adding custom ones in the *.s2i/bin* directory. However, by doing this you are completely replacing the standard scripts. In some cases this is acceptable, but in other scenarios you may prefer to execute a few commands before (or after) the scripts while retaining the logic of the script provided in the image. In this case, it is possible to create a wrapper script that executes custom logic and delegates further work to the default script in the image.

### Add custom scripts

1. Copy `my-thai-star-workshop/snippets/.s2i` to `my-thai-star/angular`
2. Add new files to git, commit and push changes in `my-thai-star`

```bash
cd /projects/my-thai-star

git add -A angular/.s2i
git commit -am "added custom s2i scripts"
git push origin develop

```

When promted by git, log in as `$OPENSHIFT_USER @ $OPENSHIFT_PASSWORD`

### Build and deploy the front-end

1. Change `$API_ENDPOINT` in `my-thai-star-workshop/templates/build-mythaistar-angular.yaml`
2. Upload `my-thai-star-workshop/templates/build-mythaistar-angular.yaml`
3. Upload `my-thai-star-workshop/templates/deploy-mythaistar-angular.yaml`

```bash
cd /projects/my-thai-star-workshop

oc create -f templates/build-mythaistar-angular.yaml
oc create -f templates/deploy-mythaistar-angular.yaml

```

**SHOW THE RUNNING APP !**

