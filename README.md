# Intro
This small project is based on Alessandro Strada's work at https://github.com/astrada/google-drive-ocamlfuse.

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
    test -d ${PWD}/gdrive || mkdir -p ${PWD}/gdrive
    sudo docker run -ti --name=gdrive-ocamlfuse --rm \
        --device=/dev/fuse --cap-add=CAP_SYS_ADMIN --security-opt apparmor:unconfined \
        --env-file=.env \
        --mount type=bind,source=${PWD}/gdrive,destination=/mnt,bind-propagation=shared \
        --mount type=volume,source=gdrive-ocamlfuse-profile,destination=/root/.gdfuse/default
        <docker-image>
