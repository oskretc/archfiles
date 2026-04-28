VERSION="2.5.0"
URL="https://github.com/cushycush/store/releases/download/v${VERSION}/"
DOWNLOADFILE="store-v${VERSION}-linux-amd64"
EXT=".zip"
BINNAME="store"
wget ${URL}${DOWNLOADFILE}${EXT}
unzip ${DOWNLOADFILE}${EXT}
mv ${DOWNLOADFILE} ~/.local/bin/${BINNAME}
rm ${DOWNLOADFILE}${EXT}
