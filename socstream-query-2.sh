#!/bin/bash

##
# SETUP ENVARS
##
SOCSTREAM_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

##
# FLINK COMMANDS
##
FLINK_RUN="${FLINK_HOME}/bin/flink run"

##
# SETUP
##
OUTDIR="${SOCSTREAM_HOME}/out/query-2"
mkdir -p "${OUTDIR}"
rm -f ${OUTDIR}/*

##
# SOCSTREAM
##
SOCSTREAM_JAR="${SOCSTREAM_HOME}/target/socstream-1.0-jar-with-dependencies.jar"
SOCSTREAM_QUERY="query-2"
SOCSTREAM_OPTS=""
SOCSTREAM_OPTS="${SOCSTREAM_OPTS} --kafka.zookeeper localhost:2181"
SOCSTREAM_OPTS="${SOCSTREAM_OPTS} --kafka.bootstrap localhost:9092"
SOCSTREAM_OPTS="${SOCSTREAM_OPTS} --kafka.topic socstream"
SOCSTREAM_OPTS="${SOCSTREAM_OPTS} --output ${OUTDIR}/main.out"
SOCSTREAM_OPTS="${SOCSTREAM_OPTS} --metadata ${SOCSTREAM_HOME}/data/test/metadata.yml"
SOCSTREAM_OPTS="${SOCSTREAM_OPTS} --windowSize 5"
SOCSTREAM_OPTS="${SOCSTREAM_OPTS} --windowUnit MINUTES"
SOCSTREAM_OPTS="${SOCSTREAM_OPTS} --rankSize 5"
SOCSTREAM_OPTS="${SOCSTREAM_OPTS} --parallelism 3"



##
# EXECUTION
##
${FLINK_RUN} ${SOCSTREAM_JAR} ${SOCSTREAM_QUERY} ${SOCSTREAM_OPTS}
