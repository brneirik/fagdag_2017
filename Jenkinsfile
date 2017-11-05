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
		   		sh 'docker build . -t eu.gcr.io/westerdals-185116/tomcat-fagdag:t8j8-1'
		   		sh '~/google-cloud-sdk/bin/gcloud docker -- push eu.gcr.io/westerdals-185116/tomcat-fagdag:t8j8-1'
		   		//sh 'docker push ${ACR}.azurecr.io/tomcat-fagdag:t8j8'
			}
			
		}
	
		stage('Create k8s cluster')  {	
			steps{
				sh '~/google-cloud-sdk/bin/gcloud container clusters create westerdals-k8s2-cluster'
			}
		}
		stage('Create deployment')  {	
			steps{
				sh '~/kubectl run hello-web --image=eu.gcr.io/westerdals-185116/tomcat-fagdag:t8j8-1 --port=8080'
			}
		}
		stage('Expose deployment and display ip-address')  {	
			steps{
				sh '''~/kubectl expose deployment hello-web --type="LoadBalancer"'''
				sh '~/kubectl get service hello-web'
				sleep 90
				sh '~/kubectl get service hello-web'
			}
		}
		stage('Scale app')  {	
			steps{
				input 'Proceed with scaling'
				sh '~/kubectl scale --replicas=3 deployment/hello-web'
				sh '~/kubectl get deployments'
			}
		}
		stage('Delete cluster')  {	
			steps{
				input 'Delete cluster?'
				sh '~/kubectl delete service hello-web'
				sh '~/kubectl delete deployment hello-web'
				sh '~/google-cloud-sdk/bin/gcloud container clusters delete --quiet westerdals-k8s2-cluster'
			}
		}
				
	}
	post {
		always{
		 	notification currentBuild.result 		
		}
	}				
}


