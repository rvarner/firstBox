include <boxes.scad>
//myBox();

wiggle_room = 1;

my_fn = 50;
//my_fn = 100;

//width_outer = 50;
//length_outer = 50;
//height_outer = 50;

width_outer = 40;
length_outer = 40;
height_outer = 40;

wall_thickness = (1/10) * width_outer;

width_inner = width_outer - (2 * wall_thickness);
length_inner = length_outer - (2 * wall_thickness);
height_inner = height_outer - (2 * wall_thickness);

lid_height = height_outer / 4;
lid_height_i = lid_height - wall_thickness;
lid_width_i = width_outer - wall_thickness;

lid_length_i = length_outer - wall_thickness;


module myBox() {
	translate(v=[0,0,height_outer/2]) difference() {
		cube([width_outer,length_outer,height_outer],center=true);
		cube([width_inner,length_inner,height_inner],center=true);
	}
}

module myBoxRounded() {
	translate(v=[0,0,height_outer/2]) difference() {
		roundedBox([width_outer,length_outer,height_outer],wall_thickness,center=true,$fn=my_fn);
		cube([width_inner,length_inner,height_inner],center=true);
	}
}


module boxNoLid() {
	difference() {
		myBox();
		myLidAtProperHeight();
	}
}

module boxNoLidRounded() {
	difference() {
		myBoxRounded();
		myLidAtProperHeight();
	}

}

module myLidAtProperHeight() {
	translate(v=[0,0,height_outer-lid_height]) myLidAtZero();
}

module myLidRoundedAtProperHeight() {
	translate(v=[0,0,height_outer-lid_height]) myRoundedLidAtZero();
}

module myRoundedLidAtZero() {
	difference() {
		difference() {
			roundedBox([width_outer,length_outer,lid_height*2],wall_thickness,false,$fn=my_fn,center=true);
			translate(v=[0,0,-lid_height]) cube([width_outer+1,length_outer+1,lid_height*2],center=true);
		}
		translate(v=[0,0,lid_height_i/2]) cube([lid_width_i,lid_length_i,lid_height_i],center=true);
	}
}

module myLidAtZero() {
	difference() {
		translate(v=[0,0,lid_height/2]) cube([width_outer,length_outer,lid_height],center=true);
		translate(v=[0,0,lid_height_i/2]) cube([lid_width_i - wiggle_room,lid_length_i  - wiggle_room,lid_height_i],center=true);
	}
}

module boxPrintable() {
	translate(v=[(width_outer/2)+5,0,0]) boxNoLid();
	translate(v=[(width_outer/-2)-5,0,lid_height]) rotate([180,0,0]) myLidAtZero();
}

module boxOnlyRoundedPrintable() {
	boxNoLidRounded();
}

module lidOnlyRoundedPrintable() {
	translate(v=[0,0,lid_height]) rotate([180,0,0]) myRoundedLidAtZero();
}

module boxRoundedPrintable() {
	translate(v=[(width_outer/2)+5,0,0]) boxNoLidRounded();
	translate(v=[(width_outer/-2)-5,0,lid_height]) rotate([180,0,0]) myRoundedLidAtZero();
}


//boxPrintable();
boxRoundedPrintable();
//boxOnlyRoundedPrintable();
//lidOnlyRoundedPrintable();