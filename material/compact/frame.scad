module frame() {
    difference() {
        translate([178, 0, 0]) {
            side();
        }
        translate([170, 20, 20]) {
            rotate([90, 90, 0])
            {
                motor();
                translate([0, 0, -45]) motor();
            }
        }
    }

    difference() {
        side();
        translate([-12, 0, 0])  rotate([0, 90, 0]) endBearingKnockout();
    }

    housing();
    translate([30, -40, -70]) base();

    translate([-16 + 7, -25, -80])
        cube([170 + 3, 50, 2]);
}

module side() {
    hull() {
        translate([-14, 0, 0]) rotate([0, 90, 0]) cylinder(d=60, h=2);
        translate([-14, 45, 0]) rotate([0, 90, 0]) cylinder(d=60, h=2);
        //translate([-14, 40, -25]) cube([2, 80, 50]);
    }
}

module endBearingKnockout() {
    hull() {
        cylinder(d=26, h=8);
        translate([0, -37/2, 0]) cylinder(d=11, h=4);
    }

    hull() {
        cylinder(d=26, h=8);
        translate([0, 37/2, 0]) cylinder(d=11, h=4);
    }


    translate([0, -37/2, -3]) cylinder(d=5, h=10);
    translate([0, 37/2, -3]) cylinder(d=5, h=10);
}