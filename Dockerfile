FROM tomcat:8.0-jre8
RUN value=`cat usr/local/conf/server.xml` && echo "${value//8080/80}" >| usr/local/conf/server.xml
ADD target/fagdag.war /usr/local/webapps/