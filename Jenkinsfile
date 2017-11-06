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
		stage('Set compute zone and default project i Google Cloud')  {	
			steps{
				sh '~/google-cloud-sdk/bin/gcloud config set compute/zone europe-west2-b'
				sh '~/google-cloud-sdk/bin/gcloud config set project westerdals-185116'
			}
		}
		stage('docker push')  {
			steps{	
				unstash 'artifacts'
				//sh 'az acr login --name ${ACR}'
		   		sh "docker build . -t eu.gcr.io/westerdals-185116/tomcat-fagdag:t8j8-${BUILD_NUMBER}"
		   		sh "~/google-cloud-sdk/bin/gcloud docker -- push eu.gcr.io/westerdals-185116/tomcat-fagdag:t8j8-${BUILD_NUMBER}"
		   		//sh 'docker push ${ACR}.azurecr.io/tomcat-fagdag:t8j8'
			}
			
		}
		stage('Update running app'){
			steps{
			}
		}				
	}
	post {
		always{
		 	notification currentBuild.result 		
		}
	}				
}


