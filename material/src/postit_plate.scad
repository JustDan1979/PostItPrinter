$fn=100;


//translate([0, -30, -15]) postItPlate();

//translate([0, 51, -15]) postItPlate();

difference() {
    union() {
        translate([24, -51, -4]) cube([3, 50, 45]);
        translate([24, -50, 11]) cube([3, 215, 15]);
    }
    union() {
        translate([35 - 10, -50, -2]) rotate([0, 0, 90]) motor();
        translate([30, 155, 19]) rotate([0, 90, 0]) pulley();
        translate([30, -28, 19]) rotate([0, 90, 0]) pulley();
    }
}




translate([40, 0, 12]) rotate([0, 180, 0]) rail(140);





module pulley() {
    translate([0, 0, -10]) cylinder(d=5, h=30);
    cylinder(d=13, h=15);
    cylinder(d=18, h=6);
    translate([0, 0, 15]) cylinder(d=18, h=1);
}

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



module postItPlate() {
    difference() {
        union() {
            translate([0, 20, 4]) cube([80, 80, 6]);
            translate([40 - 2.5, 40, 6]) cube([5, 40, 10 + 15]);
            translate([40, 80, 13 + 15]) rotate([90, 0, 0]) cylinder(d=10, h=40);
        }
        union () {
            translate([1.5, 1.5 + 20, -4]) postIts();
            translate([37, -1 + 40, 12 + 15]) cube([8, 30, 2]);
            translate([37, 51, 12 + 15]) cube([8, 30, 2]);
        }
    }
}




module postIts() {
    cube([77, 77, 10]);
    translate([13, 13, 0]) cube([50, 50, 12]);
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
            cylinder(d=22, h=36);
}