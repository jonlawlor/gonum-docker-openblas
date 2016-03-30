set -ex

# fetch fortran to build OpenBLAS
apt-get -y update
apt-get -y install git-core gfortran curl gcc libc6-dev make


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
make BLLIB=/usr/lib/libopenblas.a -s alllib
mv lib/cblas_LINUX.a /usr/lib/libcblas.a
popd
popd

# fetch gimme and add it to the path
mkdir ~/bin
curl -sL -o ~/bin/gimme https://raw.githubusercontent.com/travis-ci/gimme/master/gimme
chmod +x ~/bin/gimme

# set up gopath
mkdir /root/gopath
export GOPATH=/root/gopath

# clean up
rm -rf ~/OpenBLAS
rm -rf ~/CBLAS
apt-get -y remove gfortran libc6-dev make
