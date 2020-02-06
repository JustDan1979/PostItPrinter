module xAxis() {
    difference() {
        translate([-15, 20, -25]) cube([30, 20, 35]);
        hull() {
            translate([0, 141, 0]) rotate([90, 0, 0]) cylinder(d=27, h=140);
            translate([0, 141, -10]) rotate([90, 0, 0]) cylinder(d=27, h=140);
        }
    }
}