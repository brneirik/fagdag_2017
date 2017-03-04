#!groovy
@Library('fagdagjenkins-shared') _

pipeline {
	agent any

	stages{

		stage('build')  {
			agent{
				label 'slave'
			}
			tools{
				jdk "JDK 8"
				maven "apache-maven-3.3.9"
			}		
			steps{
		   		sh('mvn clean install') 
			}
		}		
	}
	post {
		 	notification currentBuild.result 		
	}			
}

