#!/bin/sh

# Create an XML query to use cpi to get the coprocessor uptime
read -r -d '' QUERY << EOM
<?xml version='1.0'?>
<cpi version='1.0'>
  <query_list>
    <query type="time"></query>
  </query_list>
</cpi>
EOM

# Execute the query, extract it from the response
UPTIME=$(echo $QUERY | cpi -i -o | grep 'response type="time"' | grep success | \
sed 's#.*<response.*>\([0-9]*\)</response>.*#\1#')

# Print the uptime, or ERROR if we couldn't get it
if [ "x$UPTIME" != "x" ]; then
	echo $UPTIME
else
	echo "ERROR"
fi
