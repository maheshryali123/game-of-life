FROM ubuntu:22.04 
RUN apt update
RUN apt install openjdk-8-jdk -y
RUN mkdir /opt/tomcat
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.75/src/apache-tomcat-9.0.75-src.tar.gz /opt/tomcat
WORKDIR /opt/tomcat
RUN tar xvzf apache-tomcat-9.0.75-src.tar.gz
COPY ./gameoflife-web/target/gameoflife.war /opt/tomcat/gameoflife.war
RUN cp /opt/tomcat/gameoflife.war /opt/tomcat/apache-tomcat-9.0.75-src/webapps/gameoflife.war
EXPOSE 8080
CMD [ "/opt/tomcat/apache-tomcat-9.0.75-src/bin/catalina.sh", "run" ]
