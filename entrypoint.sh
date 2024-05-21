#!/bin/sh
if [ -f "$HOME/.gdfuse/default/state" ]; then
    printf "State file found. Checking access token validity...\n"
    ACCESS_TOKEN=$(grep last_access_token "$HOME/.gdfuse/default/state" | sed -r "s/^last_access_token=//")
    if [ -n "$ACCESS_TOKEN" ]; then
        if wget "https://oauth2.googleapis.com/tokeninfo?access_token=${ACCESS_TOKEN}" -O /dev/null --quiet; then
            printf "Access token still valid. Mounting filesystem on %s.\n" "$HOME/gdrive"
            google-drive-ocamlfuse -f -verbose "$HOME/gdrive"
        else
            printf "Access token no longer valid. Revalidating...\n"
            rm -f "$HOME/.gdfuse/default/state"
            REQUEST_TOKEN="true"
        fi
    else
        printf "No access token found. Requesting new one...\n"
        REQUEST_TOKEN="true"
    fi
else
    REQUEST_TOKEN="true"
fi

if [ "$REQUEST_TOKEN" = "true" ]; then
    if google-drive-ocamlfuse -headless -debug -log_to - -id "$CLIENT_ID" -secret "$SECRET"; then
        google-drive-ocamlfuse -f -verbose "$HOME/gdrive"
    fi
fi
