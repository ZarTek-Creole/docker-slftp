#!/bin/bash
if [ "$(id -u)" != '0' ]; then
	cd $SOURCEDIR
	remote_version=$(git describe --tags $(git rev-list --tags --max-count=1))

	if [[ "${SLFTP_VERSION}" != "${remote_version}" ]]; then
		echo "You can update your SLFTP version (image) from v:${SLFTP_VERSION} to v:${remote_version}"
	else
		echo "Your version is a day v:${SLFTP_VERSION}"
	fi
fi