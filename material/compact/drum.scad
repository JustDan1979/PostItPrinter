module drum() {
    difference() {
        rotate([0, 90, 0]) cylinder(d=50, h=80);
        union() {
            translate([-1, 0, 0]) rotate([0, 90, 0]) cylinder(d=45, h=82);
            difference() {
                translate([37, 0, 0]) rotate([0, 90, 0]) cylinder(d=51, h=6);
                translate([36, 0, 0]) rotate([0, 90, 0]) cylinder(d=47, h=8);
            }
        }
    }
}
