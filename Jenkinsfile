#!groovy

pipeline {
	agent any

	stages{
		//withEnv(["JAVA_HOME=${ tool 'OpenJDK 8 (Ubuntu package default)'}", "PATH+MAVEN=${tool 'apache-maven-3.1.0'}/bin:${env.JAVA_HOME}/bin"]){
			
	    // some block
	    		//Sjekker ut panorama for bygg på hovedslave
				stage('mvn clean')  {
					agent{
						label 'slave'
				}
					tools{
						jdk "JDK 8"
						maven "apache-maven-3.3.9"
					}		
					steps{
				   		sh('mvn clean') 
					}
				}
				stage('mvn install')  {
					agent{
						label 'slave'
					}
					tools{
						jdk "JDK 8"
						maven "apache-maven-3.3.9"
					}		
					steps{
				   		sh('mvn install') 
					}
				}
				stage('post build')  {
					agent{
						label 'slave'
					}
					tools{
						jdk "JDK 8"
						maven "apache-maven-3.3.9"
					}		
					steps{
				   		publishHTML(target: [allowMissing: true, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '**/build/reports/profile/', reportFiles: '', reportName: 'HTML Report'])
				   		archiveArtifacts 'target/*.war'
				   		sh 'ls'
					}
				}
			
				
	}			
}

