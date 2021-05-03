FROM openjdk:8-slim
LABEL maintainer="kenjiria"
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
    apt-get install -y wget --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ENV HADOOP_HOME="/opt/hadoop"
ENV LISTENER_PATH="/opt/atlas/hook/hive"
ENV METASTORE_HOME="/opt/hive-metastore"
ENV CLASSPATH="${METASTORE_HOME}/lib/"
ENV ATLAS_LISTENER_VERSION="0.1.1"

# Download and install jar packages to Hive Backfill script
RUN mkdir -p /opt/atlas/hook/hive/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/commons-cli/commons-cli/1.4/commons-cli-1.4.jar > commons-cli-1.4.jar && mv commons-cli-1.4.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/slf4j/slf4j-api/1.7.30/slf4j-api-1.7.30.jar > slf4j-api-1.7.30.jar && mv slf4j-api-1.7.30.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/slf4j/slf4j-simple/1.7.30/slf4j-simple-1.7.30.jar > slf4j-simple-1.7.30.jar && mv slf4j-simple-1.7.30.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/commons-logging/commons-logging/1.2/commons-logging-1.2.jar > commons-logging-1.2.jar && mv commons-logging-1.2.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/com/sun/jersey/jersey-client/1.9.1/jersey-client-1.9.1.jar > jersey-client-1.9.1.jar && mv jersey-client-1.9.1.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/com/sun/jersey/jersey-core/1.13-b01/jersey-core-1.13-b01.jar > jersey-core-1.13-b01.jar && mv jersey-core-1.13-b01.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/com/fasterxml/jackson/jaxrs/jackson-jaxrs-json-provider/2.9.9/jackson-jaxrs-json-provider-2.9.9.jar > jackson-jaxrs-json-provider-2.9.9.jar && mv jackson-jaxrs-json-provider-2.9.9.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/com/fasterxml/jackson/jaxrs/jackson-jaxrs-base/2.9.9/jackson-jaxrs-base-2.9.9.jar > jackson-jaxrs-base-2.9.9.jar && mv jackson-jaxrs-base-2.9.9.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-auth/3.3.0/hadoop-auth-3.3.0.jar > hadoop-auth-3.3.0.jar && mv hadoop-auth-3.3.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.2.0/hadoop-common-3.2.0.jar > hadoop-common-3.2.0.jar && mv hadoop-common-3.2.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://search.maven.org/remotecontent?filepath=commons-collections/commons-collections/3.2.2/commons-collections-3.2.2.jar > commons-collections-3.2.2.jar && mv commons-collections-3.2.2.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-mapred/0.22.0/hadoop-mapred-0.22.0.jar > hadoop-mapred-0.22.0.jar && mv hadoop-mapred-0.22.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/log4j/log4j/1.2.17/log4j-1.2.17.jar > log4j-1.2.17.jar && mv log4j-1.2.17.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/calcite/calcite-core/1.26.0/calcite-core-1.26.0.jar > calcite-core-1.26.0.jar && mv calcite-core-1.26.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/commons-codec/commons-codec/1.9/commons-codec-1.9.jar > commons-codec-1.9.jar && mv commons-codec-1.9.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/thrift/libfb303/0.8.0/libfb303-0.8.0.jar > libfb303-0.8.0.jar && mv libfb303-0.8.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/com/codahale/metrics/metrics-core/3.0.2/metrics-core-3.0.2.jar > metrics-core-3.0.2.jar && mv metrics-core-3.0.2.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/datanucleus/datanucleus-core/4.1.17/datanucleus-core-4.1.17.jar > datanucleus-core-4.1.17.jar && mv datanucleus-core-4.1.17.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/datanucleus/datanucleus-api-jdo/4.1.4/datanucleus-api-jdo-4.1.4.jar > datanucleus-api-jdo-4.1.4.jar && mv datanucleus-api-jdo-4.1.4.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/datanucleus/datanucleus-rdbms/4.1.17/datanucleus-rdbms-4.1.17.jar > datanucleus-rdbms-4.1.17.jar && mv datanucleus-rdbms-4.1.17.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/com/zaxxer/HikariCP/2.6.1/HikariCP-2.6.1.jar > HikariCP-2.6.1.jar && mv HikariCP-2.6.1.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/derby/derby/10.10.2.0/derby-10.10.2.0.jar > derby-10.10.2.0.jar && mv derby-10.10.2.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/antlr/antlr-runtime/3.5.2/antlr-runtime-3.5.2.jar > antlr-runtime-3.5.2.jar && mv antlr-runtime-3.5.2.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-hdfs-client/3.2.0/hadoop-hdfs-client-3.2.0.jar > hadoop-hdfs-client-3.2.0.jar && mv hadoop-hdfs-client-3.2.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-hdfs/3.2.0/hadoop-hdfs-3.2.0.jar > hadoop-hdfs-3.2.0.jar && mv hadoop-hdfs-3.2.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/codehaus/woodstox/stax2-api/3.0.1/stax2-api-3.0.1.jar > stax2-api-3.0.1.jar && mv stax2-api-3.0.1.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/com/fasterxml/woodstox/woodstox-core/5.0.3/woodstox-core-5.0.3.jar > woodstox-core-5.0.3.jar && mv woodstox-core-5.0.3.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/commons/commons-configuration2/2.3/commons-configuration2-2.3.jar > commons-configuration2-2.3.jar && mv commons-configuration2-2.3.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/com/fasterxml/jackson/module/jackson-module-jaxb-annotations/2.9.9/jackson-module-jaxb-annotations-2.9.9.jar > jackson-module-jaxb-annotations-2.9.9.jar && mv jackson-module-jaxb-annotations-2.9.9.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/hive/hcatalog/hive-hcatalog-core/3.1.2/hive-hcatalog-core-3.1.2.jar > hive-hcatalog-core-3.1.2.jar && mv hive-hcatalog-core-3.1.2.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/atlas/atlas-notification/2.1.0/atlas-notification-2.1.0.jar > atlas-notification-2.1.0.jar && mv atlas-notification-2.1.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/atlas/atlas-client-common/2.1.0/atlas-client-common-2.1.0.jar > atlas-client-common-2.1.0.jar && mv atlas-client-common-2.1.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/atlas/atlas-client-v1/2.1.0/atlas-client-v1-2.1.0.jar > atlas-client-v1-2.1.0.jar && mv atlas-client-v1-2.1.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/atlas/atlas-client-v2/2.1.0/atlas-client-v2-2.1.0.jar > atlas-client-v2-2.1.0.jar && mv atlas-client-v2-2.1.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/atlas/atlas-common/2.1.0/atlas-common-2.1.0.jar > atlas-common-2.1.0.jar && mv atlas-common-2.1.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/atlas/atlas-intg/2.1.0/atlas-intg-2.1.0.jar > atlas-intg-2.1.0.jar && mv atlas-intg-2.1.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/commons-configuration/commons-configuration/1.10/commons-configuration-1.10.jar > commons-configuration-1.10.jar && mv commons-configuration-1.10.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/com/sun/jersey/contribs/jersey-multipart/1.19/jersey-multipart-1.19.jar > jersey-multipart-1.19.jar && mv jersey-multipart-1.19.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-core/2.10.1/jackson-core-2.10.1.jar > jackson-core-2.10.1.jar && mv jackson-core-2.10.1.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/kafka/kafka-clients/2.0.0/kafka-clients-2.0.0.jar > kafka-clients-2.0.0.jar && mv kafka-clients-2.0.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/org/apache/kafka/kafka_2.11/2.0.0/kafka_2.11-2.0.0.jar > kafka_2.11-2.0.0.jar && mv kafka_2.11-2.0.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-annotations/2.9.9/jackson-annotations-2.9.9.jar > jackson-annotations-2.9.9.jar && mv jackson-annotations-2.9.9.jar ${LISTENER_PATH}/atlas-hive-plugin-impl && \
    wget -qO- https://repo1.maven.org/maven2/com/fasterxml/jackson/core/jackson-databind/2.10.0/jackson-databind-2.10.0.jar > jackson-databind-2.10.0.jar && mv jackson-databind-2.10.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl

