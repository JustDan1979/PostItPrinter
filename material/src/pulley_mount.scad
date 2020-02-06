
module pulleyMount() {
    translate([.5, 10, 0]) endCap();
//    limitSwitchMount();
    

}

module limitSwitchMount() {
    difference() {
        translate([-5 - 8, -12 + 3, 4]) cube([25, 9, 8]);
        translate([-5 + 2, -13 + 3, 3]) cube([13, 12, 8]);
    }
}

module endCap() {
    difference() {
        hull() {
            translate([0, 10, 0]) rotate([90, 0, 0]) cylinder(d=29, h=34);
            translate([0, 10, -10]) rotate([90, 0, 0]) cylinder(d=29, h=34);
        }
        union() {
            translate([-4, -11, 10 - 2]) cube([7, 20 + 2, 10]);

            translate([8, -20, -6]) rotate([0, 270, 0]) pulley();
            translate([-3 - 1, -22 - 3, 3]) cube([13, 15, 8]);
            hull() {
                translate([0, 12, 0]) rotate([90, 0, 0]) cylinder(d=27, h=20);
                translate([0, 12, -10]) rotate([90, 0, 0]) cylinder(d=27, h=20);
            }
            
            hull() {
                translate([0, 12 - 33 - 4, 0]) rotate([90, 0, 0]) cylinder(d=27, h=20);
                translate([0, 12  - 33 - 4, -10]) rotate([90, 0, 0]) cylinder(d=27, h=20);
            }
            
            hull() {
                translate([0, 9, 0]) rotate([90, 0, 0]) cylinder(d=20, h=40);
                translate([0, 9, -10]) rotate([90, 0, 0]) cylinder(d=20, h=40);
            }
        }
    }
}

module pulley() {
    translate([0, 0, -10]) cylinder(d=5, h=40);
    cylinder(d=13, h=15);
    cylinder(d=18, h=6);
    translate([0, 0, 15]) cylinder(d=18, h=1);
}

