//include <BIG_GEAR_FILE.scad> 

$fn = 60;
//$fn = 12;

outerD = 9;
innerD = 4.5;
height = 17;

//xArray = [-3, 57,  55,  10, -26]; //WITH MIDDLE PIN
//yArray = [38, 31, -56, -22, -33]; //WITH MIDDLE PIN

xArray = [-3, 57,  55,  -26]; //NO MIDDLE PIN
yArray = [38, 31, -56,  -33]; //NO MIDDLE PIN

module cover () {
	translate([-35, 27, height + 10]) {
		
		difference () {
			union() {
				cube([62, 75, 39], center = true);
				translate([-11, -45, 0]) cube([40, 20, 39], center = true);
			}
			translate([-11, -42, -1.5]) cube([37, 20, 39], center = true);
			translate([0, 1.5, -1.5]) cube([59, 72.5, 39], center = true);
			translate([25, 15, -5]) cube([10, 10, 25], center = true);
			translate([-5, -40, 0]) { //"Charging Hole"
				rotate([90, 0, 0]) cylinder(r = 13.5 / 2, h = 40, center = true);
				translate([0, 0, -10]) cube([13.5, 40, 20], center = true);
			}
			translate([-20, -40, 0]) { //Audio jack
				rotate([90, 0, 0]) cylinder(r = 8 / 2, h = 40, center = true);
				translate([0, 0, -10]) cube([8, 40, 20], center = true);
			}
			translate([35, -40, 0]) rotate([0, 0, 45]) cube([30, 40, 40], center = true);
			translate([0, 20, 0]) {
				intersection() {
					cube([45, 20, 40], center = true);
					union() {
						rotate([0, 0, 35]) cube([2, 45, 40], center = true);
						translate([5, 0, 0]) rotate([0, 0, 35]) cube([2, 45, 40], center = true);
						translate([-5, 0, 0])rotate([0, 0, 35]) cube([2, 45, 40], center = true);
						translate([10, 0, 0])rotate([0, 0, 35]) cube([2, 45, 40], center = true);
						translate([-10, 0, 0])rotate([0, 0, 35]) cube([2, 45, 40], center = true);
						translate([15, 0, 0])rotate([0, 0, 35]) cube([2, 45, 40], center = true);
						translate([-15, 0, 0])rotate([0, 0, 35]) cube([2, 45, 40], center = true);
						translate([20, 0, 0])rotate([0, 0, 35]) cube([2, 45, 40], center = true);
						translate([-20, 0, 0])rotate([0, 0, 35]) cube([2, 45, 40], center = true);
						translate([25, 0, 0])rotate([0, 0, 35]) cube([2, 45, 40], center = true);
						translate([-25, 0, 0])rotate([0, 0, 35]) cube([2, 45, 40], center = true);
					}
				}
			}
		}
	}
}


module hex (d, h) {
	c = .5778;
	cube([d, d * c, h], center = true);
	rotate([0, 0, 60]) cube([d, d * c, h], center = true);
	rotate([0, 0, 120]) cube([d, d * c, h], center = true);
}

module pins (len, w) {
	translate ([w / 2, 0, -len / 2]) {
		cube([.333, .333, len], center = true);
	}
	translate ([-w / 2, 0, -len / 2]) {
		cube([.333, .333, len], center = true);
	}
}

module led_5mm (posArr, rotArr) {
	translate (posArr) {
		rotate (rotArr) {
			cylinder(r = 2.5, h = 5.5, center = true);
			translate ([0, 0, 2.75]) {
				sphere(r = 2.5, center = true);
			}
			translate ([0, 0, -3.25]) {
				difference () {
					cylinder(r = 3, h = 1, center = true);
					translate ([0, 3.5, 0]) {
						cube([6, 2, 3], center = true);
					}
				}
			}
			pins(20, 4);
		}
	}
}

module photoresistor (posArr, rotArr) {
	translate (posArr) {
		rotate (rotArr) {
			cylinder(r = 7.3 / 2, h = 2, center = true);
		}
	}
	pins(20, 5);
}

//led_5mm([0, 0, 0], [0, 180, 0]);

