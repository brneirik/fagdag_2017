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
				sh 'az acr login --name ${ACR}'
		   		sh 'docker push ${ACR}.azurecr.io/tomcat-fagdag:t8j8'
			}
			
		}
	
		stage('Create k8s cluster')  {	
			steps{
				
			}
		}
		stage('Create deployment')  {	
			steps{
			
			}
		}
		stage('Expose deployment and display ip-address')  {	
			steps{
			}
		}
		stage('Scale app')  {	
			steps{
			}
		}
		stage('Delete cluster')  {	
			steps{			}
		}
				
	}
	post {
		always{
		 	notification currentBuild.result 		
		}
	}				
}


