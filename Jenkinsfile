#!groovy
@Library('fagdagjenkins-shared') _

pipeline {
	agent any

	stages{

		stage('mvn install')  {
			agent{
				docker { image 'maven:3.5.0-jdk-9' }
			}
			tools{
				jdk "JDK 8"
				maven "apache-maven-3.3.9"
			}		
			steps{
		   		sh('mvn clean install') 
			}
			post{
				publishHTML(target: [allowMissing: true, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '**/build/reports/profile/', reportFiles: '', reportName: 'HTML Report'])
		   		archiveArtifacts 'target/*.war'
				stash includes: 'target/fagdag.war', name: 'artifacts'
			}
		}
				
	}
	post {
		always{
		 	notification currentBuild.result 		
		}
	}				
}

