#!/bin/sh

CURDIR=`pwd`
FUZZDIR=`dirname $0`

cd ${FUZZDIR}

if ! test -x xplist_fuzzer || ! test -x bplist_fuzzer || ! test -x jplist_fuzzer || ! test -x oplist_fuzzer; then
	echo "ERROR: you need to build the fuzzers first."
	cd ${CURDIR}
	exit 1
fi

if ! test -d xplist-input || ! test -d bplist-input || ! test -d jplist-input || ! test -d oplist-input; then
	echo "ERROR: fuzzer corpora directories are not present. Did you run init-fuzzers.sh ?"
	cd ${CURDIR}
	exit 1
fi

echo "### TESTING xplist_fuzzer ###"
if ! ./xplist_fuzzer xplist-input -dict=xplist.dict -max_len=65536 -runs=10000; then
	cd ${CURDIR}
	exit 1
fi

echo "### TESTING bplist_fuzzer ###"
if ! ./bplist_fuzzer bplist-input -dict=bplist.dict -max_len=4096 -runs=10000; then
	cd ${CURDIR}
	exit 1
fi

echo "### TESTING jplist_fuzzer ###"
if ! ./jplist_fuzzer jplist-input -dict=jplist.dict -max_len=65536 -runs=10000; then
	cd ${CURDIR}
	exit 1
fi

echo "### TESTING oplist_fuzzer ###"
if ! ./oplist_fuzzer oplist-input -dict=oplist.dict -max_len=65536 -runs=10000; then
	cd ${CURDIR}
	exit 1
fi

cd ${CURDIR}
exit 0
