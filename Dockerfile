FROM tomcat:8.0-jre8

RUN sed -i s/8080/80/g conf/server.xml
RUN rm -rf webapps/ROOT

ADD target/fagdag.war /usr/local/tomcat/webapps/ROOT.war
#RUN apt-get update
#RUN apt-get -y install tomcat8
EXPOSE 80
CMD ["/usr/share/tomcat8/bin/catalina.sh", "run"]