module cartridge(x, y) {
    color("gray")
    {
		difference()
		{
			translate([y, x, 1])
			{
				cube([CartridgeWidth, CartridgeDepth, CartridgeHeight]);
			}
			translate([y + 2, x + 2, 1 + 2])
			{
				cube([CartridgeWidth - 4, CartridgeDepth, CartridgeHeight - 4]);
			}
		}
    }
	
}

module cartridgeAdapter() {
    hull() {
        difference() {
        difference() {
            union()   {
                translate([-4, -5, 5])                {
                    union()                    {
                        cube([37, 29, 55]);
                    }
                }
            }
            union()            {
                translate([-1, 0, 4])                {
                    translate([0, 0, 2])
                        cube([31, 21, 37 + 60]);
                    translate([31 - 3 - 3, -3, 0])
                        cube([3, 4, 200]);
                    translate([2, -1, 0])
                        cube([25, 2, 200]);

                }
                translate([0, 0, 4])
                    cube([30-6 + 5, 25, 57]);
            }
        }
    }
        translate([0, -15, 12]) {
        cube([30, 10, 40]);
    }
    }
}
