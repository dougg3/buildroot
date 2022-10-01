#!/bin/sh

# Restores date/time from file saved by save_datetime.sh and coprocessor uptime
UPTIMEFILE=/mnt/settings/coprocessor_uptime

# Check for the file
if [ ! -f $UPTIMEFILE ]; then
	echo "Can't restore date/time because it was never saved" >&2
	exit 1
fi

# Read it in and make sure it parses okay
UPTIMEDATA=$(cat $UPTIMEFILE)
SAVED_UPTIME=$(echo $UPTIMEDATA | cut -d' ' -f1)
SAVED_DATETIME=$(echo $UPTIMEDATA | cut -d' ' -f2)

if ! echo $SAVED_UPTIME | grep -q -E '^[0-9]+$'; then
	echo "Can't restore date/time because file is corrupt" >&2
	exit 1
elif ! echo $SAVED_DATETIME | grep -q -E '^[0-9]+$'; then
	echo "Can't restore date/time because file is corrupt" >&2
	exit 1
fi

# Grab the coprocessor uptime as an epoch
UPTIME=$(/scripts/get_coprocessor_uptime.sh)

# Make sure we succeeded
if [ $UPTIME = "ERROR" ]; then
	echo "Unable to retrieve uptime from coprocessor" >&2
	exit 1
fi

# Check if the uptime has decreased
if [ $UPTIME -lt $SAVED_UPTIME ]; then
	echo "Can't restore date/time because coprocessor has been reset since last save" >&2
	exit 1
fi

# Calculate the new date using the uptime difference and the saved date
UPTIMEDIFF=$(( UPTIME - SAVED_UPTIME ))
NEW_DATETIME=$(( SAVED_DATETIME + UPTIMEDIFF ))

# Save the new date/time
date -s @$NEW_DATETIME > /dev/null
if [ $? -ne 0 ]; then
	echo "Error setting date/time" >&2
	exit 1
fi
