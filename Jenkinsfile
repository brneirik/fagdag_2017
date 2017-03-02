#!groovy
node {
	String jdktool = tool name: "JDK 8", type: 'hudson.model.JDK'
	def mvnHome = tool name: 'apache-maven-3.3.9'

	List javaEnv = [
        "PATH+MVN=${jdktool}/bin:${mvnHome}/bin",
        "M2_HOME=${mvnHome}",
        "JAVA_HOME=${jdktool}"
	]
	withEnv(javaEnv) {
		checkout scm
		stage ('Build') {
		 	try {
		 		sh 'mvn clean install'
		 	} catch (e) {
		 		currentBuild.result = 'FAILURE'
		 	}
		}
	}
}

