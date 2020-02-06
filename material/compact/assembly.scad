$fn=100;
include <drum.scad>;
include <insert.scad>;
include <ParametricHerringboneGears.scad>;
include <base.scad>;
include <frame.scad>;

//assembly();

//herringboneGear();

//frame();

//translate([120 + 20, 60 + 10, -20]) rotate([-40, 0, 0]) rotate([0, 0, 180]) lcdCase();

//leadScrew();

//housing();

herringboneGear(generate = 1, gear_h = 4);
/*
	generate=1, 
	distance_between_axels = 60, 
	gear_h = 10, 
	gear_shaft_h = 15,
	// GEAR1 (SMALLER GEAR, STEPPER GEAR) OPTIONS:
	// It's helpful to choose prime numbers for the gear teeth.
	gear1_teeth = 13,
	gear1_shaft_d = 5.25,  			// diameter of motor shaft
	// gear1 shaft assumed to fill entire gear.
	// gear1 attaches by means of a captive nut and bolt (or actual setscrew)
	gear1_setscrew_offset = 5,			// Distance from motor on motor shaft.
	gear1_setscrew_d         = 3.5,		
	gear1_captive_nut_d = 6.2,
	gear1_captive_nut_h = 3,


	// GEAR2 (LARGER GEAR, DRIVE SHAFT GEAR) OPTIONS:
	gear2_teeth = 51,
	gear2_shaft_d = 8.5,
	// gear2 has settable outer shaft diameter.
	gear2_shaft_outer_d = 21,

	// gear2 has a hex bolt set in it, is either a hobbed bolt or has the nifty hobbed gear from MBI on it.
	gear2_bolt_hex_d       = 15,
	// gear2_bolt_sink: How far down the gear shaft the bolt head sits; measured as distance from drive end of gear.
	gear2_bolt_sink          = 15,		
	// gear2's shaft is a bridge above the hex bolt shaft; this creates 1/3bridge_helper_h sized steps at top of shaft to help bridging.  (so bridge_helper_h/3 should be > layer height to have any effect)
	bridge_helper_h=3,

	gear2_rim_margin = 0,
	gear2_cut_circles  = 5,

	// gear2 setscrew option; not likely needed.
	gear2_setscrew_offset = 0,
	gear2_setscrew_d         = 0,
	// captive nut for the setscrew
	gear2_captive_nut_d = 0,
	gear2_captive_nut_h = 0
	);
*/
//penMechanism();

module leadScrew() {
    translate([-30, 0, 0]) rotate([0, 90, 0]) cylinder(d=8, h=200);
    translate([150, 0, 0]) rotate([0, 90, 0]) cylinder(d=19, h=25);
}

module xAxis() {
    translate([-10, 0, 18]) rotate([0, 90, 0]) cylinder(d=3, h=200);
    rotate([360/3, 0, 0]) translate([-10, 0, 18]) rotate([0, 90, 0]) cylinder(d=3, h=200);
    rotate([2 * 360/3, 0, 0]) translate([-10, 0, 18]) rotate([0, 90, 0]) cylinder(d=3, h=200);
}

module assembly() {
    drum();
    insert();
    housing();
    leadScrew();

    translate([0, -10, 0]) postIt();
    

    //translate([-5, -3.5, -21]) rotate([0, 0, 90]) motor();

    //translate([0, 60, 0]) penMechanism();
}

module lcdCase() {
    include <reprapdiscount_full_graphic_smart_controller_box.scad>
}

module postIt() {
    color("red") translate([2, -15, 0]) cube([76, .1, 76]);
}

module housing() {
    housingLeft();
    //translate([80, 0, 0]) housingLeft();
    //housingMiddle();
    //housingRight();
}

module housingLeft() {
    difference() {
        union() {
            rotate([0, 90, 0]) cylinder(d=54, h=80);
            translate([0, -27, 0]) cube([80, 1.5, 40]);
        }
        union() {
            ringKnockout();
            translate([76, 0, 0]) ringKnockout();
            
            //translate([-1, -27 - 1, 0]) cube([3, 1.5, 41]);

            translate([-1, 0, 0]) rotate([0, 90, 0]) cylinder(d=51, h=82);
            translate([-1, -25.5, 0]) cube([82, 3, 20]);
        }
    }
}

module ringKnockout() {
    difference() {
        translate([-1, 0, 0]) rotate([0, 90, 0]) cylinder(d=55, h=6);
        translate([-2, 0, 0]) rotate([0, 90, 0]) cylinder(d=52, h=34);
    }
}

module top() {
    difference() {
        rotate([0, 90, 0]) cylinder(d=54, h=80);
        union() {
            translate([-1, 0, 0]) rotate([0, 90, 0]) cylinder(d=51, h=82);
            translate([-1, -42, -32]) cube([82, 82, 40]);
        }
    }
}



module penMechanism() {
    translate([20, 0, 20]) cylinder(d=11, h=110);
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
            cylinder(d=23, h=40);
}