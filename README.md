# Intro
This small project is based on Alessandro Strada's work at https://github.com/astrada/google-drive-ocamlfuse. The resulting docker image is built so containers run using it run as a user with the same UID and GID as the one use to build the image using `sudo`.

# Usage
## Build
    git clone https://github.com/amartinr/gdrive-ocamlfuse-docker
    cd gdrive-ocamlfuse-docker
    sudo docker build --build-arg=UID=$(id -u) --build-arg=GID=$(id -g) -t <tag> .

## Configuration

docker.service override to allow sharing mount point between container and host

    $ sudo systemctl edit docker

    # /etc/systemd/system/docker.service.d/override.conf
    [Service]
    MountFlags=shared

    $ sudo systemctl restart docker

**.env**

    # place your client ID and secret from Google Developer Console
    CLIENT_ID=
    SECRET=

## Run
    sudo docker run -ti --name=gdrive-ocamlfuse --rm \
        --user <your UID>:<your GID>
        --device=/dev/fuse --cap-add=CAP_SYS_ADMIN --security-opt apparmor:unconfined \
        --env-file=.env \
        --mount type=bind,source=<host mount point>,destination=/var/lib/gdfuse/gdrive,bind-propagation=shared \
        --mount type=volume,source=gdrive-ocamlfuse-profile,destination=/var/lib/gdfuse/.gdfuse/default
        <docker-image>
