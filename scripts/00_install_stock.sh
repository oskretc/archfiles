VERSION="0.4.0"
URL="https://github.com/cushycush/stock/releases/download/v${VERSION}/"
DOWNLOADFILE="stock-v${VERSION}-linux-amd64"
EXT=".zip"
BINNAME="stock"
wget ${URL}${DOWNLOADFILE}${EXT}
unzip ${DOWNLOADFILE}${EXT}
mv ${DOWNLOADFILE} ~/.local/bin/${BINNAME}
rm ${DOWNLOADFILE}${EXT}
