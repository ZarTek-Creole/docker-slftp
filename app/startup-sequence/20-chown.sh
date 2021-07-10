# Make sure $DATADIR is owned by slftp user. This affects ownership of the
# mounted directory on the host machine too.
# Also allow the container to be started with `--user`.

if [ "$(id -u)" = '0' ]; then
    chown -R ${USER_NAME}:${USER_GROUP} "$DATADIR" || (echo "code 1" && exit 1)
    chmod 700 -R "$DATADIR" || (echo "code 2" && exit 2)
    exec su -g ${USER_GROUP} ${USER_NAME} -c /entrypoint.sh "$@"
fi
