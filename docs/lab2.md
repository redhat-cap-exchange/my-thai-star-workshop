## Lab 2 - Anatomy of a S2I build

### Build: Add missing variables

1. Navigate to the build configuration: Project 'userXY' - Builds - Builds - my-thai-star - Environment
2. Add the following ENV variables:

  - MAVEN_MIRROR_URL: http://nexus.roadtocloudnative.svc:8081/repository/maven-public/
  - MAVEN_S2I_ARTIFACT_DIRS: server/target
  - S2I_SOURCE_DEPLOYMENTS_FILTER: *.war

### Deployment: Add missing variables

1. Navigate to the build configuration: Project 'userXY' - Applications - Deployments - my-thai-star - Environment
2. Add the following ENV variables:

  - JAVA_APP_JAR: mythaistar-bootified.war

Re-start the build process.

