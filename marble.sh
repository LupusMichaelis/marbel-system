#!/bin/sh

output=/tmp/output

generate()
{
    povray \
        "$@" \
        marble.pov \
        +KFI0 +KFF360 \
        +KI0 +KF360 \
        +Q11 \
        +A \
        +O$output/
}

assemble()
{
    local standard="$1"

    ffmpeg \
        -y \
        -i $output/marble%03d.png \
        -q:v 1 \
        -c:v mpeg4 \
        $output/marble-$standard.mkv
}

mkdir -p $output

generate +W640 +H360
assemble 360p

generate +W854 +H480
assemble 480p

generate +W1280 +H720
assemble 720p

generate +W1920 +H1080
assemble 1080p

generate +W3840 +H2160
assemble 2160p

generate +W7680 +H4320
assemble 4320p
