# Docker Reactjs

This is docker base image to run application that using Reactjs. This image have 2 base service

1. Apache to run the build script in web browser
2. Yarn to run the node command

## Requirements:

1. The docker image is expecting the volume mounted to `/app` directory and the web public directory located at `/app/build`

## Docker commands

### Build

```shell script
docker build -t vvvroom/reactjs .
```

### Run 

```shell script
docker run --rm \
    -v ${PWD}/test-repo:/app \
    -p 9000:443 \
    vvvroom/reactjs
```

### Push 

```shell script
docker push vvvroom/reactjs
```

## Caveats

### SSH Private Key
Since most of the time we will most likely install a package from git private repositories.
We will need to sync our OS private key file into Docker root user location at `/root/.ssh/id_rsa`
To do that, we can do that using volume option like example below.

Note that we're using mounting `ro` read only option for safety purpose docker not overwrite our private keys.

```
-v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro
``` 
