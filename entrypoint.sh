#!/bin/sh
if [ -f "$HOME/.gdfuse/default/state" ]; then
    printf "State file found. Checking access token validity...\n"
    ACCESS_TOKEN=$(grep last_access_token "$HOME/.gdfuse/default/state" | sed -r "s/^last_access_token=//")
    if [ -n "$ACCESS_TOKEN" ]; then
        if wget "https://oauth2.googleapis.com/tokeninfo?access_token=${ACCESS_TOKEN}" -O /dev/null --quiet; then
            printf "Access token valid. Mounting filesystem on %s.\n" "$HOME/gdrive"
            google-drive-ocamlfuse -f -verbose "$HOME/gdrive"
        else
            printf "Access token invalid. Revalidating...\n"
            rm -f "$HOME/.gdfuse/default/state"
            if google-drive-ocamlfuse -headless -debug -log_to - -id "$CLIENT_ID" -secret "$SECRET"; then
                google-drive-ocamlfuse -f -verbose "$HOME/gdrive"
            fi
        fi
    fi
else
    if google-drive-ocamlfuse -headless -debug -log_to - -id "$CLIENT_ID" -secret "$SECRET"; then
        #printf "Access token valid. Mounting filesystem on %s" "$HOME/gdrive"
        google-drive-ocamlfuse -f -verbose "$HOME/gdrive"
    fi
fi
