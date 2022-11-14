#!/bin/bash
PLUGIN_NAME="vmsnapshot"
BASE_DIR="usr/local/emhttp/plugins/${PLUGIN_NAME}"
TMP_DIR="/tmp/${PLUGIN_NAME}_"$(echo $RANDOM)""
VERSION="$(date +'%Y.%m.%d')"
SRCDIR=`pwd`

mkdir -p $SRCDIR/packages
mkdir -p $TMP_DIR/$VERSION/$BASE_DIR
cd source
cp --parents -R * $TMP_DIR/$VERSION/$BASE_DIR
cp ../$PLUGIN_NAME.plg $TMP_DIR/$VERSION/$BASE_DIR
cd $TMP_DIR/$VERSION
tar -cJf $SRCDIR/packages/$PLUGIN_NAME-$VERSION.txz *
md5sum $SRCDIR/packages/$PLUGIN_NAME-$VERSION.txz > $SRCDIR/packages/$PLUGIN_NAME-$VERSION.txz.md5
#rm -R $TMP_DIR/$VERSION/
cd $SRCDIR
rm -R $TMP_DIR