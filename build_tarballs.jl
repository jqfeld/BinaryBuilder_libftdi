using BinaryBuilder, Pkg

name = "libftdi"
version = v"1.5.0"
sources = [
    ArchiveSource("https://www.intra2net.com/en/developer/libftdi/download/libftdi1-1.5.tar.bz2", "7c7091e9c86196148bd41177b4590dccb1510bfe6cea5bf7407ff194482eb049"),
]

script = raw"""
cd ${WORKSPACE}/srcdir/libftdi1-*
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=${prefix} -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TARGET_TOOLCHAIN} -DCMAKE_BUILD_TYPE=Release -DEXAMPLES=OFF ../
make -j${nproc}
make install
"""

platforms = [
  Platform("x86_64","linux";)
  Platform("i686","linux";)
  Platform("x86_64","windows";)
  Platform("i686","windows";)
]


products = [
    LibraryProduct("libftdi1", :libftdi),
]

dependencies = [
    Dependency("libusb_jll"),
    Dependency("libconfuse_jll")
]

build_tarballs(ARGS, name, version, sources, script, platforms, products, dependencies; julia_compat="1.6")
