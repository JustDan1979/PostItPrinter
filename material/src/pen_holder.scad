$fn=100;

module penMount() {
    penHolder();
    difference() {
        union() {
            translate([-5, -26 + 3, -1]) cube([10, 34, 2]);
            translate([-5, -24 + 5 - 3, 51 - 4]) cube([10, 33, 2]);
            translate([0, -15 - 1, -1]) cylinder(d=8, h=48);
        }
        union() {
            translate([0, 0, 0]) solenoid();
            translate([0, -15 - 1, -1]) cylinder(d=5, h=56);
        }
    }

    translate([0, 0, -10]) {
        difference() {
            union() {
                translate([-14, -10 - 1, 14]) cube([27, 2, 25]);
                translate([0, -15 - 1, 14]) cylinder(d = 12, h=25);
            }
            union() {
                translate([-10, -6 - 1, 35]) rotate([90, 0, 0]) cylinder(d=4, h=5);
                translate([-10 + 20, -6 - 1, 35 - 16]) rotate([90, 0, 0]) cylinder(d=4, h=5);
                translate([0, -15 - 1, 13]) cylinder(d = 9, h=27);
            }
        }
    }
    %solenoid();
}

module solenoid() {
    cylinder(d=6, h=52);
    translate([0, 0, -2]) cylinder(d=8, h=17);
    translate([-7, -9, 10]) cube([14, 18, 30]);
}

module penHolder() {
    difference() {
        translate([0, 17, -1]) cylinder(d=15, h=50);
        translate([0, 17, -6]) pen();
    }
}

module pen() {
    cylinder(d=1, h=118);
    translate([0, 0, 4]) cylinder(d=5, h=5);
    translate([0, 0, 9]) cylinder(d=11, h=89);
}

