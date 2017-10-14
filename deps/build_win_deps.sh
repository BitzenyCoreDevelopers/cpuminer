#!/bin/bash
set -e
PREFIX=${PWD}/x86_64-w64-mingw32

CURL_PACKAGE=curl-7.54.1
CURL_PACKAGE_FILE=${CURL_PACKAGE}.tar.gz
CURL_PACKAGE_FILE_SHA256=cd404b808b253512dafec4fed0fb2cc98370d818a7991826c3021984fc27f9d0
CURL_CHECKSUM_FILE=${CURL_PACKAGE_FILE}.sha256

PT_PACKAGE=pthreads-w32-2-9-1-release
PT_PACKAGE_FILE=${PT_PACKAGE}.tar.gz
PT_PACKAGE_FILE_SHA256=e6aca7aea8de33d9c8580bcb3a0ea3ec0a7ace4ba3f4e263ac7c7b66bc95fb4d
PT_CHECKSUM_FILE=${PT_PACKAGE_FILE_SHA256}.sha256

wget https://curl.haxx.se/download/$CURL_PACKAGE_FILE -O $CURL_PACKAGE_FILE
echo "${CURL_PACKAGE_FILE_SHA256}  ${CURL_PACKAGE_FILE}" > $CURL_CHECKSUM_FILE
sha256sum -c $CURL_CHECKSUM_FILE
rm $CURL_CHECKSUM_FILE

wget ftp://sourceware.org/pub/pthreads-win32/$PT_PACKAGE_FILE -O $PT_PACKAGE_FILE
echo "${PT_PACKAGE_FILE_SHA256}  ${PT_PACKAGE_FILE}" > $PT_CHECKSUM_FILE
sha256sum -c $PT_CHECKSUM_FILE
rm $PT_CHECKSUM_FILE

tar zxvf $CURL_PACKAGE_FILE
tar zxvf $PT_PACKAGE_FILE

cd $CURL_PACKAGE
./configure --host=x86_64-w64-mingw32 --disable-shared --enable-static --with-winssl --prefix=$PREFIX
make install

cd ../${PT_PACKAGE}/
cp config.h pthreads_win32_config.h
make -f GNUmakefile CROSS="x86_64-w64-mingw32-" clean GC-static
cp libpthreadGC2.a ${PREFIX}/lib/libpthread.a
cp pthread.h semaphore.h sched.h ${PREFIX}/include
