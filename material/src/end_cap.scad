module endCap() {

    difference() {
        hull() {
            translate([0, 0, 0]) rotate([90, 0, 0]) cylinder(d=29, h=10);
            translate([0, 0, -10]) rotate([90, 0, 0]) cylinder(d=29, h=10);
        }
        union() {
            hull() {
                translate([0, 2, 0]) rotate([90, 0, 0]) cylinder(d=27, h=10);
                translate([0, 2, -10]) rotate([90, 0, 0]) cylinder(d=27, h=10);
            }
            hull() {
                translate([0, -1, 0]) rotate([90, 0, 0]) cylinder(d=24, h=10);
                translate([0, -1, -10]) rotate([90, 0, 0]) cylinder(d=24, h=10);
            }
        }
    }
}