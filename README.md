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
job tracker respectively. This command also mounts a `*.cql` file and `*.py`
file for convenient execution within the cluster.
> Note: starting another node will require a different container name to be
> specified using`--name` flag
```
export MASTER_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' dse-opsc)
docker run --link dse-opsc -e CLUSTER_NAME=dse-cluster -e STOMP_INTERFACE=$MASTER_IP -v $(pwd)/origami-et3_sample_2017.cql:/opt/origami-et3_sample_2017.cql -v $(pwd)/poc.py:/opt/poc.py --name dse-node-0 dse-node-im -k -c -t
```
Execute mounted `origami-et3_sample_2017.cql` file against Cassandra
```
docker exec dse-node-0 cqlsh -f /opt/origami-et3_sample_2017.cql`
```
Sumbit mounted PySpark job to Spak for processing
```
export SPARK_IP=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' dse-node-0)
docker exec -e SPARK_IP=$SPARK_IP -it dse-node-0 dse spark-submit /opt/poc.py
```
Other DSE flavoured Hadoop-family commands are available, eg.
```
docker exec -e HOME=/opt/dse -e IPYTHON=1 -it dse-node-0 dse pyspark
```
If shell access to the container is required, it is recommended that the
user logs in as `cassandra`:
```
docker exec -it --user cassandra dse-node-0 /bin/bash
```
