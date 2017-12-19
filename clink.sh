#!/bin/sh

if [ $# -eq 0 ]
then
	echo "No arguments supplied"
	exit 1
fi

FIRST_ARGUMENT="$1"

# only create folder if it doesn't exist
mkdir -p ~/.bak

# if file already exists, move it .bak
if [ -e  ~/$FIRST_ARGUMENT ]
then
	cp ~/$FIRST_ARGUMENT ~/.bak
	rm ~/$FIRST_ARGUMENT
fi

ln -s $(pwd)/$FIRST_ARGUMENT ~/$FIRST_ARGUMENT
