module plate() {
    color("blue", .5) {
        cube([PlateWidth, PlateLength, PlateThickness]);
    }
    translate([52 - 76 / 2, 0, -.1]) {
        cube([76, 76, .1]);
    }
}
