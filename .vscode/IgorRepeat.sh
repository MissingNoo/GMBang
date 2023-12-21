#!/bin/bash
for i in 1 2 3
do
	/usr/local/bin/Igor  -j=8  -options=$1 -v -- Linux Run &
done
