#!/bin/sh
mkdir -p output
povray \
    marble.pov \
    +KFI0 +KFF360 \
    +KI0 +KF360 \
    +W1280 +H720 \
    +Q11 \
    +A \
    +Ooutput/

ffmpeg \
    -y \
    -i output/marble%03d.png \
    -q:v 1 \
    -c:v mpeg4 \
    output/marble.mkv
