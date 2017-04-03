# Provided without any warranty, these files are intended
# to accompany the whitepaper about DSE on Docker and are
# not intended for production and are not actively maintained.

# Loosely based on docker-cassandra by the fine folk at Spotify
# -- https://github.com/spotify/docker-cassandra/
# Loosely based on cassandra-docker by the one and only Al Tobey
# -- https://github.com/tobert/cassandra-docker/

# base yourself on any ubuntu 14.04 image containing JDK8
# official Docker Java images are distributed with OpenJDK
# Datastax certifies its product releases specifically
# on the Oracle/Sun JVM, so YMMV with OpenJDK

FROM nimmis/java:oracle-8-jdk

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get -y install adduser \
    curl \
    lsb-base \
    procps \
    zlib1g \
    gzip \
    python \
    ipython \
    sysstat \
    sudo \
    ntp bash tree && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://launchpadlibrarian.net/109052632/python-support_1.0.15_all.deb
RUN dpkg -i python-support_1.0.15_all.deb

# grab gosu for easy step-down from root
RUN curl -o /bin/gosu -SkL "https://github.com/tianon/gosu/releases/download/1.4/gosu-$(dpkg --print-architecture)" \
    && chmod +x /bin/gosu


ARG DSA_USER
ARG DSA_PASS

ARG DSE_VERSION=5.0.7
ARG DSE_AGENT_VERSION=6.0.8

RUN curl --user $DSA_USER:$DSA_PASS -L http://downloads.datastax.com/enterprise/dse-$DSE_VERSION-bin.tar.gz | tar xz
RUN mv dse-$DSE_VERSION /opt/dse

RUN curl --user $DSA_USER:$DSA_PASS http://debian.datastax.com/enterprise/pool/datastax-agent_${DSE_AGENT_VERSION}_all.deb > /tmp/datastax-agent_all.deb

ENV DSE_HOME /opt/dse

# keep data here
VOLUME /data

# and logs here
VOLUME /logs

VOLUME /opt/dse

# create a dedicated user for running DSE node
RUN groupadd -g 1337 cassandra && \
    useradd -u 1337 -g cassandra -s /bin/bash -d $DSE_HOME cassandra && \
    chown -R cassandra:cassandra /opt/dse*

# install the agent
RUN dpkg -i /tmp/datastax-agent_all.deb

# add config file
ADD  ./dse.yaml /opt/dse/resources/dse/conf/dse.yaml

# set general permissions and fs lib dir
RUN mkdir /var/lib/dsefs
RUN chown -R cassandra:cassandra /opt/dse /var/lib/dsefs
WORKDIR /opt/dse

# starting node using custom entrypoint that configures paths, interfaces, etc.
COPY scripts/dse-entrypoint /usr/local/bin/
RUN chmod +x /usr/local/bin/dse-entrypoint
ENTRYPOINT ["/usr/local/bin/dse-entrypoint"]

# Running any other DSE/C* command should be done on behalf dse user
# Perform that using a generic command laucher
COPY scripts/dse-cmd-launcher /usr/local/bin/
RUN chmod +x /usr/local/bin/dse-cmd-launcher

# link dse commands to the launcher
RUN for cmd in cqlsh dsetool nodetool dse cassandra-stress; do \
        ln -sf /usr/local/bin/dse-cmd-launcher /usr/local/bin/$cmd ; \
    done

# the detailed list of ports
# http://docs.datastax.com/en/datastax_enterprise/5.0/datastax_enterprise/sec/secConfFirePort.html

# Cassandra
EXPOSE 7000 9042 9160 5598

# Solr
EXPOSE 8983 8984

# Spark
EXPOSE 4040 7080 7081 7077

# Hadoop
EXPOSE 8012 50030 50060 9290

# Hive/Shark
EXPOSE 10000
