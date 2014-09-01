#!/bin/bash

#takes the latest snapshot of the Ambari shell
export JAR_PATH=ambari-shell.jar
curl -Ls https://raw.githubusercontent.com/sequenceiq/ambari-shell/master/latest-snap.sh | bash

#supported blueprints: hdp-multinode-default, hdp-singlenode-default, lambda-architecture, multi-node-hdfs-yarn, single-node-hdfs-yarn
: ${AMBARI_HOST:=192.168.38.10}
: ${BLUEPRINT:=multi-node-hdfs-yarn}

#uses Ambari shell to provision a Hadoop cluster based on the blueprint
java -jar ambari-shell.jar --ambari.host=$AMBARI_HOST << EOF
blueprint defaults
cluster build --blueprint $BLUEPRINT
cluster autoAssign
cluster create --exitOnFinish true
EOF
