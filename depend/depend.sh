echo 'download libcurl'
wget http://curl.haxx.se/gknw.net/7.38.0/dist-w64/curl-7.38.0-devel-mingw64.zip
unzip curl-7.38.0-devel-mingw64.zip
echo '#/bin/sh' > curl-7.38.0-devel-mingw64/bin/curl-config
echo 'echo "libcurl 7.38.0"' > curl-7.38.0-devel-mingw64/bin/curl-config
chmod 755 curl-7.38.0-devel-mingw64/bin/curl-config
