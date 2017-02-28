#!groovy

pipeline {
	agent any

	stages{
		//withEnv(["JAVA_HOME=${ tool 'OpenJDK 8 (Ubuntu package default)'}", "PATH+MAVEN=${tool 'apache-maven-3.1.0'}/bin:${env.JAVA_HOME}/bin"]){
			
	    // some block
	    		//Sjekker ut panorama for bygg på hovedslave
				stage('checkout'){
					steps{
						git branch: 'dev', url: 'https://github.com/brneirik/fagdag_2017.git'
						sh('git clean -fd')
					}
				}
				
	}			
}

