# Intro
This project is based on Alessandro Strada's work from https://github.com/astrada/google-drive-ocamlfuse.

# Usage
## Build
    git clone https://github.com/amartinr/gdrive-ocamlfuse-docker
    cd gdrive-ocamlfuse-docker
    docker build -t <tag> .

## Configuration
**.env**
    CLIENT_ID=
    SECRET=

## Run
    docker run -ti --name=gdrive-ocamlfuse --rm \
        --device=/dev/fuse --cap-add=CAP_SYS_ADMIN \
        --env-file=.env \
        --mount type=bind,source=${PWD}/gdrive,destination=/mnt,bind-propagation=shared \
        --mount type=volume,source=gdrive-ocamlfuse-profile,destination=/root/.gdfuse/default
        <docker-image>
