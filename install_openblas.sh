set -ex

# fetch fortran to build OpenBLAS
apt-get -y update
apt-get -y install git-core build-essential gfortran


# fetch OpenBLAS
pushd ~
git clone --depth=1 git://github.com/xianyi/OpenBLAS


# make OpenBLAS
pushd OpenBLAS
make FC=gfortran -s
make PREFIX=/usr -s install
popd

# fetch cblas reference lib
curl http://www.netlib.org/blas/blast-forum/cblas.tgz | tar -zx

# make cblas and install
pushd CBLAS
mv Makefile.LINUX Makefile.in
make BLLIB=/usr/lib/libopenblas.a alllib
mv lib/cblas_LINUX.a /usr/lib/libcblas.a
popd
popd

# clean up
