#!groovy

pipeline {
	agent any

	stages{
		//withEnv(["JAVA_HOME=${ tool 'OpenJDK 8 (Ubuntu package default)'}", "PATH+MAVEN=${tool 'apache-maven-3.1.0'}/bin:${env.JAVA_HOME}/bin"]){
			
	    // some block
	    		//Sjekker ut panorama for bygg på hovedslave
				stage('checkout'){
					steps{
						git branch: 'master', url: 'https://github.com/brneirik/fagdag_2017.git'
						//sh('git clean -fd')
					}
				}
				stage('mvn clean')  {
					tools{
						jdk "JDK 8"
						maven "apache-maven-3.3.9"
					}		
					steps{
				   		sh('mvn clean') 
					}
				}
				
	}			
}

