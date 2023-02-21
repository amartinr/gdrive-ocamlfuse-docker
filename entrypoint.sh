#!/bin/sh
eval $(opam env)

if [[ -f ~/.gdfuse/default/config/state ]]; then
	google-drive-ocamlfuse -debug -log_to - /mnt
else
	google-drive-ocamlfuse -headless -id ${CLIENT_ID} -secret ${SECRET}

	if [[ "$?" == "0" ]]; then
		google-drive-ocamlfuse -debug -log_to - /mnt
	else
		exit 1
	fi
fi