/* OLD */
module bolex_pin_old(x, y) {
	translate ([x, y, 0]) {
		difference () {
			cylinder(r = outerD / 2, h = height, center = true);
			cylinder(r = innerD / 2, h = height, center = true);
		}
	}
}

module bolex_pin(x, y) {
	in = innerD;
	translate ([x, y, 1]) {
		difference () {
			union () {
				translate([0, 0, (height / 2) - 2]) cylinder(r = (outerD + 4) / 2, h = 4, center = true);
				cylinder(r = outerD / 2, h = height, center = true);
			}
			cylinder(r = in / 2, h = height, center = true);
			translate([0, 0, (height / 2) - 1]) cylinder(r1 =4.5 / 2, r2 = 6.5 / 2, h = 2, center = true);
		}
	}
}

module intval_pins () {
	for (i = [0 : len(xArray) - 1]) {
		bolex_pin(xArray[i], yArray[i]);
	}
}

module bolex_pin_inner (x, y) {
	translate ([x, y, 1]) {
		cylinder(r = innerD / 2, h = height * 2, center = true);
		translate([0, 0, (height / 2) - 1]) cylinder(r1 =4.5 / 2, r2 = 6.5 / 2, h = 2, center = true);
	}
}

module onetoone (size, height, z) {
	x = 54.5;
	y = 12;
	translate ([x, y, z]) {
		cylinder(r = size / 2, h = height, center = true);
	}
}

module frame_counter_access () {
	x = 37.5;
	y = 39;
	translate([x, y, 8.5]) {
		difference () {
			union () {
				rotate ([0, 0, 10]) {
					translate([0, 8, 0]) {
						cube([12, 16, 4], center = true);
					}
				}
				rotate ([0, 0, -10]) {
					translate([0, 8, 0]) {
						cube([12, 16, 4], center = true);
					}
				}
			}
			translate([0, 15.5, 0]) {
				cube([17, 6, 4], center = true);
			}
		}
		cylinder(r = 7, h = 4, center = true);
	}	
}

module intval_panel () {
	difference () {
		union () {
			difference () {
				translate ([0, 0, 8.5]) {
					cube([129, 131, 2], center = true);
					translate([(129 / 2) - 8, 12, 0]) cylinder(r = 29 / 2, h = 2, center = true);
				}
				for (i = [0 : len(xArray) - 1]) {
					bolex_pin_inner(xArray[i], yArray[i]);
				}
			}
			onetoone(26, 10, 4.5);
			//extends for onetoone
			big_gear_fitting(14.45 + 8.5 + 1.5, -4.65 - 12 - 1, 4.5);
			intval_pins();
		}

		bearing(14.45 + 8.5 + 1.5, -4.65 - 12 - 1, 6); //big gear
		big_gear_axis(14.45 + 8.5 + 1.5, -4.65 - 12 - 1);
		big_gear_mount(14.45 + 8.5, -4.65 -12, 29, 0, .2) //big gear mounts hole

		 //small gear
		onetoone(9, 14, 8.5);
		bearing(54.5, 12, 6);
		frame_counter_access();

		//opto
		opto_mount_holes(42, 29.5, 20, 5.4);
	}

}

module intval_panel_test() {
	$fn = 32;
	difference () {
		intval_panel();
		translate([-54, 0, 0]) rotate([0, 0, -18]) cube([60, 160, 20], center = true);
		translate([4, -60, 0]) rotate([0, 0, -25]) cube([60, 60, 20], center = true);
		translate([70, -15, 0]) rotate([0, 0, 0]) cube([60, 25, 20], center = true);
	}

}
module intval_panel_samp () {
	difference () {
		union () {
			difference () {
				translate ([0, 0, 8.5]) {
					translate([24, -16, 0]) rotate([0, 0, 45]) cube([80, 80, 2], center = true);
					//translate([(129 / 2) - 8, 12, 0]) cylinder(r = 29 / 2, h = 2, center = true);
				}
				//for (i = [0 : len(xArray) - 1]) {
					//bolex_pin_inner(xArray[i], yArray[i]);
				//}
			}

			//extends for onetoone
			big_gear_fitting(14.45 + 8.5 + 1.5, -4.65 - 12 - 1, 4.5);

		}

		bearing(14.45 + 8.5 + 1.5, -4.65 - 12 - 1, 6); //big gear
		big_gear_axis(14.45 + 8.5 + 1.5, -4.65 - 12 - 1);
	}
}

