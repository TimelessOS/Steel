cd ncurses-6.5-20250809

CC=musl-gcc ./configure \
    --prefix=/usr/ \
    --with-shared \
    --without-debug \
    --without-ada \
    --without-cxx-binding \
    --with-termlib \
    --enable-widec

make -j$(nproc)

make install DESTDIR=$PWD/out

mv out ..