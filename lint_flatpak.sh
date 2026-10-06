#!/bin/bash -x
echo $PATH
cd `dirname $0`
BASE=`pwd`
for calc in jrpn16 jrpn15  ; do
    cd $BASE/$calc
    flutpak generate flutpak.yaml
    if [ $? != 0 ] ; then
        exit 1
    fi
    appstreamcli validate --explain --no-net \
          app/share/metainfo/com.jovial.$calc.metainfo.xml
    if [ $? != 0 ] ; then
        exit 1
    fi
    flatpak run --filesystem=host --command=flatpak-builder-lint \
          org.flatpak.Builder --exceptions manifest \
          flatpak/generated/com.jovial.$calc.yml
    if [ $? != 0 ] ; then
        exit 1
    fi
#    flatpak run --command=flathub-build  org.flatpak.Builder \
#        flatpak/generated/com.jovial.$calc.yml
#    if [ $? != 0 ] ; then
#        exit 1
#    fi
done
echo "Done."

