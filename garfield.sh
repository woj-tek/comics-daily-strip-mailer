#!/bin/sh

rm *.html* > /dev/null 2>&1
rm cookies* > /dev/null 2>&1

wget -q -O token.html --keep-session-cookies --save-cookies cookies.txt https://garfield.com/comic/
TOKEN=$(grep "token" token.html | sed "s/.* value=\"\(.*\)\".*/\1/")

wget -qO- --keep-session-cookies --load-cookies cookies.txt --save-cookies cookies2.txt --post-data "_token=${TOKEN}&year=1992&month=8&day=17" https://garfield.com/agegate > garfield.html

IMG_SRC=$(grep -A 10 ".div class=.comic-display." garfield.html | grep "img-responsive" | perl -pe "s|.*src=\"(.*?)\".*|\1|")
#echo ${IMG_SRC}

filename=$(basename "${IMG_SRC}")
#echo ${filename}

strip_date=$(echo "${filename}" | perl -pe "s|(.*)\..*|\1|")
#echo ${strip_date}

wget -q -N ${IMG_SRC}

if [ ! -z "${1}" ] ; then
#	uuencode ${filename} ${filename} | mail -v -s "Daily Garfield strip: ${strip_date}" ${1} > /dev/null 2>&1
	mutt -s "Daily Garfield strip: ${strip_date}" -a ${filename} -- ${1} < /dev/null
fi

rm *.html* > /dev/null 2>&1
rm cookies* > /dev/null 2>&1
