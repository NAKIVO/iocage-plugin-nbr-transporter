#!/bin/sh

PRODUCT='NAKIVO Backup & Replication'
URL="https://d111xps0uy3x00.cloudfront.net/res/product/NAKIVO_Transporter_Installer_v11.2.3.sh"
SHA256="310ad1764742a7c53515981124988b7e25cccee424e8bd8f3740fb0304a5497d"

PRODUCT_ROOT="/usr/local/nakivo"
INSTALL="inst.sh"

fetch -o $INSTALL "$URL"
if [ $? -ne 0 -o ! -e $INSTALL ]; then
    echo "ERROR: Failed to get $PRODUCT installer"
    rm $INSTALL >/dev/null 2>&1
    exit 1
fi

CHECKSUM=`sha256 -q $INSTALL`
if [ "$SHA256" != "$CHECKSUM" ]; then
    echo "ERROR: Incorrect $PRODUCT installer checksum"
    rm $INSTALL >/dev/null 2>&1
    exit 2
fi

sh ./$INSTALL -s -i "$PRODUCT_ROOT" --eula-accept 2>&1
if [ $? -ne 0 ]; then
    echo "ERROR: $PRODUCT install failed"
    rm $INSTALL >/dev/null 2>&1
    exit 3
fi
rm $INSTALL >/dev/null 2>&1

exit 0
