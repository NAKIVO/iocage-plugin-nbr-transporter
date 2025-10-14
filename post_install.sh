#!/bin/sh

PRODUCT='NAKIVO Backup & Replication'
URL="https://d111xps0uy3x00.cloudfront.net/res/product/NAKIVO_Transporter_Installer_11.1.0.sh"
SHA256="47d1d7f846d4fd522ec4fcbbb1b734515c08ba2dbf18ece1af342474a8206fc9"

PRODUCT_ROOT="/usr/local/nakivo"
INSTALL="inst.sh"

curl --fail --tlsv1.2 -L -o $INSTALL $URL
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
