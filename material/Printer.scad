include <./Components/GlassHolder.scad>;
include <./Components/Electronics.scad>;
include <./Components/Stepper.scad>;
include <./Components/Mount.scad>;
include <./Components/Plate.scad>;
include <./Components/Cartridge.scad>;
include <./Components/PostIts.scad>;
include <./Components/YGear.scad>;

PostItWidth=76;
PostItHeight=.1;

PlateWidth = 104;
PlateLength = 150;
PlateThickness = 3;

CartridgeWidth = 30;
CartridgeHeight = 55.2;
CartridgeDepth = 20;

Angle = 0;
//assembly();

xAxisMotorMount();
translate([0, 0, 18]) {
    rotate([180, 0, 0]) {
        //stepper();
    }
}



mount();

module assembly() {
    translate([-20, 51 - 12, -20]) {
        rotate([0,90,0]) {
            cylinder(d=6.35,h=150,$fn=50);
        }
    }

    translate([-20, 51 - 12, -40]) {
        rotate([0,90,0]) {
            cylinder(d=6.35,h=150,$fn=50);
        }
    }

    %translate([-20, 0, -65]) {
        difference() {
            cube([150, 80 + 20, 135]);
            translate([5, -5, 5]) {
                cube([140, 90 + 20, 125]);
            }
        }
    }

    // x stepper
    translate([50, 50, 40]) {
        rotate([180, 0, 0]) {
            stepper();
        }
    }

    // y stepper
    translate([102, 50 + 5, 44]) {
        rotate([90, 0, 0]) {
            stepper();
        }
    }

    translate([117, 25, 43]) {
        rotate([90, 0, 0]) {
            cylinder(d=15,h=5, $fn=100);
        }
    }

    translate([-8, 25, 37]) {
        rotate([90, 0, 0]) {
            cylinder(d=15,h=5, $fn=100);
        }
    }

    translate([-8, 25, -30]) {
        rotate([90, 0, 0]) {
            cylinder(d=15,h=5, $fn=100);
        }
    }

    translate([117, 25, -30]) {
        rotate([90, 0, 0]) {
            cylinder(d=15,h=5, $fn=100);
        }
    }

    translate([100, 60, -5]) {
        rotate([0, 90, 90]) {
            electronics();
        }
    }

    translate([51, 38,  2]) {
        rotate([0, 0, 10]) {
            import ("xygear029.stl", convexity=4);
        }

    }


    union() {
    translate([52, 76, 2]) {
        rotate([0, 0, 90]) {
            import("Ingenious Lappi.stl", convexity=4);
        }
    }
    translate([0, PlateLength - 3, 2]) {
        cube([PlateWidth, 3, 2]);
    }


    translate([-2, 0, 2]) {
        cube([24, PlateLength, 2]);
        }

    translate([-22 + PlateWidth, 0, 2]) {
        cube([24, PlateLength, 2]);
        }
    plate();

    glassHolder();
        
        translate([50, 80, 21]) {
            yMount();
        }
    }

    translate([80, 24 + 5, 3]) {
        rotate([0, 180, 180]) {
            cartridgeAdapter();
        }
    }

    translate([80 - PostItWidth - 10, 24 + 5, 3]) {
        rotate([0, 180, 180]) {
            cartridgeAdapter();
        }
    }
}
