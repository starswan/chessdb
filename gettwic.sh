#!/bin/bash
cd $HOME/chessdb/shared
home=`dirname $0`
mkdir -p Twic
cd Twic
twic=$PWD
mkdir -p downloads
cd downloads
$home/python/gettwic.py $twic
#cp -p *.zip $home/shared/tmp
find . -type f -name '*.zip' -exec unzip -a -qq -o {} \;
mv *.zip ..
cd ..
mkdir cbv
find downloads -name '*.cbv' -exec mv {} cbv \;
mkdir pgn
find downloads -name '*.pgn' -exec mv {} pgn \;
rm -rf downloads
find cbv -type f -exec mv {} . \;
rmdir cbv
find pgn -type f -exec mv {} . \;
rmdir pgn
