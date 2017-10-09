FROM tomcat:8.0-jre8
RUN value=`cat conf/server.xml` && echo "${value//8080/80}" >| conf/server.xml
ADD target/fagdag.war /var/lib/tomcat8/webapps/