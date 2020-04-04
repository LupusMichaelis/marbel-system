#include "glass.inc"
#include "colors.inc"
#include "skies.inc"

#declare Obs0 = <-5,0.2,0> ;
#declare Obs = <-5 * cos(clock*2*pi/360), 0.2, sin(clock*2*pi/360)> ;

camera
{
    right x*1280/720
    location Obs look_at <0,1,0>
}

#declare Glass = texture {
	pigment {
		Col_Glass_General
		}
		finish {
			F_Glass5
		}
	}

#declare Tore = torus {
	2,0.2
	rotate 40
	rotate -20*y 
	texture {Glass}
	translate <4 + 1,4 + 1,-1.3 + 1>
}

#declare Marble = sphere {
	<1,1,1>, 1
	texture{Glass}
	interior {
		ior 1.517
		caustics 0.5
	}
}

// Violet
#declare SoftLight = color rgb <0.4,0.3,0.5> ;
#declare HardLight = color rgb <4,3,5> ;

sky_sphere {
	pigment {
        color rgb <1,.75,1.25>
        scale 2
        translate -1
	}
}

#declare System = union {
	light_source {
		<0,.3,0>
		color White
	}
	object { Tore }
	object { Marble translate <0,.3,0> }
	object { Marble translate <4,4,-1.3> }
	
	object { Marble translate <-5,0,-2.3> } // Obs 1
	object { Marble translate <-.5,0,1> }
	object { Marble translate <.5,0,4> }
	
	object { Marble translate <2,0,-1> }
	object { Marble translate <2,0,4> }
	object { Marble translate <2,0,-4> }
	
	object { Marble translate <9,0,-10> }
	object { Marble translate <10,0,2> }
	object { Marble translate <13,0,-2> }
}

object { System }
