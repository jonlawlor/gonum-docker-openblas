set -ex

# fetch fortran to build OpenBLAS
sudo apt-get install -y -qq git-core build-essential gfortran

# fetch OpenBLAS
pushd ~
sudo git clone --depth=1 git://github.com/xianyi/OpenBLAS


# make OpenBLAS
pushd OpenBLAS
sudo make FC=gfortran -s
sudo make PREFIX=/usr -s install
popd

# fetch cblas reference lib
curl http://www.netlib.org/blas/blast-forum/cblas.tgz | tar -zx

# make cblas and install
pushd CBLAS
sudo mv Makefile.LINUX Makefile.in
sudo make BLLIB=/usr/lib/libopenblas.a alllib
sudo mv lib/cblas_LINUX.a /usr/lib/libcblas.a
popd
popd

# clean up
