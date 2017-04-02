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

## Building
The containers require credentials to be passed as build args
```
docker build . --build-arg DSA_USER=<dsa user> --build-arg DSA_PASS=<dsa pass> -t dse-opsc-im -f OpscDockerfile
```

## Running
Start the `dse-opsc` container as a daemon (`-d`)
```
docker run -d -p 8888:8888 --name dse-opsc dse-opsc-im
```