//intval_panel_samp();

module big_gear (x, y, z) {
	translate ([x, y, z]) {
		difference () {
			union (){
				translate ([-19.1, 29, 22]) {
					rotate ([180, 0, 0]) {
						//import("DrivenGear_fixed.stl");
						translate ([.8, 33.7, 0])  big_gear_new();
					}
				}
				translate([14.45, -4.65, 16]) {
					translate([0, 0, -4.5]) cylinder(r = 10.5 / 2, h = 5, center = true);
					translate([0, 0, -9.5]) cylinder(r = 8 / 2, h = 15, center = true);
					//translate([0, 0, -3.5]) cylinder(r = 12 / 2, h = 5, center = true);
					translate([0, 0, -3]) rotate([0, 0, 30]) hex(14, 6);
				}
			}
			translate ([14.45, -4.65, 28.1]) {
				//cube([54, 54, 12], center = true);
				//cylinder(r = 9 / 2, h = 100, center = true);
			}
		}
	}
}

module big_gear_fitting (x, y, z) {
	translate ([x, y, z]) {
		//bearing(0, 0, 0);
		cylinder(r = 26 / 2, h = 10, center = true);
	}
}

module big_gear_axis (x, y) {
	translate ([x, y, 0]) {
		cylinder(r = 9 / 2, h = 100, center = true);
	}
}

module stepper_mount(posArr = [0, 0, 0]) {
	height = 20;
	module screw_holes () {
		for (i = [0 : 3]) {
			rotate([0, 0, 90 * i]) {
				translate([15.75, 15.75, 0]){
					cylinder(r = 2, h = height, center = true);
				}
			}
		}
	}
	translate(posArr) {
		difference () {
			translate([0, 0, -2]) cube([46, 46, 9], center = true);
			translate([0, 0, 1]) cube([42, 42, 12], center = true);
			screw_holes();
			cylinder(r = 11, h = height, center = true);
		}
	}
}

module big_gear_lock (x, y, z, r) {
	span = 80;
	height = 9;
	translate ([x, y, z]) {
		difference() {
			union () {
				translate ([0, 0, 1]) {
					//cylinder (r = 36 / 2, h = height, center = true); //DC MOTOR
				}
				translate ([0, 0, 1]) {
					rotate ([0, 0, r]) {
						cube([9, span, height], center = true);
						translate ([0, span / 2, 0]) {
							cylinder(r = 4.5, h = height, center = true); //top
						}
						translate ([0, -span / 2, 0]) {
							cylinder(r = 4.5, h = height, center = true); //bottom
						}
						translate ([-span / 2, 0, 0]) {
							cylinder(r = 4.5, h = height, center = true); //left
							//cube here
							translate([8, 0, 0]) cube([15, 9, height], center = true);
						}
					}
				}
			}

			rotate([0, 0, 45]) cube([46, 46, 13], center = true); //for stepper
			/*
			//DC MOTOR
			translate ([0, 0, 3]) {
				cylinder(r = 32 / 2, h = height - 3, center = true);
			}
			translate ([0, 0, 0]) {
				cylinder(r = 5, h = 40, center = true);
			}
			translate ([20, 0, 0]) {
				cube([40, 10, 40], center = true);
			}

			translate ([0, 23 / 2, 0]) {
				cylinder(r = 3 / 2, h = 40, center = true); //motor screw hole
			}
			translate ([0, -23 / 2, 0]) {
				cylinder(r = 3 / 2, h = 40, center = true); //motor screw hole
			}
			translate ([-11, 0, 0]) {
				cylinder(r = 3 / 2, h = 40, center = true); //motor screw hole
			}

			translate([16, 0, 5]) {
				cube([32, 32, 10], center = true);
			}
			*/
			rotate ([0, 0, r]) {
				translate ([0, span / 2, 0]) {
					cylinder(r = 2.5, h = 40, center = true);
				}
				translate ([0, -span / 2, 0]) {
					cylinder(r = 2.5, h = 40, center = true);
				}
				translate ([-span / 2, 0,  0]) {
					cylinder(r = 2.5, h = 40, center = true);
				}
			}
		}
		rotate([0, 0, 45]) stepper_mount([0, 0, 3]);
	}
}

