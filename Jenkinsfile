#!groovy
@Library('fagdagjenkins-shared') _

pipeline {
	agent any

	stages{

		stage('mvn install')  {
			agent{
				docker { image 'maven:3.5.0-jdk-8' }
			}	
			steps{
		   		sh('mvn clean install') 
		   		stash includes: 'target/fagdag.war', name: 'artifacts'
			}
			post{
				success{
					publishHTML(target: [allowMissing: true, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '**/build/reports/profile/', reportFiles: '', reportName: 'HTML Report'])
			   		archiveArtifacts 'target/*.war'
					stash includes: 'target/fagdag.war', name: 'artifacts'
				}
			}
		}
		stage('docker push')  {
			agent{
				label 'slave1'
			}
			steps{	
				unstash 'artifacts'
				sh 'az acr login --name ${ACR}'
		   		sh 'docker build . -t ${ACR}.azurecr.io/tomcat-fagdag:t8j8'
		   		sh 'docker push ${ACR}.azurecr.io/tomcat-fagdag:t8j8'
			}
			
		}
				
	}
	post {
		always{
		 	notification currentBuild.result 		
		}
	}				
}

