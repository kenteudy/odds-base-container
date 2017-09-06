FROM centos:7
MAINTAINER keudy@vizuri.com

#
# Docker base image for FHIR OpenShift Deployment
#


ENV APP_ROOT=/opt/app-root

COPY jolokia.jar ${APP_ROOT}/jolokia.jar
COPY run.sh ${APP_ROOT}/run.sh

RUN  INSTALL_PKGS="java-1.8.0-openjdk-devel"  \
     && yum install -y --enablerepo=centosplus $INSTALL_PKGS \
     && rpm -V $INSTALL_PKGS \
     && yum clean all -y \
     && chown -R 1001:0 ${APP_ROOT}

USER 1001
WORKDIR ${APP_ROOT}

ENV JAVA_OPTS=""
ENV APP_JAR="app.jar"
ENV SPRING_PROFILES_ACTIVE=openshift

CMD ${APP_ROOT}/run.sh ${APP_ROOT}/$APP_JAR
