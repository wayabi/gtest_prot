#!/bin/sh

for h in `ls src/*.h`
do
	name=${h##*/}
	cat src/${name} | sed -e "s/private:/public:/g" | sed -e "s/protected:/public:/g" > public_src/${name}
done

cp src/*.cpp public_src/
rm public_src/main.cpp
