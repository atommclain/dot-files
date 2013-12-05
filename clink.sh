#!/bin/sh

if [ $# -eq 0 ]        
  then                 
    echo "No arguments supplied"               
    exit 1             
fi                     

FIRST_ARGUMENT="$1"    

mkdir ~/.bak
cp ~/$FIRST_ARGUMENT ~/.bak
rm ~/$FIRST_ARGUMENT
ln -s $(pwd)/$FIRST_ARGUMENT ~/$FIRST_ARGUMENT
