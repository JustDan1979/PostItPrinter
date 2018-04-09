

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
 
translate([0, -80, 0]) {
    glassHolder();
}

module yMount() {
    rotate([90, 0, 0]) {
        mount();
    }

    translate([0, -42, 16]) {
        rotate([180, 0, 0]) {
           // stepper();
        }
    }
}


module plate() {
    color("blue", .5) {
        cube([PlateWidth, PlateLength, PlateThickness]);
    }
    translate([52 - 76 / 2, 0, -.1]) {
        cube([76, 76, .1]);
    }
}

module postIts() {
    color("yellow")
    cube([PostItWidth, PostItWidth, PostItHeight]);
}

module glassHolder() {
 
       union() {
           intersection() {
        translate([-4, 0, -5]) {
           cube([PlateWidth + 8, PlateLength, 20]);
        }
    translate([52, 74, 2]) {
        
        rotate([0, 0, 90]) {
            import("Ingenious Lappi.stl", convexity=4);
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
module electronics() {
    color("green", 0.5) {
        cube([55, 100, 40]);
    }
}
module mount() {
	
	difference(){
		translate([0,0,31.15 + 10])
			cube([88.3 - 37,25,62.3 - 15], center=true); //block to cut from
		translate([0,3,24 + 10]){
			cube([42.3,21,78.3], center=true);}	//rear cutout
		translate([0,-4.65,41.15]){				//motor hole
			rotate([90,0,0]){
				cylinder(r=11.5, h=8, $fn=100);}}
		translate([35.15,0,43.75]){				//Top right cutout
			cube([18.5,26,37.5],center=true);}
		translate([32.65,3,10]){					//Bottom right cutout
			cube([23.5,21,21],center=true);}
		translate([-35.15,0,43.75]){				//Top left cutout
			cube([18.5,26,37.5],center=true);}
		translate([-32.65,3,10]){					//Bottom left cutout
			cube([23.5,21,21],center=true);}

	//T-Slot Screw Mounts
		translate([0,-7,10]){						//Inside edge T-slot mount
			rotate([90,0,0]){
				cylinder(r=2.65, h=6);}}
		translate([34.2,-10,10]){					//Inside edge T-slot mount
			rotate([90,0,0]){
				cylinder(r=2.65, h=6, center=true);}}
		translate([-34.2,-10,10]){					//Inside edge T-slot mount
			rotate([90,0,0]){
				cylinder(r=2.65, h=6, center=true);}}
		translate([-34.2,2.5,23]){					//Top T-slot mount
				cylinder(r=2.65, h=6, center=true);}
		translate([34.2,2.5,23]){					//Top T-slot mount
				cylinder(r=2.65, h=6, center=true);}
            
	//Stepper face mount screw holes
		translate([15.5,-7,57]){				 
			rotate([90,0,0]){
				cylinder(r=1.7, h=6, $fn=100);}}
		translate([-15.5,-7,57]){				
			rotate([90,0,0]){
				cylinder(r=1.7, h=6, $fn=100);}}
		translate([15.5,-7,25.65]){				
			rotate([90,0,0]){
				cylinder(r=1.7, h=6, $fn=100);}}
		translate([-15.5,-7,25.65]){				
			rotate([90,0,0]){
				cylinder(r=1.7, h=6, $fn=100);}}
	}


}
module stepper() {
	color("black")
	{
		intersection()
		{
			cube([43, 43, 47], center=true);
			rotate([0, 0, 45])
				cube([55, 55, 47], center=true);
		}
	}
    color("silver")
    {
		translate([0, 0, 18])
        rotate([0, 0, 90])
			cylinder(h=20, r=2, $fn=100);
    }
	color("white")
	{
		translate([0, 0, 24])
        rotate([0, 0, 90])
            cylinder(h=5, r=7.5, $fn=100);
		
	}
}

module yAxis() {
	union()
	{
	translate([-15, 5, -3])
		rotate([0, 90, 0])
			cylinder(r=3.5, h=200,$fn=100);

	translate([-15, PostItWidth + 5 - 5, -3])
		rotate([0, 90, 0])
			cylinder(r=3.5, h=200,$fn=100);


	translate([-15, PostItWidth / 2 + 5 - 5 / 2 - 70, -3])
		rotate([0, 90, 0])
			cylinder(r=3.5, h=200,$fn=100);


	translate([-15, PostItWidth / 2 + 5 - 5 / 2 + 70, -3])
		rotate([0, 90, 0])
			cylinder(r=3.5, h=200,$fn=100);
	}
	
}


module printPlate() {
	
	
    color("blue")
    {
        difference()
        {
			
			hull()
			{
				translate([0, 0, -8])
					cube([PostItWidth + 5, PostItWidth + 5, 12]);
				translate([0, -2, -2])
					rotate([0, 90, 0])
						cylinder(r=4, h=PostItWidth + 5,$fn=100);
			}
			translate([2.5, 2.5, 2])
				cube([PostItWidth, PostItWidth, 2]);
		
			union()
			{
				translate([-5, 5, -3])
					rotate([0, 90, 0])
						cylinder(r=4, h=205,$fn=100);
				translate([-5, PostItWidth + 5 - 5, -3])
					rotate([0, 90, 0])
						cylinder(r=4, h=205,$fn=100);
				translate([-5, -2, -3])
					rotate([0, 90, 0])
						cylinder(r=2, h=205,$fn=100);

				translate([PostItWidth / 2 - 5,  3 - 10 - 2, -3])
					rotate([0, 90, 90])
						cylinder(r=2, h=6,$fn=100);

				translate([PostItWidth / 2 - 5 + 5,  3 - 10 - 2, -3])
					rotate([0, 90, 90])
						cylinder(r=2, h=6,$fn=100);


				}
			
        }
    }
}

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

module yAxisStepperMount() {
	difference()
	{
		union()
		{
			rotate([90,0, 0])
				translate([-5 - 30, -10, -30 +2])
				{
					//Stepper();
					translate([41, 0, 14])
						rotate([270, 0, 90])
							mount();
				}
			rotate([90, 0, 90])
				translate([-40, -35.6, -15])
					cube([160, 51.3, 7]);
		}
		union()
		{
			translate([-1, 0, 0])
				yAxis();
			hull()
			{
			translate([-20, -2, -3])
				rotate([0, 90, 0])
					cylinder(r=3, h=205,$fn=100);
			translate([-20, -2, -3 - 15])
				rotate([0, 90, 0])
					cylinder(r=3, h=205,$fn=100);
			}
		}
	}		
}

module yAxisEndPlate() {
	translate([210, 0, 0])
	{
	difference()
	{
		union()
		{
			rotate([90, 0, 90])
				translate([-40, -35.6, -15])
					cube([160, 51.3, 7]);

			difference()
			{
				hull()
				{
					rotate([90, 0, 90])
						translate([-40 + 20, -35.6, -15])
							cube([120, 51.3, 7]);

							
					rotate([90,0, 0])
					{
						translate([3, -10, -100])
						{
							difference()
							{
								cylinder(h=120, r=11, $fn=100);
							}
						}
					}
				}
				rotate([90,0, 0])
				{
					translate([3, -10, -100])
					{
							translate([0, 0, -1])
							cylinder(h=122, r=2.2, $fn=100);
					}
					translate([-15, -22, -3])
							{
								cube([30, 28, 7]);
							}
				}
			}
		}
		union()
		{
			translate([-192, 0, 0])
				yAxis();
			hull()
			{
			translate([-20, -1, -3])
				rotate([0, 90, 0])
					cylinder(r=3, h=14,$fn=100);
			translate([-20, -2, -3 - 15])
				rotate([0, 90, 0])
					cylinder(r=3, h=14,$fn=100);
			}
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

module xAxisMotorMount() {
    translate([10, 0 , 25])
        rotate([90, 0, 0])
            difference()
            {
                mount();
                translate([-30, -8 , 18])
                    cube([60, 30, 60]);
            }
}

module cart() {
translate([65, 10, 12])
{
    rotate([0, 0, 270])
    {
        cartridgeAdapter();
       // cartridge();
    }
}


}
module simpleMount() {
  
	difference(){
        union()
        {
		translate([0,0,31.15 + 10])
			cube([88.3 - 37,5,62.3 - 15], center=true); //block to cut from
		translate([0,-4.65,41.15]){				//motor hole
			rotate([90,0,0]){
				cylinder(r=11.5, h=8, $fn=100);}}
            }
            union()
            {
	//Stepper face mount screw holes
		translate([15.5,-7,57]){				 
			rotate([90,0,0]){
				%cylinder(r=1.7, h=6, $fn=100);}}
		translate([-15.5,-7,57]){				
			rotate([90,0,0]){
				cylinder(r=1.7, h=6, $fn=100);}}
		translate([15.5,-7,25.65]){				
			rotate([90,0,0]){
				cylinder(r=1.7, h=6, $fn=100);}}
		translate([-15.5,-7,25.65]){				
			rotate([90,0,0]){
				cylinder(r=1.7, h=6, $fn=100);}}
	}
}
}

module xAxis(){
	translate([0, 120, 10])
		rotate([90, 0, 0])
			cylinder(r=3.5, h=140,$fn=100);
	translate([30, 120, 10])
		rotate([90, 0, 0])
			cylinder(r=3.5, h=140,$fn=100);
}
module leftBracket() {

    translate([30, 10, 45])
    {
        difference()
        {
            union()
            {
                translate([-11- 4,-45, -81])
                    cube([45, 15, 96]);
                //intersection()
                {
                    
                    translate([7, -38 - 57 - 5 + 20 - 22 - 5, 6.5])
                        rotate([270, 0, 0])
                            simpleMount();
                }
            }
            union()
            {
                translate([-7, -15 - 20,0])
                    xAxis();
                translate([-1, -46, 5])
                    cube([16, 25, 12]);
            }
        }
        
    }
}

module rightBracket() {

    translate([30, 10, 45])
    {
        difference()
        {
            union()
            {
                translate([-11- 4,-45, -81])
                    cube([45, 15, 96]);
                intersection()
                {
                    translate([-21 + 6, -45, 14])
                        cube([45, 15, 5]);

                  
                }
            }
            translate([0, -10, 0])
            {
            %union()
            {
                translate([7, -37, 5-5])
                    cylinder(h=100, r=1.5,$fn=100);
                
                translate([-7, -15 - 20,0])
                    xAxis();
                translate([-1, -46, 5])
                    cube([16, 25, 12]);
            }
        }
        }
        
    }
}


module xCart() {
    difference()
    {
        union()
        {
        translate([18 - 18, 30, 48])
            cube([68, 30,  11]);
        translate([54, 30, 49])
            cube([14, 30,  15]);
        }
        union()
        {
            translate([31, 29, 50])
                cube([15, 35, 6]);
            translate([38, 45-10, 40])
                cylinder(h=100, r=1.5, $fn=100);
            translate([38 + 24, 45, 40])
                cylinder(h=100, r=1.5, $fn=100);
            translate([23, 0, 44])
                xAxis();
            
            translate([10, 50, 0])
                cart();
        }
    }
    difference()
    {
        translate([0, 40, 59])
            cube([54, 20,25]); 
        union()
        {
            translate([6, 39, 59])
                cube([42, 28,22]); 
        }
    }
}















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