module big_gear_mount (x, y, z, r, f = 0) {
	span = 80;
	xOffset = 0;
	//height = 16 + 9;
	height = 22.3;
	translate ([x, y, z]) {
		rotate ([0, 0, r]) {
			difference () {
				union () {
					translate ([xOffset, span / 2, -11.5]) {
						cylinder(r = 4.5 + f, h = height, center = true);
						translate([0, 0, (-height/2) + .5]) cylinder(r = 5.5, h = 1, center = true);
					}
					translate ([xOffset, -span / 2, -11.5]) {
						cylinder(r = 4.5 + f, h = height, center = true);
						translate([0, 0, (-height/2) + .5]) cylinder(r = 5.5, h = 1, center = true);
					}
					translate ([-span / 2 + xOffset , 0, -11.5]) {
						cylinder(r = 4.5 + f, h = height, center = true);
						translate([0, 0, (-height/2) + .5]) cylinder(r = 5.5, h = 1, center = true);
					}
				}
				if (f == 0) {
					translate ([xOffset, span / 2, -11.5]) {
						cylinder(r = 2.6, h = 25, center = true);
					}
					translate ([xOffset, -span / 2, -11.5]) {
						cylinder(r = 2.6, h = 25, center = true);
					}
					translate ([-span / 2 + xOffset , 0, -11.5]) {
							cylinder(r = 2.6, h = height, center = true);
					}
				}
			}
		}
	}
}

module small_gear (x, y, z, rot) {
	arm = 5;
	translate ([x, y, z]) {
		translate([11, 11, 13]) {
			rotate ([0, 0, rot]) {
				translate ([0, 12, 0.2]) {
					cube([7.5, 22, 1.3], center = true);
					translate ([0, 5, 0]) {
						//cylinder(r = 9 / 2, h = 2, center = true);
					}
				}
				cylinder(r1 = 8.5, r2 = 8.5, h = 3, center = true);
			}
		}
		import("DriveGear_fixed2.stl");

		translate ([11, 11, -1]) {
			//cylinder(r = 2.7, h = 40, center = true);
			//translate([0, 0, (-height / 2) - 1]) cylinder(r = 6.7 / 2, h = height, center = true);
			key_end([180, 0, 0], [0, 0, -14]); //moved down a half mm since print
			translate ([0, 0, 8.5]) {
				//cylinder(r = 7.9 / 2, h = 35, center = true); //works with fill .2, not 1.0, trying with .5
				//cylinder(r = 7.1 / 2, h = 35, center = true);
				cylinder(r = 6.1 / 2, h = 35, center = true);
				//translate([0, 0, 10]) cylinder(r = 7.3 / 2, h = 35, center = true);
				//cylinder(r = 7.7 / 2, h = 35, center = true); //fails with fill 1.0
				//cylinder(r = 7.5 / 2, h = 35, center = true); //fails with fill 1.0 //too small at .5 haha
			}
			translate ([0, 0, 7]) {
				cylinder(r = 12 / 2, h = 16.5, center = true);
			}
			translate ([0, 0, 9]) {
				cylinder(r = 12 / 2, h = 16.5, center = true);
			}
		}
	}
}
/*
	Rewind key
*/

module key () {
	difference () {
		cylinder(r = 6.7 / 2, h = 5, center = true, $fn = 20);
		cylinder(r = 4.76 / 2, h = 5, center = true, $fn = 20);
	}
	translate ([0, 0, -7.5]) {
		cylinder(r = 6.7 / 2, h = 10, center = true, $fn = 20);
	}
}

module keyHole () {
	translate ([0, 0, 1.75]) {
		cube([10, 2, 1.5], center = true);
	}
}

