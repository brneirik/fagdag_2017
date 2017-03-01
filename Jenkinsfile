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
						stash includes: 'target/fagdag.war', name: 'artifacts'
				   		//step([$class: 'CopyArtifact', filter: 'target/fagdag.war', fingerprintArtifacts: true, flatten: true, projectName: 'WorldDomintation.js', selector: [$class: 'SpecificBuildSelector', buildNumber: '${BUILD_NUMBER}'], target: '/data/artifacts/'])

					}

				}
				stage('deploy')  {	
					steps{
						unstash 'artifacts'
				   		sh('cp target/fagdag.war /opt/tomcat/webapps/')
					}

				}
				stage('Test'){
					steps{
						parallel(
							"Smoketest" : {
								sh (''' 
								#!/bin/bash
								res="$(curl -o /dev/null --silent --head --write-out '%{http_code}\n' http://fagdagsjenkins.northeurope.cloudapp.azure.com:8081/fagdag/)"
								if [ "$res" = "200" ]; then
		  							echo "200 OK"
		  							exit 0
								else
		  							echo "Returned status $res"
		  							exit 1
								fi
								''')
							},
							"Akseptansetest" : {
								sleep 10
							},
							failFast: true
						)
					}
				}
				stage('Publish'){
					steps{
						unstash 'artifacts'
						sh ('mv target/fagdag.war /data/artifacts/fagdag-${BUILD_NUMBER}.war')
					}
				}
			
				
	}			
}

