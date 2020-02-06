
module insert() {
    endCap();
    translate([50, 0, 0]) rotate([0, 0, 180]) middleInsert();
}

module endCap() {
    prong();
    rotate([360/3, 0, 0]) prong();
    rotate([2 * 360/3, 0, 0]) prong();
    difference() {
        rotate([0, 90, 0]) cylinder(d=44, h=4);
        union() {
            translate([-5, 0, 0]) rotate([0, 90, 0]) nut();
            translate([5, 0, 0]) xAxisKnockout();
        }
    }
}

module middleInsert() {
    prong();
    rotate([360/3, 0, 0]) prong();
    rotate([2 * 360/3, 0, 0]) prong();
    difference() {
        rotate([0, 90, 0]) cylinder(d=44, h=4);
        union() {
            translate([-1, 0, 0]) rotate([0, 90, 0]) cylinder(d=9, h=6);
            translate([5, 0, 0]) xAxisKnockout();
        }
    }
}


module prong() {
    difference() {
        union() {
            hull() {
                translate([3, -5 - 1.5, 8]) cube([1, 13, 13]);
                translate([11, -5 + 9 + 2.5, 16 - 5])  rotate([90, 0, 0]) cylinder(d=9, h=13);
            }
            hull() {
                translate([11, -5 + 9 + 2.5, 16 - 5])  rotate([90, 0, 0]) cylinder(d=9, h=13);
                translate([11 + 15, -5 + 9 + 2.5, 16 - 5])  rotate([90, 0, 0]) cylinder(d=9, h=13);
            }

            %translate([11, 3, 11]) rotate([90, 0, 0]) vBearing();
        }
        union() {
            translate([3, -3.5, 5]) cube([20 + 10, 7, 20]);
            translate([11, 3, 11]) rotate([90, 0, 0]) vBearing();
        }
    }
}

module nut() {
    cylinder(d=22.5, h=4);
    translate([0, 0, -2]) cylinder(d=10.5, h=14);
    
    translate([7.5, 0, -2]) cylinder(d=3, h=15);
    rotate([0, 0, 90]) translate([7.5, 0, -2]) cylinder(d=3, h=15);
    rotate([0, 0, 180]) translate([7.5, 0, -2]) cylinder(d=3, h=15);
    rotate([0, 0, 270]) translate([7.5, 0, -2]) cylinder(d=3, h=15);
}


module xAxisKnockout() {
    hull() {
        translate([-10, 0, 18]) rotate([0, 90, 0]) cylinder(d=5, h=160);
        translate([-10, 0, 15]) rotate([0, 90, 0]) cylinder(d=5, h=160);
    }

    hull() {
        rotate([360/3, 0, 0]) translate([-10, 0, 18]) rotate([0, 90, 0]) cylinder(d=5, h=160);
        rotate([360/3, 0, 0]) translate([-10, 0, 15]) rotate([0, 90, 0]) cylinder(d=5, h=160);
    }

    hull() {
        rotate([2 * 360/3, 0, 0]) translate([-10, 0, 18]) rotate([0, 90, 0]) cylinder(d=5, h=160);
        rotate([2 * 360/3, 0, 0]) translate([-10, 0, 15]) rotate([0, 90, 0]) cylinder(d=5, h=160);
    }
}


module bearingArray() {
    translate([10, 0, 0]) {
        translate([0, 3, 11]) rotate([90, 0, 0]) vBearing();
        rotate([360/3, 0, 0]) translate([0, 3, 11]) rotate([90, 0, 0]) vBearing();
        rotate([2 * 360 / 3, 0, 0]) translate([0, 3, 11]) rotate([90, 0, 0]) vBearing();
    }
}

module vBearing() {
    translate([0, 0, -4]) cylinder(d=4,h=20);
    difference() {
        union() {
            hull() {
                cylinder(d=13, h=.5);
                translate([0, 0, 3]) cylinder(d=10, h=.1);
            }
            hull() {
                translate([0, 0, 3]) cylinder(d=10, h=.1);
                translate([0, 0, 5.5]) cylinder(d=13, h=.5);
            }
        }
        {
            translate([0, 0, -1]) cylinder(d=4, h=15);
        }
    }
}
