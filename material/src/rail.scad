module rail(height) {
    difference() {
        hull() {
            translate([0, height + 1, 0]) rotate([90, 0, 0]) cylinder(d=27, h=height);
            translate([0, height + 1, -10]) rotate([90, 0, 0]) cylinder(d=27, h=height);
        }
        union() {
            translate([-3, 0, 4]) cube([6, height + 2, 10]);
            translate([0, height + 2, 0]) rotate([90, 0, 0]) cylinder(d=10.5, h=height + 2);
            translate([-5, 0, 10 - 25]) cube([10, 200, 5]);
        }
    }
}