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

main()
{
    mkdir -p $output

    local resolution="$1"
    case $resolution in
        360p)
            local width=640
            local height=360
        ;;

        480p)
            local width=854
            local height=480
        ;;

        720p)
            local width=1280
            local height=720
        ;;

        1080p)
            local width=1920
            local height=1080
        ;;

        2160p)
            local width=3840
            local height=2160
        ;;

        4320p)
            local width=7680
            local height=4320
        ;;
        *)
            echo "Resolution '$resolution' not supported"
            echo "Available resolutions: 360p, 480p, 720p, 1080p, 2160p, 4320p"
            exit
            ;;
    esac

    generate +W$width +H$height
    assemble $resolution
}

main "$@"
