FROM centos:centos7
MAINTAINER keudy@vizuri.com

# Install prepare infrastructure
RUN yum -y update && \
 yum -y install wget && \
 yum -y install java-1.8.0-openjdk-devel && \
 yum -y install tar

# Prepare environment 
#ENV JAVA_HOME /opt/java
ENV CATALINA_HOME /opt/tomcat 
#ENV PATH $PATH:$JAVA_HOME/bin:$CATALINA_HOME/bin:$CATALINA_HOME/scripts
ENV PATH $PATH:$CATALINA_HOME/bin:$CATALINA_HOME/scripts

# Install Oracle Java8
ENV JAVA_VERSION 8u131
ENV JAVA_BUILD 8u121-b11
ENV JAVA_DL_HASH d54c1d3a095b4ff2b6607d096fa80163
ENV CATALINA_OPTS=-Dspring.profiles.active=openshift

ENV TOMCAT_MAJOR 8
ENV TOMCAT_VERSION 8.5.20

# https://issues.apache.org/jira/browse/INFRA-8753?focusedCommentId=14735394#comment-14735394
ENV TOMCAT_TGZ_URL https://www.apache.org/dyn/closer.cgi?action=download&filename=tomcat/tomcat-$TOMCAT_MAJOR/v$TOMCAT_VERSION/bin/apache-tomcat-$TOMCAT_VERSION.tar.gz




RUN wget -O tomcat.tar.gz "$TOMCAT_TGZ_URL"  && \
 tar -xvf tomcat.tar.gz && \
 rm tomcat*.tar.gz && \
 mv apache-tomcat* ${CATALINA_HOME}



# Create tomcat user
#RUN groupadd -r tomcat && \
#useradd -g tomcat -d ${CATALINA_HOME} -s /sbin/nologin  -c "Tomcat user" tomcat && \
RUN rm -fr ${CATALINA_HOME}/webapps/ROOT && \
    chmod -R ug+rwx ${CATALINA_HOME} && \
    chown -R 1001:0 ${CATALINA_HOME} && \
    chmod +x ${CATALINA_HOME}/bin/*sh

WORKDIR /opt/tomcat

EXPOSE 8080
EXPOSE 8009

USER 1001
CMD ["catalina.sh", "run"]
