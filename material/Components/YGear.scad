translate([0, 0,  -24]) {
    rotate([0, 0, 10]) {
        import ("./3rdParty/xygear029.stl", convexity=4);
    }
    
    difference() {
        union() {
            cylinder(h=16, d=10, $fn=100);
        
            translate([0, 0, 12]) {
                rotate([90, 0, 0]) {
                    difference() {
                        translate([0, 0, 3]) {
                            cylinder(h=5 + 1, d=7.5, $fn=100);
                        }

                        hull() {
                            translate([0, 0, 5]) {
                                cylinder(h=3, d=5.6, $fn=100);
                            }
                            translate([0, 2, 5]) {
                                cylinder(h=3, d=5.6, $fn=100);
                            }
                        }
                    }
                }
            }
        }
        union() {
            translate([0, 0, 12]) {
                rotate([90, 0, 0]) {
                    cylinder(h=10, d=3, $fn=100);
                }
            }
           	translate([0, 0, 2]) {
        	rotate([0, 0, 90]) {
				cylinder(h=25, d=5, $fn=100);
			}
		}
        }
    }
}

