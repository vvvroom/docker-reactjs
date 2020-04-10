# Docker Reactjs

Docker images that suitable to run reactjs application. This image has two software preconfigured.

1. Apache HTTP Server with SSL and using `build/` directory as web root 
2. Node v12 & NPM to compile reactjs package.

## How to use:

The docker image is expecting the volume mounted to `/var/www/app` directory, and the web public directory located at `/var/www/app/build`.
We only need sync the volume and make sure we have the `/app/build` directory exist. See the 
[docker-compose.yml](./docker-compose.yml) file for example. 

## How to develop

1. Run `docker-compose up` to start the containers
1. Open in browser `http://localhost:7101` to HTTP 
1. Open in browser `https://localhost:7102` to HTTPS 

### SSH Private Key
Since most of the time we will most likely install a package from git private repositories.
We will need to sync our OS private key file into Docker root user location at `/root/.ssh/id_rsa`
To do that, we can do that using volume option like example below.

Note that we're using mounting `ro` read only option for safety purpose docker not overwrite our private keys.

```
-v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro
``` 
