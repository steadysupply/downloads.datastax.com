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
DSA_USER=<dsa user>
DSA_PASS=<dsa pass> 
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
Start a DSE node
> Note: starting another node will require a different container name to be
> specified using`--name` flag
```
docker run --link dse-opsc -e CLUSTER_NAME=dse-cluster -e STOMP_INTERFACE=$(docker inspect --format '{{ .NetworkSettings.IPAddress }}' dse-opsc) --name dse-node dse-node-im
```
