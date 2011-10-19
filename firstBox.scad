include <boxes.scad>
//myBox();
width_outer = 50;
length_outer = 50;
height_outer = 50;

wall_thickness = (1/10) * width_outer;

width_inner = width_outer - (2 * wall_thickness);
length_inner = length_outer - (2 * wall_thickness);
height_inner = height_outer - (2 * wall_thickness);

lid_height = height_outer / 4;
lid_height_i = lid_height - wall_thickness;
lid_width_i = width_outer - wall_thickness;
lid_length_i = length_outer - wall_thickness;


//boxNoLid();
//myLidAtZero();
//myBox();
//boxNoLid();
//boxPrintable();
myRoundBox();

module myFirst() {
	intersection() {
		cylinder (h = 4, r=1, center = true, $fn=100);
		rotate([90,0,0]) cylinder (h=4, r=0.9, center = true, $fn=100);
	}
}

module myCup() {
	
	difference() {
		cylinder(h=20, r=5, center=true, $fn=100);
		translate(v=[0,0,2]) cylinder(h=20,r=4,center=true,$fn=100);
	}
}

module myBox() {
	translate(v=[0,0,height_outer/2]) difference() {
		cube([width_outer,length_outer,height_outer],center=true);
		cube([width_inner,length_inner,height_inner],center=true);
	}
}

module boxNoLid() {
	difference() {
		myBox();
		myLidAtProperHeight();
	}
}

module myRoundBox() {
	roundedBox([10,10,10],2,true);
}

module boxNoLidBeveled() {

}

module myLidAtProperHeight() {
	translate(v=[0,0,height_outer-lid_height]) myLidAtZero();
}

module myLidAtZero() {
	difference() {
		translate(v=[0,0,lid_height/2]) cube([width_outer,length_outer,lid_height],center=true);
		translate(v=[0,0,lid_height_i/2]) cube([lid_width_i,lid_length_i,lid_height_i],center=true);
	}
}

module boxPrintable() {
	translate(v=[(width_outer/2)+5,0,0]) boxNoLid();
	translate(v=[(width_outer/-2)-5,0,lid_height]) rotate([180,0,0]) myLidAtZero();
}