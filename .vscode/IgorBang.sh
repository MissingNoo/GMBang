#!/bin/bash
/home/airgeadlamh/.local/share/GameMakerStudio2-Beta/Cache/runtimes/runtime-2023.1100.0.459/bin/igor/linux/x64/Igor -j=8  -options=../tmp/build.bff -v -- Linux Run &&
for i in 1 2 3
do
/home/airgeadlamh/.local/share/GameMakerStudio2-Beta/Cache/runtimes/runtime-2023.1100.0.459/bin/igor/linux/x64/Igor  -j=8  -options=$1 -v -- Linux Run &
done