# Download hive-bridge to run Backfill
RUN wget -qO- https://repo1.maven.org/maven2/org/apache/atlas/hive-bridge/2.1.0/hive-bridge-2.1.0.jar > hive-bridge-2.1.0.jar && mv hive-bridge-2.1.0.jar ${LISTENER_PATH}/atlas-hive-plugin-impl

# Download and install personalized Atlas Listener
RUN wget -qO- \
    https://nexus.quintoandar.com.br/repository/5a-maven-github-packages/br/com/quintoandar/atlas-hive-metastore-listener/${ATLAS_LISTENER_VERSION}/atlas-hive-metastore-listener-${ATLAS_LISTENER_VERSION}.jar > atlas-hive-metastore-listener-${ATLAS_LISTENER_VERSION}.jar && \
    mv atlas-hive-metastore-listener-${ATLAS_LISTENER_VERSION}.jar ${LISTENER_PATH}/atlas-hive-plugin-impl

# Add jars to the Hive Metastore classpath
RUN mkdir -p ${METASTORE_HOME}/lib/ && \
    cp -r ${LISTENER_PATH}/atlas-hive-plugin-impl/* ${METASTORE_HOME}/lib/

# Download and install Atlas Listener dependencies
RUN wget -qO- https://repo1.maven.org/maven2/org/apache/hive/hive-exec/3.0.0/hive-exec-3.0.0.jar > hive-exec-3.0.0.jar && \
    mv hive-exec-3.0.0.jar /opt/hive-exec.jar && \
    cp /opt/hive-exec.jar ${LISTENER_PATH}/atlas-hive-plugin-impl

# Download and install the postgres connector used by HiveMetastore
RUN wget -qO- https://jdbc.postgresql.org/download/postgresql-42.2.16.jar > postgresql-42.2.16.jar && \
    mv postgresql-42.2.16.jar /opt/postgresql-jdbc.jar && \
    cp /opt/postgresql-jdbc.jar ${LISTENER_PATH}/atlas-hive-plugin-impl/

COPY /hive-metastore/hms-configuration/* ${METASTORE_HOME}/conf/
COPY /hive-metastore/atlas-configuration/atlas-application.properties ${METASTORE_HOME}/conf/
COPY /hive-metastore/atlas-configuration/import-hive.sh ${LISTENER_PATH}

RUN chmod 775 ${LISTENER_PATH}/import-hive.sh

WORKDIR ${METASTORE_HOME}

CMD ${LISTENER_PATH}/import-hive.sh
