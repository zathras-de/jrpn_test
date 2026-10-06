#!/bin/bash
echo $PATH
cd `dirname $0`
BASE=`pwd`
for calc in jrpn16  ; do
    cd $BASE/$calc
    flutpak generate flutpak.yaml
    if [ $? != 0 ] ; then
        exit 1
    fi
    FH=$BASE/../flathub/$calc-flathub
    if [ ! -e $FH ] ; then
        echo "$FH doesn't exist"
        exit 1
    fi
    rm -rf $FH/[a-z]*
    cp -r flatpak/generated/[a-z]* $FH/
    echo "Copied to $FH"
done
echo "Done."

