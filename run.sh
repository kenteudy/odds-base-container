#!/bin/sh

java -javaagent:${APP_ROOT}/jolokia.jar=port=8778,protocol=https,caCert=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt,clientPrincipal=cn=system:master-proxy,useSslClientAuthentication=true,extraClientCheck=true,host=0.0.0.0,discoveryEnabled=false -Dspring.profiles.active=${SPRING_PROFILES_ACTIVE} $JAVA_OPTS -jar $1
