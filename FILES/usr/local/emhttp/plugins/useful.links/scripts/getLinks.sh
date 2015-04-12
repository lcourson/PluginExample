#!/bin/bash

# download the links.json file
mkdir -p /tmp/.useful.links > /dev/null

wget "https://raw.githubusercontent.com/Squidly271/UsefulLinks/master/FILES/usr/local/emhttp/plugins/online.help/links.json" -O /tmp/.useful.links/links.json > /dev/null 2>&1

# parse the file into something easier

cat /tmp/.useful.links/links.json | /usr/local/emhttp/plugins/useful.links/scripts/json.sh -b > /tmp/.useful.links/links


# create the buttons

OUTPUT0="/tmp/.useful.links/temp0"
OUTPUT1="/tmp/.useful.links/temp1"
OUTPUT2="/tmp/.useful.links/temp2"
OUTPUT3="/tmp/.useful.links/temp3"

echo "<select id=\"category0\" onchange=\"loadPage0(value)\"><option value=\"default0\" selected disabled>General Links</option>" > $OUTPUT0
echo "<select id=\"category1\" onchange=\"loadPage1(value)\"><option value=\"default1\" selected disabled>How To Guides</option>" > $OUTPUT1
echo "<select id=\"category2\" onchange=\"loadPage2(value)\"><option value=\"default2\" selected disabled>Troubleshooting</option>" > $OUTPUT2
echo "<select id=\"category3\" onchange=\"loadPage3(value)\"><option value=\"default3\" selected disabled>Other Useful Links</option>" > $OUTPUT3

URL_NUM=0

while :
do
	if ! cat /tmp/.useful.links/links | grep -i "\[$URL_NUM,\"url\"]" > /dev/null
	then
		break
	fi

	URL=$(cat /tmp/.useful.links/links | grep -i "\[$URL_NUM,\"url\"" | sed 's/^.*url/url/' | sed 's/^......//' | sed -e 's/^[ \t]*//' | sed 's/\"//g' )
        DESCRIPTION=$(cat /tmp/.useful.links/links | grep -i "\[$URL_NUM,\"description\"" | sed 's/^.*description/description/' | sed 's/^..............//' | sed -e 's/^[ \t]*//' | sed 's/\"//g' )
        TYPE=$(cat /tmp/.useful.links/links | grep -i "\[$URL_NUM,\"type\"" | sed 's/^.*type/type/' | sed 's/^......//' | sed -e 's/^[ \t]*//' | sed 's/\"//g' )

	case $TYPE in
		0)
			echo "<option value=\"$URL\">$DESCRIPTION</option>" >> $OUTPUT0
			;;
		1)
			echo "<option value=\"$URL\">$DESCRIPTION</option>" >> $OUTPUT1
			;;
		2)
			echo "<option value=\"$URL\">$DESCRIPTION</option>" >> $OUTPUT2
			;;
		3)
			echo "<option value=\"$URL\">$DESCRIPTION</option>" >> $OUTPUT3
			;;
	esac

	URL_NUM=$((URL_NUM + 1))
done

echo "</select>" >> $OUTPUT0
echo "</select>" >> $OUTPUT1
echo "</select>" >> $OUTPUT2
echo "</select>" >> $OUTPUT3

