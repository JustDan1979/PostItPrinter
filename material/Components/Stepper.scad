module stepper() {
	color("black")
	{
		intersection()
		{
			cube([43, 43, 32], center=true);
			rotate([0, 0, 45])
				cube([55, 55, 32], center=true);
		}
	}
    color("silver")
    {
		translate([0, 0, 16]) {
        	rotate([0, 0, 90]) {
				cylinder(h=25, d=5, $fn=100);
			}
		}
    }
	
	color("white")
	{
		translate([0, 0, 16])
        rotate([0, 0, 90])
            cylinder(h=3, d=22, $fn=100);
		
	}
}
