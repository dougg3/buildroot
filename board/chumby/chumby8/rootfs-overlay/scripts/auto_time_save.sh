#!/bin/sh

# Simple script that ensures we try to stay in sync with the cryptoprocessor's
# "time since last boot" counter so the time is tracked properly while turned off.

UPTIME_FILE=/mnt/settings/coprocessor_uptime

ntpvalid() {
	NTP_OUTPUT=$(ntpq -c "rv 0 leap" 127.0.0.1)
	if [ $? -ne 0 ]; then
		return 1
	fi

	if [ "$NTP_OUTPUT" = "leap=00" -o "$NTP_OUTPUT" = "leap=01" -o "$NTP_OUTPUT" = "leap=10" ]; then
		return 0
	fi

	return 1
}

# If we already have a file containing the time to sync, load it
if [ -f $UPTIME_FILE ]; then
	/scripts/restore_datetime.sh
fi

# Wait until we have a date that makes sense (more recent than Y2K)
while [ $(date +%s) -lt 946684800 ]; do
	sleep 10
done

# Okay, we are now guaranteed that we have a valid date.
# If we don't have a valid date stored, save it now.
# Generally this happens because the ntp server has just told
# us what our date is for the first time.
if [ ! -f $UPTIME_FILE ]; then
	# Save it now, so we'll have something!
	/scripts/save_datetime.sh
else
	# We already have a date saved. Wait until ntp fully syncs up before overwriting.
	while ! ntpvalid; do
		sleep 10
	done

	# Now we can save; we know we have a valid date that's synced up
	/scripts/save_datetime.sh
fi

# After that, run an infinite loop that saves every 24 hours
while [ 1 ]; do
	sleep 86400
	/scripts/save_datetime.sh
done
