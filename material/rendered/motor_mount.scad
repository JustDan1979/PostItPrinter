$fn=100;
/*
translate([0, 177, 0]) rotate([90, 0, 0]) cylinder(d=6, h=177);

translate([67, 177, 0]) rotate([90, 0, 0]) cylinder(d=6, h=177);

translate([15, 0, -10]) rotate([270, 0, 0]) motor();

translate([-5, 60, -1]) postIts();

translate([0, 200, 0]) cylinder(d=15, h=11);
*/

difference() {
    union() {
        cube([80, 80, 6]);
        translate([0, 0, 5]) cube([6, 80, 7]);
        translate([74, 0, 5]) cube([6, 80, 7]);
        translate([6, 38, 5]) cube([5, 7, 7]);
    }
    union () {
        translate([1.5, 1.5, -8]) postIts();
        translate([3, 0, 12]) rails();
        translate([7, 37, 8]) cube([2, 9, 8]);
    }
}

module postIts() {
    cube([77, 77, 10]);
    translate([13, 13, 0]) cube([50, 50, 12]);
    translate([23, 23, 0]) cube([30, 30, 15]);
}



module rails() {
    translate([0, 176, 0]) rotate([90, 0, 0]) cylinder(d=6, h=177);
    translate([74, 176, 0]) rotate([90, 0, 0]) cylinder(d=6, h=177);
}


module bearingPlate() {
    difference() {
        union() {
    translate([-8 + 4, -47, -4]) cube([120, 5, 50]);

        }
        union() {
    translate([21, -38, 21])
    rotate([90, 0, 0])
        bearing();

    translate([21 + 35, -38, 21])
    rotate([90, 0, 0])
        cylinder(d=10, h=30);

    translate([21 + 70, -38, 21])
    rotate([90, 0, 0])
        bearing();

        }


    }
}

module bearing() {
    cylinder(d=22, h=7);
    translate([0, 0, -2])
        cylinder(d=8, h=12);

}

module motor() {
    cube([42, 33, 42]);

    translate([5, 33, 5])
        rotate([90, 0, 0])
            cylinder(d=4, h=50);

    translate([5, 33 - 38, 5])
        rotate([90, 0, 0])
            cylinder(d=8, h=50);


    translate([36, 33, 5])
        rotate([90, 0, 0])
            cylinder(d=4, h=50);

    translate([36, 33 - 38, 5])
        rotate([90, 0, 0])
            cylinder(d=8, h=50);

    translate([5, 33, 36])
        rotate([90, 0, 0])
            cylinder(d=4, h=50);

    translate([5, 33 - 38, 36])
        rotate([90, 0, 0])
            cylinder(d=8, h=50);

    translate([36, 33, 36])
        rotate([90, 0, 0])
            cylinder(d=4, h=50);

    translate([36, 33 - 38, 36])
        rotate([90, 0, 0])
            cylinder(d=8, h=50);


    translate([21, 33, 21])
        rotate([90, 0, 0])
            cylinder(d=22, h=50);
}