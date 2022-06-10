#!/bin/sh

# OPAM environment variables, including $PATH
eval $(opam env)

# Initialise Google OAuth
if [[ ! -f ~/.gdfuse/config/state ]]; then
    google-drive-ocamlfuse -headless -id ${CLIENT_ID} -secret ${SECRET}

    # If authentication succesful, mount Drive on /mnt
    if [[ "$?" == "0" ]]; then
        google-drive-ocamlfuse -debug -log_to - /mnt
    else
        exit 1
    fi
# If state file with auth token already exists, mount Drive on /mnt
else
    google-drive-ocamlfuse -debug -log_to - /mnt
fi
