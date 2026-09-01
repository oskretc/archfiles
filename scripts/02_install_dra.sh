VERSION="0.10.3"
URL="https://github.com/devmatteini/dra/releases/download/${VERSION}/"
DOWNLOADFILE="dra-${VERSION}-x86_64-unknown-linux-musl"
EXT=".tar.gz"
BINNAME="dra"
echo ${URL}${DOWNLOADFILE}${EXT}
wget ${URL}${DOWNLOADFILE}${EXT}
mkdir ./tmpi
tar -xvf ${DOWNLOADFILE}${EXT} --directory ./tmpi --strip-components=1
cd ./tmpi
mv ${BINNAME} ~/.local/bin/${BINNAME}
cd ..
rm -r ./tmpi
rm ${DOWNLOADFILE}${EXT}
# https://github.com/devmatteini/dra/releases/download/0.10.3/dra-0.10.3-x86_64-unknown-linux-musl.tar.gz
