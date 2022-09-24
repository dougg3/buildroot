#!/bin/sh

# Saves current date/time and coprocessor uptime to a file,
# so we can estimate the new date/time when it powers back up
UPTIMEFILE=/etc/coprocessor_uptime

# Grab the coprocessor uptime and the current date/time as an epoch
UPTIME=$(/scripts/get_coprocessor_uptime.sh)
DATETIME=$(date +%s)

# Make sure we succeeded
if [ $UPTIME = "ERROR" ]; then
	echo "Unable to retrieve uptime from coprocessor" >&2
	exit 1
fi

# Save them into the file
mount -oremount,rw /
echo $UPTIME $DATETIME > /etc/coprocessor_uptime
mount -oremount,ro /
