This directory contains all the files required to build the docker containers
used by our testing infrastructure.

## Container hierarchy

This is the hierarchy of our containers:

```
    +----------------+
    |  sle-<release> |
    +--------+-------+
             |
             |
             |
  +----------+---------+
  | salt-<sle-version> |
  +----------+---------+
```

## Building

Right now the base containers are build manually, just enter their directory and
run:
```
docker build -t salt-<sle12sp1|sle11sp4> .
```

## Tagging images

Docker images can be versioned. The special `latest` version is assumed when
no version is specified. This version is similar to `HEAD` in the context of
git.

Images can be tagged using the `docker tag` command. An existing tag can be
overwritten by using the `-f` switch.

A Docker image can have infinite tags. A tag is just some cheap metadata, so
no disk space is actually wasted.

Remember to provide the right version when dealing with Docker images:
  * `docker run foo:1.0.0`
  * `docker rmi foo:1.0.0`
  * `docker pull foo:1.0.0`
  * `docker push foo:1.0.0`

All these commands are interacting with version `1.0.0` of the `foo` image. When
`1.0.0` is not specified then `foo:latest` is being used.

Note well: it's highly recommended to use specific versions of an image when
writing a `Dockerfile`. Writing something like `FROM foo:1.0.0` makes you closer
to have reproducible builds.

### Tagging in the context of salt

At the end of the build process you are going to have a Docker image with
the `latest` tag. It's recommended to create also a new proper version pointing
to this image.

It is recommended to use [semantic versioning](http://semver.org/) when dealing
with tag versions.

For example, let's assume `salt-sle12sp1:1.0.0` already exists. Suppose you
updated the `Dockerfile` to add a missing package to this image.

After the `docker build` process is done the `salt-sle12sp1` image is going
to be the new Docker image including your package. Now you have to make sure
the image can be referenced by an explicit version:

`docker tag salt-sle12sp1:latest salt-sle12sp1:1.0.1`

Note well: `latest` could have been omitted; it has been written just to make
things more explicit.

## Custom registry

All the containers used by CI are stored inside of our personal docker registry
which runs on `suma-docker-registry.suse.de`.

### Push containers to our registry

First you need to tag the local images:
```
docker tag salt-<sle12sp1|sle11sp4> suma-docker-registry.suse.de/salt-<sle12sp1|sle11sp4>
docker tag salt-<sle12sp1|sle11sp4>:<version> suma-docker-registry.suse.de/salt-<sle12sp1|sle11sp4>:<version>
```

Then you can push the local image:
```
docker push suma-docker-registry.suse.de/salt-<sle12sp1|sle11sp4>
docker push suma-docker-registry.suse.de/salt-<sle12sp1|sle11sp4>:<version>
```
