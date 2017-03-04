#!groovy
@Library('fagdagjenkins-shared') _
node('slave') {
	String jdktool = tool name: "JDK 8", type: 'hudson.model.JDK'
	def mvnHome = tool name: 'apache-maven-3.3.9'

	List javaEnv = [
        "PATH+MVN=${jdktool}/bin:${mvnHome}/bin",
        "M2_HOME=${mvnHome}",
        "JAVA_HOME=${jdktool}"
	]
	withEnv(javaEnv) {
		try {
			checkout scm
			stage ('Build') {
		 		sh 'mvn clean install'
		 		sh 'exit 1'
			}
		} catch (e) {
		 		currentBuild.result = 'FAILURE'
		 } finally {
		 	notification currentBuild.result 
		 }
	}
	
}

