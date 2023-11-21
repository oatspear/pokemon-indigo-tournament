#!/bin/sh
# Compares baserom.gbc and indigo.gbc

# create baserom.txt if necessary
if [ ! -f baserom.txt ]; then
	hexdump -C baserom.gbc > baserom.txt
fi

hexdump -C indigo.gbc > indigo.txt

diff -u baserom.txt indigo.txt | less
