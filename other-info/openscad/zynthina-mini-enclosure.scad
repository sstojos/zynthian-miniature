$fn=124;


//render_all_disassembled();
color("SaddleBrown") render_all_assembled();

module render_all_assembled() {    
    

}

module render_all_disassembled() {    
    
}

//mounting();
module mounting() {

    difference() {
        union() {
            hull() {
                cylinder(r=5,h=10);
            translate([-7,-7,0])cylinder(r=5,h=10);
            }
            hull() {
                translate([-1.5,-1.5,0])cylinder(r=5,h=3);
                translate([-7,-7,0])cylinder(r=5,h=3);
            }
        }
        translate([0,0,3])cylinder(r=3,h=4.5);
        translate([0,0,5])cylinder(r=1.4,h=8);
        translate([-3.25,-3.25,-1]) cube([10,10,5.5]);
        translate([-7,-7,-1])cylinder(r=1,h=5);
        translate([-7,-7,10-4])cylinder(r=1,h=5);
    }
}


top_panel(part=0);
module top_panel(part=0) {
// zyntian-top.svg is 150 width and 110 height
    difference() {
        union() {
            top_with_holes(part=part);
        }
        translate([110+2.2, 0, 41]) rotate([0,8.7,0]) rotate([0,0,90]) zynthian_top(cut=false); 
        translate([110+2.2, 0, 41]) rotate([0,7.1,0]) rotate([0,0,90]) zynthian_top(cut=true); 
    }
    
    //screen mounting bottom left
    translate([28.5, 25.5, 46]) rotate([0,9,0]) screen_mounting();

}


//zynthian_top();
// part: 1 left
// part: 2 center
// part: 3 right
// part: 4 all
// cut: true - render wholes only
module zynthian_top(cut=false) {
    if (!cut) {
        linear_extrude(3) import("zynthian-top.svg");
    }
    if (cut) {
        translate([0,0,-5]) linear_extrude(10) import("zynthian-holes.svg");
    }
}





//top_with_holes(part=3);
// top with hole is the template for rendering the top lid for number of sections
module top_with_holes(part=0) {
    difference() {
        lenght=150;
        top(lenght=lenght, part=part);
//        // holes for top screews
//        translate([0,-6,0])
//        translate([8.65,0,23.8-13])
//        translate([13,9,34]) cylinder(h=15,r1=1.75,r2=1.75,center=false);
//        translate([0,lenght-6,0])
//        translate([8.65,0,23.8-13])
//        translate([13,3,34]) cylinder(h=15,r1=1.75,r2=1.75,center=false);
//        //holes for front screew
//        translate([133,5,15]) rotate ([0,90,0]) cylinder(h=10,r1=1.75,r2=1.75,center=false);
//        translate([133,lenght-5,15]) rotate ([0,90,0]) cylinder(h=10,r1=1.75,r2=1.75,center=false);
        
        
    }

}

//top(lenght=20, part=0);
// top is the template for rendering the top lid of any lenght
// part: 0 - render all
// part: 1 - render only rear
// part: 2 - render only top
// part: 3 - render only front
module top(lenght=10, part=0) {
    // top takes 4 internal parts of 1" 1/4 which is in total 5" - which is 127mm
    difference() {
        case(lenght=lenght, tolerance=2.2);
        translate([2.2,2.2,-0.1]) case(lenght=lenght-2*2.2, tolerance=0);
    }
}

            
//case(lenght=10, tolerance=0);
module case(lenght=200, tolerance=0) {
    translate([0,lenght,0]) rotate ([90,0,0])
    hull() {
        linear_extrude(height = lenght) polygon( points=[[0,0],[0,52+tolerance],[0+5,52+5+tolerance],[110+tolerance*2-5,36+tolerance+5], [110+tolerance*2,36+tolerance],[110+tolerance*2,0]]);
        translate([0+5,52+tolerance,0])
            cylinder(h = lenght, r1 = 5, r2 = 5, center = false);
        translate([110+tolerance*2-5,36+tolerance,0]) cylinder(h = lenght, r1 = 5, r2 = 5, center = false);
    }
}
