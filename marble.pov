#include "colors.inc"
#include "glass.inc"
#include "skies.inc"

#declare Obs = <-5 * cos(clock*2*pi/360), 0.2, sin(clock*2*pi/360)>;

// Violet
#declare SoftLight = color rgb <1, .75, 1.25>;
#declare HardLight = color rgb <2, 1.5, 2.5>;

camera
{
    right x*1280/720
    location Obs look_at <0, 1, 0>
}

#declare Glass = texture
{
    pigment
    {
        Col_Glass_General
    }

    finish
    {
        F_Glass9
    }
}

#declare Tore = torus
{
    2, 0.2
    rotate 40
    rotate -20*y
    translate <4 + 1 , 4 + 1, -1.3 + 1>

    texture
    {
        Glass
    }
}

#declare Marble = sphere
{
    <1, 1, 1>, 1

    texture
    {
        Glass
    }

    interior
    {
        ior 1.517
        caustics 0.5
    }
}

#declare Zebra = sphere
{
    <1, 1, 1>, 1
    texture
    {
        pigment
        {
            gradient y-2*z
            color_map
            {
                [ 0.0   HardLight ]
                [ 0.1   SoftLight ]
                [ 0.2   HardLight ]
                [ 0.3   SoftLight ]
                [ 0.4   HardLight ]
                [ 0.5   SoftLight ]
                [ 0.6   HardLight ]
                [ 0.7   SoftLight ]
                [ 0.8   HardLight ]
                [ 0.9   SoftLight ]
                [ 1.0   HardLight ]
            }
        }
        finish
        {
            F_Glass10
        }
    }

    interior
    {
        ior 1.517
        caustics 0.5
    }
}

sky_sphere
{
    pigment
    {
        color SoftLight
        scale 2
        translate -1
    }
}

#declare System = union
{
    light_source
    {
        <0, .3, 0>
        color White
    }

    object { Tore }
    object { Zebra translate <4, 4, -1.3> }

    object { Marble translate <0, .3, 0> }

    object { Marble translate <-5, 0, -2.3> }
    object { Marble translate <-.5, 0, 1> }
    object { Marble translate <.5, 0, 4> }

    object { Marble translate <2, 0, -1> }
    object { Marble translate <2, 0, 4> }
    object { Marble translate <2, 0, -4> }

    object { Marble translate <9, 0, -10> }
    object { Marble translate <10, 0, 2> }
    object { Marble translate <13, 0, -2> }
}

object { System }