module body () {
	translate([0, 0, -13.5]){
		cylinder(r = 5, h = 2, center = true);
	}
	translate([0, 0, -16]) {
		cylinder(r = 5, h = 3, center = true);
		translate([20, 0, 0]) {
			cylinder(r = 5, h = 3, center = true);
		}
		translate([10, 0, 0]){
			cube([20, 10, 3],center = true);	
		}
	}
}

module pinHole () {
	translate([20, 0, -16.5]) {
		cylinder(r = 5.34 / 2, h = 4, center = true);
	}
}

module helper () {
	translate([0, 15, -7.5]) {
		cylinder(r = 6, h = 20, center = true, $fn = 12);
	}
}

module key_end (rotArr = [0, 0, 0], transArr = [0, 0, 0]) {
	translate(transArr) {
		rotate (rotArr) {
			difference () {
				key();
				keyHole();
			}
		}
	}
}

/*
	/Rewind key
*/

module small_gear_top () {
	difference() {
		union () {
			difference(){
				small_gear(0, 0, 0, 0);
				translate([0, 0, -12.5]) cube([50, 50, 50], center = true);
			}
			translate([11, 11, 12]) cylinder(r = 17 / 2, h = 2, center = true);
		}
		translate([11, 11, 12]) cube([3, 3, 6], center = true);
	}
	
	//translate([43.5, 1, 10.5]) translate([9, 14, 8.5]) translate([-11, -11, 0]) cube([3, 3, 101.8]);
	

}
module small_gear_bottom () {
	$fn = 60;
	difference() {
		small_gear();
		translate([0, 0, 24]) cube([80, 80, 24], center = true);
		translate([11, 11, 12]) cube([3, 3, 6], center = true);
	}
}

module small_gear_lock (x, y, z, r) {
	span = 52;
	height = 9;
	xOffset = 5;
	translate ([x, y, z]) {
		difference() {
			union () {
				translate ([0, 0, 1]) {
					cylinder (r = 26 / 2, h = height, center = true);
				}
				/*
				translate ([xOffset, 0, 1]) {
					rotate ([0, 0, r]) {
						cube([9, span, height], center = true);
						translate ([0, span / 2, 0]) {
							cylinder(r = 4.5, h = height, center = true);
						}
						translate ([0, -span / 2, 0]) {
							cylinder(r = 4.5, h = height, center = true);
						}
					}
				}
				*/
				//new fat mount
				translate([-9, -10, 1]) rotate([0, 0, 45]) cube([15, 13, height], center = true);
			}
			bearing(0, 0, 0);
			/*
			rotate ([0, 0, r]) {
				translate ([xOffset, span / 2, 0]) {
					cylinder(r = 2.5, h = 40, center = true);
				}
				translate ([xOffset, -span / 2, 0]) {
					cylinder(r = 2.5, h = 40, center = true);
				}
			}
			//Bolt hole
			*/
		}
	}
}

module small_gear_mount (x, y, z, r) {
	span = 52;
	xOffset = 5;
	translate ([x, y, z]) {
		rotate ([0, 0, r]) {
			difference () {
				union () {
					translate ([xOffset, span / 2, -11.5]) {
						cylinder(r = 4.5, h = 16, center = true);
					}
					translate ([xOffset, -span / 2, -11.5]) {
						cylinder(r = 4.5, h = 16, center = true);
					}
				}
				translate ([xOffset, span / 2, -11.5]) {
					cylinder(r = 2.5, h = 25, center = true);
				}
				translate ([xOffset, -span / 2, -11.5]) {
					cylinder(r = 2.5, h = 25, center = true);
				}
			}
		}
	}
}

