# Datastax containers
Mirror of the files available at the URL below.

## Update
To update this repo, run
```
wget --no-parent --recursive http://downloads.datastax.com/extra/docker_examples/latest/
find . -name index.html\*|xargs -I{} rm {}
```
## Whitepaper
These files accompany a
“[whitepaper](DataStax-WP-Best_Practices_Running_DSE_Within_Docker.pdf)” which
is included in this repo

## Building & running containers
The containers require credentials to be passed as build args, set them as env
vars for convenience
```
export DSA_USER=<dsa user>
export DSA_PASS=<dsa pass> 
```
Build the `dse-opsc-im` image
```
docker build . --build-arg DSA_USER=$DSA_USER --build-arg DSA_PASS=$DSA_PASS -t dse-opsc-im -f OpscDockerfile
```
Start the `dse-opsc` container as a daemon (`-d`)
```
docker run -d -p 8888:8888 --name dse-opsc dse-opsc-im
```
Build the `dse-node-im` image
```
docker build . --build-arg DSA_USER=$DSA_USER --build-arg DSA_PASS=$DSA_PASS -t dse-node-im
```
Start a DSE node with `-k`, `-c` and `-t` flags to start Spark, DSEFS and the
job tracker respectively.
> Note: starting another node will require a different container name to be
> specified using`--name` flag
```
docker run --link dse-opsc -e CLUSTER_NAME=dse-cluster -e STOMP_INTERFACE=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' dse-opsc) --name dse-node-0 dse-node-im -k -c -t
```
Now DSE flavoured Hadoop-family commands are available, eg.
```
docker exec -e HOME=/opt/dse -e IPYTHON=1 -it dse-node-0 dse pyspark
```
The full list
```
$ docker exec -it dse-node-0 dse

/opt/dse/bin/dse:
usage: dse [-f <config file> -u <username> -p <password> -a <jmx_username> -b <jmx_password>] <command> [command-args]

Available commands:
  -v                              print DSE version
  cassandra                       run DSE server
  cassandra-stop                  stop DSE server
  fs                              run DSE File System shell
  hadoop                          Hadoop command
  hive                            Hive command
  beeline                         Beeline command
  pig                             Pig command
  sqoop                           Sqoop command
  mahout                          Mahout command
  spark                           Spark shell
  spark-class                     Spark class
  spark-submit                    Submit Spark job
  spark-jobserver                 Spark Jobserver command
  spark-history-server            Spark History Server command
  spark-sql-thriftserver          Spark SQL Thriftserver command
  pyspark                         Spark Python shell
  spark-sql                       Spark SQL command line
  spark-beeline                   Beeline client from Spark
  esri-import                     Esri import command
  hive-metastore-migrate          Migrate Hive metastore from one DSE version to another
  client-tool                     Runs a DSE client tool command
  gremlin-console                 Runs Gremlin console
  advrep                          Advanced Replication command
```
If shell access to the container is required, it is recommended that the
user logs in as `cassandra`:
```
docker exec -it --user cassandra dse-node-0 /bin/bash
```
