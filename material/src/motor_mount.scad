
module motorMount() {
    translate([.5, 8 + 2, 0]) endCap();
    difference() {
        translate([-5 - 8, -12 + 3, 4]) cube([25, 9, 8]);
        translate([-5 + 2, -13 + 3, 3]) cube([13, 12, 8]);
    }

    translate([4, 0, 1]) {
        translate([12 - 30, -48, -25]) {
            difference() {
                translate([0, -1, -6 + 3]) cube([3, 50, 40]);
                translate([0, 0, -3]) rotate([0, 0, 90]) motor();
            }
        }
    }
}


module endCap() {
    difference() {
        hull() {
            translate([0, 10, 0]) rotate([90, 0, 0]) cylinder(d=29, h=20);
            translate([0, 10, -10]) rotate([90, 0, 0]) cylinder(d=29, h=20);
        }
        union() {
            translate([-4, -10 + 2, 10]) cube([7, 20, 10]);
            hull() {
                translate([0, 12, 0]) rotate([90, 0, 0]) cylinder(d=27, h=20);
                translate([0, 12, -10]) rotate([90, 0, 0]) cylinder(d=27, h=20);
            }
            hull() {
                translate([0, 9, 0]) rotate([90, 0, 0]) cylinder(d=24, h=20);
                translate([0, 9, -10]) rotate([90, 0, 0]) cylinder(d=24, h=20);
            }
        }
    }
}

module pulley() {
    translate([0, 0, -10]) cylinder(d=5, h=30);
    cylinder(d=13, h=15);
    cylinder(d=18, h=6);
    translate([0, 0, 15]) cylinder(d=18, h=1);
}


module motor() {
    cube([42, 33, 42]);

    translate([5, 33, 5])
        rotate([90, 0, 0])
            cylinder(d=3, h=50);


    translate([36, 33, 5])
        rotate([90, 0, 0])
            cylinder(d=3, h=50);

    translate([5, 33, 36])
        rotate([90, 0, 0])
            cylinder(d=3, h=50);

    translate([36, 33, 36])
        rotate([90, 0, 0])
            cylinder(d=3, h=50);

    
    translate([21, 33, 21])
        rotate([90, 0, 0])
            cylinder(d=23, h=37);
}