module opto (x, y, z, led) {
	translate ([x, y, z]) {
		rotate ([0, 0, 35]) {
			difference () {
				union () {
					translate ([0, 0, 2]) {
						cube([10, 12, 30], center = true);
					}
					translate ([1, 0, -10]) {
						cube([11, 12, 1], center = true);
					}
					translate ([-1, 0, -10]) {
						cube([11, 12, 1], center = true);
					}
				}
				translate ([0, -2, 4.5]) {
					cube([10, 8, 6], center = true);
				}

				//bottom
				translate ([0, 1, -13]) {
					cube([8, 14, 12], center = true);
				}
				//top
				translate ([0, 1, 20.5]) {
					//cube([8, 12, 9], center = true); //hole
					cube([10, 14, 9], center = true);
				}

				translate ([0, -1, 0]) {
					cylinder(r = led / 2, h = 40, center = true);
				}
			}
			//LEDS
			//led_5mm([0, -1, 11], [0, 180, 0]); //top
			//led_5mm([0, -1, -4], [0, 0, 0]); //bottom
		}
	}
}

module opto_mount_holes (x, y, z, led) {
	f = 0.5;
	translate ([x, y, z]) {
		rotate ([0, 0, 35]) {
			union(){
				difference () {
					union () {
						translate ([0, 0, 2]) {
							cube([10 + f, 12 + f, 30], center = true);
						}
					}
					//bottom
					translate ([0, 1, -13]) {
						cube([8 - f, 14 + f, 12], center = true);
					}
				}
			}
		}
	}
}

module opto_cap (x, y, z, led) {
	translate ([x, y, z]) {
		rotate ([0, 0, 35]) {
			difference () {
				translate ([0, 0, 15]) {	
					cube([12, 15, 6], center = true);	
				}
				translate([0, 0, 2]) cube([10.6, 13.6, 30], center = true);
				translate([2, -6, 2]) cube([1.8, 16, 30], center = true);
				translate([-2, -6, 2]) cube([1.8, 16, 30], center = true);
			}
		}
	}
}

module bearing (x, y, z) {
	innerD = 8.05;
	outerD = 22.1;
	//width = 8;
	fuzz = 0.1;

	width = 18;
	translate ([x, y, z]) {
		difference () {
			cylinder(r = outerD / 2 + fuzz, h = width, center = true);
			//cylinder(r = innerD / 2 - fuzz, h = width, center = true);
		}
	}
}

module intval () {
	outerD = 9;
	innerD = 4.5;
	height = 15;
	xArray = [-3, 57,  55,  10, -26];
	yArray = [38, 31, -56, -22, -33];

	intval_panel();
	small_gear(43.5, 1, 10.5, 35);
	small_gear_lock(54.5, 12, 29, 0);
	//small_gear_mount(54.5, 12, 29, 0); //dont need em
	big_gear(8.5 + 1.5, -12 - 1, .5);
	big_gear_lock(14.45 + 8.5 + 1.5, -4.65 - 12 - 1, 29, 0);
	big_gear_mount(14.45 + 8.5 + 1.5, -4.65 - 12 - 1, 29, 0);
	opto(42, 29.5, 20, 5.4);
}



module gear_mounts () {
	difference () {
		union () {
			onetoone(26, 10, 4.5); //small gear fitting
			big_gear_fitting(14.45, -4.65, 4.5);
			translate([32, 4, 4.5]) rotate([0, 0, 24]) cube([40, 4, 10], center = true);
		}

		bearing(53, 13, 6); //small gear
		bearing(14.45, -4.65, 6); //big gear

		onetoone(9, 40, 8.5); //small gear axis
		big_gear_axis(14.45, -4.65); //big gear axis
	}
}

/*------------------------------------------------------------
 * HERE COMES THE PARTS!
 *-----------------------------------------------------------*/
//intval_panel();
//small_gear(43.5, 1, 10.5, 35);
//small_gear_top();
//small_gear_bottom();
//small_gear_lock(54.5, 12, 29, 0); 
//small_gear_mount(54.5, 12, 29, 0); //DEPRECATED
//big_gear(8.5, -12, .5);
//big_gear_lock(14.45 + 8.5, -4.65 - 12, 29, 0);
//big_gear_mount(14.45 + 8.5, -4.65 -12, 29, 0);
//opto(42, 29.5, 20, 6);
//opto_cap(42, 29.5, 20, 6);
//cover();

/*------------------------------------------------------------
 * FOR RENDERING
 *-----------------------------------------------------------*/
//intval();
//intval_panel_test();