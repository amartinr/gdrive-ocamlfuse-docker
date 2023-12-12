#!/bin/sh
if [[ -f $HOME/.gdfuse/default/state ]]; then
	google-drive-ocamlfuse -debug -log_to - $HOME/gdrive
else
	google-drive-ocamlfuse -headless -id ${CLIENT_ID} -secret ${SECRET}

	if [[ "$?" == "0" ]]; then
		google-drive-ocamlfuse -debug -log_to - $HOME/gdrive
	else
		/bin/sh
	fi
fi
