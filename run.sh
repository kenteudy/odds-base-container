#!/bin/sh
export USER_ID=$(id -u)
export GROUP_ID=$(id -g)
envsubst < ${APP_ROOT}/etc/passwd.template > ${APP_ROOT}/etc/passwd

#if ! whoami &> /dev/null; then
#  if [ -w /etc/passwd ]; then
#    echo "${USER_NAME:-default}:x:$(id -u):0:${USER_NAME:-default} user:${HOME}:/sbin/nologin" >> /etc/passwd
#  fi
#fi

java -javaagent:/home/jboss/jolokia.jar=port=8778,protocol=https,caCert=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt,clientPrincipal=cn=system:master-proxy,useSslClientAuthentication=true,extraClientCheck=true,host=0.0.0.0,discoveryEnabled=false -Dspring.profiles.active=${SPRING_PROFILES_ACTIVE} $JAVA_OPTS -jar $1
