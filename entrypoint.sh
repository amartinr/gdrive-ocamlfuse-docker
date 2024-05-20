#!/bin/sh
if [[ -f $HOME/.gdfuse/default/state ]]; then
	google-drive-ocamlfuse -f -verbose $HOME/gdrive
else
	google-drive-ocamlfuse -headless -debug -log_to - -id ${CLIENT_ID} -secret ${SECRET}

	if [[ "$?" == "0" ]]; then
		google-drive-ocamlfuse -f -verbose $HOME/gdrive
	else
		/bin/sh
	fi
fi
