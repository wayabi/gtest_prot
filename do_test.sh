#!/bin/sh

rm public_src/*
./copy4test.sh
make test
ret=$?
if [ ${ret} -eq 0 ]; then
	./gtest
fi
