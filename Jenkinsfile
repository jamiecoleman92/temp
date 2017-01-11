#!groovy
// Build and test a Maven project
// See https://github.com/jenkinsci/pipeline-plugin/blob/master/TUTORIAL.md for pipeline syntax etc

node('master') {

  // A collection of build utils.
  // See https://github.com/jenkinsci/workflow-remote-loader-plugin
  // The github-oauth-userpass refers to the Jenkins credentials object. 
  def utils = fileLoader.fromGit('script/buildUtils', 'https://github.ibm.com/liber8/pipeline.git',
    'master', 'github-oauth-userpass', 'master')

  stage ('Extract') {
    checkout scm
  }

  stage ('Build') {
    utils.mavenBuild ('clean', 'package')
    sh "docker build -t front-end:$BUILD_ID ."
  }

  // TODO: No tests currently defined for this service
  // stage ('Test') {
  //   utils.mavenVerify()
  //}

  // TODO: Re-add push once we have a registry available as part of the pipeline
  /* stage ('Push') {
+   withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'github-oauth-userpass',
+                            usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {                                                                
+        sh '''
+    docker login wasliberty-liber8-docker.artifactory.swg-devops.com -u $USERNAME -p $PASSWORD
+    '''
+   }
    sh "docker tag front-end:$BUILD_ID wasliberty-liber8-docker.artifactory.swg-devops.com/front-end:$BUILD_ID"
    sh "docker push wasliberty-liber8-docker.artifactory.swg-devops.com/front-end:$BUILD_ID"
  }*/

  stage ('Deploy') {
    utils.deploy ('a8.props', 'front-end')
  }

}
