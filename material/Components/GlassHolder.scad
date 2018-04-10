module glassHolder() {
    union() {
        intersection() {
            translate([-4, 0, -5]) {
                cube([PlateWidth + 8, PlateLength, 20]);
            }
            translate([52, 74, 2]) {
               rotate([0, 0, 90]) {
                  import("./3rdParty/ystage.stl", convexity=4);
               }
            }
        }
    
        translate([0, PlateLength - 3, 2]) {
            %cube([PlateWidth, 3, 2]);
        }

        translate([-4, 0, 2]) {
            cube([26, PlateLength, 2]);
        }

        translate([-22 + PlateWidth, 0, 2]) {
            cube([26, PlateLength, 2]);
        }
        
        // left side
        translate([-4, 0, -1]) {
            cube([6, PlateLength, 1]);
            translate([0, 0, 1]) {
                cube([3, PlateLength, PlateThickness + .1]);
            }
        }
        
        // right side
        translate([1 + PlateWidth - 3, 0, -1]) {
            cube([6, PlateLength, 1]);
            translate([3, 0, 1]) {
                cube([3, PlateLength, PlateThickness + .1]);
            }
        }
    }
}
