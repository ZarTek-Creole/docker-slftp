if [ "$(id -u)" != '0' ]; then
	cd ${DATADIR}/data

	for f in *; do
	echo "CONFIG LINKING $f to ${DATADIR}"
		ln -sfn ${DATADIR}/data/$f ${DATADIR}/$f || exit 1
	done
	for LIB in $SLFTP_LIB_LIST; do
		LINE=$(whereis $LIB) 
		if [[ $LINE =~ $lib ]]; then
			for WORD in $LINE; do
				if [[ $WORD =~ $LIB ]]; then
					echo "LIB LINKING $WORD to ${DATADIR}";
					ln -sfn $WORD ${DATADIR} || echo "Load $LIB ERROR" exit 1
				fi
			done
		else 
			echo "lib Not found";
		fi
	done
fi