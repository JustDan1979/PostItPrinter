module mount() {
	difference()
    {
		translate([0,0,0]) {
			cube([44,44,4], center=true); //block to cut from
        }
		
        translate([0,0,-3]) {				//motor hole
			rotate([0,0,0]) {
				cylinder(r=12, h=8, $fn=100);
            }
        }

	//Stepper face mount screw holes
        translate([15.5,15.5,-3]) {				 
            cylinder(r=1.7, h=6, $fn=100);
        }

		translate([-15.5,15.5,-3]) {				
            cylinder(r=1.7, h=6, $fn=100);
        }

		translate([15.5,-15.5,-3]) {				
            cylinder(r=1.7, h=6, $fn=100);
        }

		translate([-15.5,-15.5,-3]) {				
            cylinder(r=1.7, h=6, $fn=100);
        }


	//Stepper face mount screw holes
        translate([15.5,15.5,-3]) {				 
            cylinder(d=6, h=3, $fn=100);
        }

		translate([-15.5,15.5,-3]) {				
            cylinder(d=6, h=3, $fn=100);
        }

		translate([15.5,-15.5,-3]) {				
            cylinder(d=6, h=3, $fn=100);
        }

		translate([-15.5,-15.5,-3]) {				
            cylinder(d=6, h=3, $fn=100);
        }
	}
}
