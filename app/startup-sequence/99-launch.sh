if [ "$(id -u)" != '0' ]; then
	echo "RUNAS[$(id)] : /bin/slftp_run"
	exec  /bin/slftp_run
fi
