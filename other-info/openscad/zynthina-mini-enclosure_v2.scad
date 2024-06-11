$fn=124;
include <RPi4board-modded.scad>;

//render_all_assembled();
module render_all_assembled() {    
   top();
//   translate([4,4.5,5]) raspberry_and_card();
//   bottom();  
}

module render_all_disassembled() {    
    
}


//bottom();
module bottom() {
    difference() {
        union() {
            translate([3.5,3.5,0]) cube([135-1,160-6-1,3]);
            
            //rp4 base
            translate([3.5,24.5,0]) cube([7.5,7,5]);
            translate([3.5,82.5,0]) cube([7.5,7,5]);
            translate([53,24.5,0]) cube([7.5,7,5]);
            translate([53,82.5,0]) cube([7.5,7,5]);
        }
        
        //rp4 holes
        translate([32,51,14])
        rotate([0,0,-90])
        {
            //boreholes for Raspberry Pi
            translate([4, 0, -9.6])
                rotate([0, 0, 0]) {
                translate([-10, 0, 0]) {
                    translate([-58/2,-49/2,-1]) {
                        cylinder(h=7, d=2.75, center=true);
                        translate([0,0,-2.7]) cylinder(h=1.6, r1=2.2, r2=1.4, center=true);
                    }
                    translate([-58/2, 49/2,-1]) {
                        cylinder(h=7, d=2.75, center=true);
                        translate([0,0,-2.7]) cylinder(h=1.6, r1=2.2, r2=1.4, center=true);
                    }
                    translate([ 58/2,-49/2,-1]) {
                        cylinder(h=7, d=2.75, center=true);
                        translate([0,0,-2.7]) cylinder(h=1.6, r1=2.2, r2=1.4, center=true);
                    }
                    translate([ 58/2, 49/2,-1]) {
                        cylinder(h=7, d=2.75, center=true);
                        translate([0,0,-2.7]) cylinder(h=1.6, r1=2.2, r2=1.4, center=true);
                    }
                }
            }
        }
        
        // ventilation gril
        for ( i = [1:1:10]) {
            //render first grill shorter so that there is a space to glue rubber legs
            if (i==1) {
                translate([15+10,5+i*7,-1]) rotate([0,0,-90])
                hull() {
                    cylinder ( h=10,r1=1,r2=1,center=true );
                    translate([0,25,0]) cylinder ( h=10,r1=1,r2=1,center=true );
                }
            } else {
                translate([15,5+i*7,-1]) rotate([0,0,-90])
                hull() {
                    cylinder ( h=10,r1=1,r2=1,center=true );
                    translate([0,35,0]) cylinder ( h=10,r1=1,r2=1,center=true );
                }
            }
        }

        // main holes for scews thatwill connect it to top 
        //translate([7.5,7.5,-1]) cylinder(h=12, r1=1.75, r2=1.75, center=false);
        translate([7.5,160-7.5,-1]) cylinder(h=12, d=2.5, center=false);
        translate([135-1.5,7.5,-1]) cylinder(h=12, d=2.5, center=false);
        translate([135-1.5,160-7.5,-1]) cylinder(h=12, d=2.5, center=false);
        
        //hole enlargement for screw head
        translate([7.5,160-7.5,-0.1]) cylinder(h=1.6, r1=2.2, r2=1.4, center=false);        
        translate([135-1.5,7.5,-0.1]) cylinder(h=1.6, r1=2.2, r2=1.4, center=false);
        translate([135-1.5,160-7.5,-0.1]) cylinder(h=1.6, r1=2.2, r2=1.4, center=false);

    }
}
//display(cut=true);
module display(cut=false) {
    if(!cut) {
        //display is 106x68x8.6
        translate([68,0,0]) rotate([180,0,180])
        color("blue") translate([68/2,106/2,3.35]) rotate([0,0,90]) import("0329.stl", convexity = 5);
    }
    if (cut) {
        translate([-0.5,-0.5,-14])
        union() {
            //screen is 106x68x8.6 but add 1 mm on each side for posible fit
            cube([69, 107, 16]); 
            translate([0.5,0.5,14]) screen_mounting(post_height=6, cut=true);
        }
    }
}

// raspberry 4.3 screen mounting
// mounting screws for case should be 3.75x3.75 mm ouside the each corner 
//screen_mounting();
//screen_mounting(cut=false);
module screen_mounting(post_height=6, cut=false) {

   if(!cut){
       //  display center mounitng is:
       //  DOWN-UP distance from corner of teh screen: "(68-61.8)/2: ", 3.1
       //  LEFT/RIGHT: "(106-99.3)/2: ", 3.35
       difference() {
           union() {
            //top left
            translate([(68-61.8)/2,(106-99.3)/2,-8.6+1]) rotate([180,0,90]) 
                difference() {
                    hull() {
                        cylinder(r=5,h=post_height);
                        translate([-6,-6,0])cylinder(r=5,h=post_height);
                    }
                    translate([0,0,-0.1])cylinder(r=3,h=5);
                    translate([0,0,1])cylinder(r=1.4,h=8);
                    translate([-3,-6.3,5]) rotate([0,0,45]) linear_extrude(height = 3) text("1", font = "Liberation Sans:style=Bold", size = 5);
                }
                
            //top right
            translate([(68-61.8)/2,99.3+(106-99.3)/2,-8.6+1]) rotate([180,0,0])
                difference() {
                    hull() {
                        cylinder(r=5,h=post_height);
                        translate([-6,-6,0])cylinder(r=5,h=post_height);
                    }
                    translate([0,0,-0.1])cylinder(r=3,h=5);
                    translate([0,0,1])cylinder(r=1.4,h=8); 
                    translate([-3,-6.3,5]) rotate([0,0,45]) linear_extrude(height = 3) text("2", font = "Liberation Sans:style=Bold", size = 5);

                }
                
            //bottom right
            translate([61.8+(68-61.8)/2,99.3+(106-99.3)/2,-8.6+1]) rotate([180,0,-90])
                difference() {
                    hull() {
                        cylinder(r=5,h=post_height);
                        translate([-6,-6,0])cylinder(r=5,h=post_height);
                    }
                    translate([0,0,-0.1])cylinder(r=3,h=5);
                    translate([0,0,1])cylinder(r=1.4,h=8);
                   translate([-3,-6.3,5]) rotate([0,0,45]) linear_extrude(height = 3) text("3", font = "Liberation Sans:style=Bold", size = 5); 
                }
                
            // bottom left
            translate([61.8+(68-61.8)/2,(106-99.3)/2,-8.6+1]) rotate([180,0,180]) 
                difference() {
                    hull() {
                        cylinder(r=5,h=post_height);
                        translate([-6,-6,0])cylinder(r=5,h=post_height);
                    }
                    translate([0,0,-0.1])cylinder(r=3,h=5);
                    translate([0,0,1])cylinder(r=1.4,h=8); 
                    translate([-3,-6.3,5]) rotate([0,0,45]) linear_extrude(height = 3) text("4", font = "Liberation Sans:style=Bold", size = 5);
                }
            }
       
            // cut small edges  (1.mm deep) for screen
            //screen is 106x68x8.6mm but add 0.1 on each side
            translate([-0.1,-0.1,-8.6])cube([68.2, 106.2,8.6]);
            
            // mount holes
            //top left hole for mount
            translate([(68-61.8)/2+1,(106-99.3)/2+1,-8.6+1]) rotate([180,0,90]) 
                translate([-7,-7,-1])cylinder(r=1.4,h=8); 
            //top right hole for mount
            translate([(68-61.8)/2+1,99.3+(106-99.3)/2-1,-8.6+1]) rotate([180,0,0])
                    translate([-7,-7,-1])cylinder(r=1.4,h=8); 
            //bottom right hole for mount
            translate([61.8+(68-61.8)/2-1,99.3+(106-99.3)/2-1,-8.6+1]) rotate([180,0,-90])
                    translate([-7,-7,-1])cylinder(r=1.4,h=8);             
            // bottom left hole for mount
            translate([61.8+(68-61.8)/2-1,(106-99.3)/2+1,-8.6+1]) rotate([180,0,180]) 
                    translate([-7,-7,-1])cylinder(r=1.4,h=8);             
        }
    }
    
    if (cut) {
       translate([0,0,6]) {
            // mount holes
            //top left hole for mount
            translate([(68-61.8)/2+1,(106-99.3)/2+1,-8.6+1]) rotate([180,0,90]) 
                translate([-7,-7,-1])cylinder(d=4.5,h=8); 
            //top right hole for mount
            translate([(68-61.8)/2+1,99.3+(106-99.3)/2-1,-8.6+1]) rotate([180,0,0])
                    translate([-7,-7,-1])cylinder(d=4.5,h=8); 
            //bottom right hole for mount
            translate([61.8+(68-61.8)/2-1,99.3+(106-99.3)/2-1,-8.6+1]) rotate([180,0,-90])
                    translate([-7,-7,-1])cylinder(d=4.5,h=8);             
            // bottom left hole for mount
            translate([61.8+(68-61.8)/2-1,(106-99.3)/2+1,-8.6+1]) rotate([180,0,180]) 
                    translate([-7,-7,-1])cylinder(d=4.5,h=8);             
       }
    }
}

//test_display_mounting(mounting=true, showDisplay=true, screenMounting=true);
module test_display_mounting(mounting=true, showDisplay=false, screenMounting=false) {
        if (mounting) {
            difference() {
                //display mounting is 120x85
                translate([-(83-68)/2, -(120-106)/2, -7.6]) cube([83,120,7.6]);
                //display is 106x68 and display cut is 107x69
                display(cut=true);
            }
        }
        if(showDisplay) display(cut=false);
        
        if (screenMounting) {
            screen_mounting();
        }
}

//display_with_raspberry_and_card();
module display_with_raspberry_and_card(){
    translate([68,0,0]) rotate([180,0,180])
    union() {
        //display is 106x68x8.6
        //display post is 4mm
        color("blue") translate([68/2,106/2,3.35]) rotate([0,0,90]) import("0329.stl", convexity = 5);
        translate([9.5-3.5,22.38-3.5,15]) board_raspberrypi_4_model_b();

        // zunthian board is 56x85
        translate([56/2+9.5-3.5,85/2+22.38-3.5,27]) rotate([0,0,90]) audio_card();
    }
}

//raspberry_and_card();
module raspberry_and_card(cut=false){
    translate([56,85,0]) rotate([0,0,180])
    union() {
        board_raspberrypi_4_model_b(cut=cut);

        // zunthian board is 56x85
        //translate([56/2,85/2,12]) rotate([0,0,90]) audio_card();
    }
}

    
    

//top();
module top() {
// zynthian-top.svg is 170 width and 120 height
    difference() {
        union() {
            //case
            difference() {
                case(160, tolerance=3); 
                case_cut(lenght=160, tolerance=3);
            }
            //add a display_mounting
            translate([28.5,(160-120)/2,49.4]) rotate([0,6.99,0]) cube([82,120,7.6]);
            
        }
       
        // carve logo
        translate([13, 0, 58]) rotate([0,7,0]) zynthian_top(cut=false); 
        //carve encoder and screen holes
        translate([13, 0, 58]) rotate([0,7,0]) zynthian_top(cut=true);
       
        // holes for bottom part
        //single hole that goes trough rp4
        translate([32,51,28])
        rotate([0,0,-90])
        {
            //boreholes for Raspberry Pi
            translate([4, 0, -8])
                rotate([0, 0, 0]) {
                translate([-10, 0, 0]) {
                    translate([ 58/2,-49/2,-1])
                    cylinder(h=9, d=4.5, center=true); 
                }
            }
        }
        translate([7.5,160-7.5,-1]) cylinder(h=12, d=4.5, center=false);
        translate([135-1.5,7.5,-1]) cylinder(h=12, d=4.5, center=false);
        translate([135-1.5,160-7.5,-1]) cylinder(h=12, d=4.5, center=false);
        
        //raspberry_pi opening
        translate([32,51,14])
        rotate([0,0,-90])
        {        

            //triming to 2mm wall when connectors are
            translate([-35,-32.1,-10]) cube([57,1.1,11]);
            translate([50,-29,-10]) cube([1.1,57,21]);
            
            // Opening for Ethernet
            translate([48.5, 17.75, -0.65]) rotate([0, 90, 0]) cube([13.9, 16.4, 1.2], center=true);
            translate([49.5, 17.75, -0.65]) rotate([0, 90, 0]) cube([15.9, 18.4, 1.2], center=true);
              
            // Opening for 1. USB A
            translate([48.5, -19, 0.6]) rotate([0, 90, 0]) cube([16.4, 14.9, 1.2], center=true);
            translate([49.5, -19, 0.6]) rotate([0, 90, 0]) cube([18.4, 16.9, 1.2], center=true);

            // Opening for 2. USB A
            translate([48.5, -1, 0.6]) rotate([0, 90, 0]) cube([16.4, 14.9, 1.2], center=true);
            translate([49.5, -1, 0.6]) rotate([0, 90, 0]) cube([18.4, 16.9, 1.2], center=true);

            //Opening for hole for micro USB
            translate([-27.3, -29.5, -5.825]) rotate([90, 0, 0]) cube([9.4, 3.55, 1.2], center=true);
            translate([-27.3, -30.5, -5.825]) rotate([90, 0, 0]) cube([11.4, 5.55, 1.2], center=true);

            //Opening for 1. Micro HDMI
            translate([-12.5, -29.5, -5.9]) rotate([90, 0, 0]) cube([7.9, 3.4, 1.2], center=true);
            translate([-12.5, -30.5, -5.9]) rotate([90, 0, 0]) cube([9.9, 5.4, 1.2], center=true);     
          
            //Opening for  2. Micro HDMI
            translate([1, -29.5, -5.9]) rotate([90, 0, 0]) cube([7.9, 3.4, 1.2], center=true);
            translate([1,  -30.5, -5.9]) rotate([90, 0, 0]) cube([9.9, 5.4, 1.2], center=true);

            //Opening for  Audio
            translate([15.5, -29.5, -4.6]) rotate([90, 0, 0]) cylinder(h = 2, r = 3.2, center=true);
            translate([15.5, -30.5, -4.4]) rotate([90, 0, 0]) cylinder(h = 1.2, r = 4.2, center=true);        
        }
        
        //left side grill       
        for ( i = [1:1:7]) {
            translate([7+i*7,1,30]) rotate([90,0,0])  
                hull() {
                    cylinder ( h=5,r1=1,r2=1,center=true );
                    translate([0,23-i*0.85,0]) cylinder ( h=5,r1=1,r2=1,center=true );
                }
        }
        
        //right side grill       
        for ( i = [1:1:7]) {
            translate([7+i*7,158,10]) rotate([90,0,0])  
                hull() {
                    cylinder ( h=5,r1=1,r2=1,center=true );
                    translate([0,40-i*0.85,0]) cylinder ( h=5,r1=1,r2=1,center=true );
                }
        }
        
        
        translate([0,20,14])
        for ( i = [1:1:12]) {
            translate([2,5+i*5,5]) rotate([90,0,90])  
                hull() {
                    cylinder ( h=5,r1=1,r2=1,center=true );
                    translate([0,8,0]) cylinder ( h=5,r1=1,r2=1,center=true );
                }
        }

        
        //holes for midi connector
        translate([0,132,35]) midi_connector_hole();
        translate([0,132,15]) midi_connector_hole();
        translate([0,102,35]) midi_connector_hole();
        
        //holes for audio RCA
        translate([-2,52,35]) {
            rotate([90,0,90]) cylinder(h=10,r=4.3,center=false);
            translate([0,23.3-8.3,0]) rotate([90,0,90]) cylinder(h=10,r=4.3,center=false);
            translate([0,-(10.15+8.3/2),0]) rotate([90,0,90]) cylinder(h=10,r=1.75,center=false);
            translate([0,23.3+(10.3-8.3/2),0]) rotate([90,0,90]) cylinder(h=10,r=1.75,center=false);
            
        }
        
        //hole for wake up switch
        translate([-1,12,48]) rotate([90,0,90]) cylinder(h=10,d=12, center=false);
        translate([4,12,48]) rotate([90,0,90]) cylinder(h=10,d=7, center=false);
        
        //labels
        translate([1,117,13]) rotate([90,0,-90]) linear_extrude(height = 3) text("MIDI IN", font = "Arial:style=Narrow Bold", size = 4);
        translate([1,142,45]) rotate([90,0,-90]) linear_extrude(height = 3) text("MIDI OUT", font = "Arial:style=Narrow Bold", size = 4);
        translate([1,114,45]) rotate([90,0,-90]) linear_extrude(height = 3) text("MIDI THRU", font = "Arial:style=Narrow Bold", size = 4);
        translate([1,71,42]) rotate([90,0,-90]) linear_extrude(height = 3) text("audio OUT", font = "Arial:style=Narrow Bold", size = 4);
        translate([1,21,37]) rotate([90,0,-90]) linear_extrude(height = 3) text("wake up", font = "Arial:style=Narrow Bold", size = 4);
        translate([1,23,18]) rotate([90,0,-90]) linear_extrude(height = 3) text("STOJOS", font = "Arial:style=Narrow Bold", size = 4);
        translate([1,18,11]) rotate([90,0,-90]) linear_extrude(height = 3) text("V1.0", font = "Arial:style=Narrow Bold", size = 4);
    }
}



module midi_connector_hole() {
        translate([-26,0,0]) rotate([90,0,90]) {
            translate([0,0,25]) cylinder(h=10,d=15.5,center=false);
            //translate([0,0,25]) cylinder(h=10,d=19,center=false);
            translate([-21.5/2,0,25]) cylinder(h=10,r1=2,r2=2,center=false);
            translate([+21.5/2,0,25]) cylinder(h=10,r1=2,r2=2,center=false);  
        }

}

raspberry_mounting();
module raspberry_mounting() {
    difference() {
        cylinder(r=2.5,h=3);
        translate([0,0,-1]) cylinder(r=1.5,h=5);
    }

}


//zynthian_top(cut=true);
// cut: true - render wholes only
module zynthian_top(cut=false) {
    //zynthian logo is 160x120
    if (!cut) {
        translate([125,0,0]) rotate([0,0,90]) linear_extrude(3) import("zynthian-new-v2-top.svg");
    }
    if (cut) {
        //encored cuts from svg file
        translate([125,0,-9 ]) rotate ([0,0,90]) linear_extrude(16) import("zynthian-new-v2-holes.svg");
        //screen and screen holes
        translate([23.434-0.5, (160-107)/2-0.5, -14]) 
        union() {
            //screen is 106x68x8.6 but add 1 mm on each side for posible fit
            cube([69, 107, 16]); 
            translate([0.5,0.5,14]) screen_mounting(post_height=6, cut=true);
        }
        
    }
}



//case_cut(lenght=135, tolerance=3);
module case_cut(lenght=130, tolerance=3) {
    translate([tolerance,tolerance,0]) 
    difference() {
        union() {
              scale([135/(135+2*tolerance),1,57/(57+tolerance)-0.014]) case(lenght=lenght-2*tolerance, tolerance=tolerance);
//            //add a bottom part so that it properly cuts bottom
            translate([0,0,-2]) cube([135,lenght-2*tolerance, 3]);
            
        }
       translate([-1,-1,40]) cube([10,22,60]); 
       translate([-1,20,5+1.6+11]) cube([10,9,60]);
       translate([-1,1+lenght-10-2*tolerance,tolerance]) cube([10,10,60]);
       translate([135-10+1,-1,tolerance]) cube([10,10,50]);
       translate([135-10+1,1+lenght-10-2*tolerance,tolerance]) cube([10,10,50]);
    }

}
            

module case(lenght=200, tolerance=0) {
    translate([0,lenght,0]) rotate ([90,0,0])
    hull() {
        linear_extrude(height = lenght) polygon( points=[[0,0],[0,52+tolerance],[0+5,52+5+tolerance],[135+tolerance*2-5,36+tolerance+5], [135+tolerance*2,36+tolerance],[135+tolerance*2,0]]);
        translate([0+5,52+tolerance,0]) cylinder(h = lenght, r1 = 5, r2 = 5, center = false);
        translate([135+tolerance*2-5,36+tolerance,0]) cylinder(h = lenght, r1 = 5, r2 = 5, center = false);
    }
}

module audio_card(withHeader=false)
{  
  {
    // PCB
    color("DarkSlateGray") difference()
    {
      translate([(65-85)/2,0,0]) hull()
      {
        translate([-(65-6)/2,-(56-6)/2,0]) cylinder(r=3, h=1.4 );
        translate([-(65-6)/2, (56-6)/2,0]) cylinder(r=3, h=1.4 );
        translate([ (65-6)/2,-(56-6)/2,0]) cylinder(r=3, h=1.4 );
        translate([ (65-6)/2, (56-6)/2,0]) cylinder(r=3, h=1.4 );
      }
      
      translate([-85/2+3.5,-49/2,-1]) cylinder(d=2.75, h=3);
      translate([-85/2+3.5, 49/2,-1]) cylinder(d=2.75, h=3);
      translate([58-85/2+3.5,-49/2,-1]) cylinder(d=2.75, h=3);
      translate([58-85/2+3.5, 49/2,-1]) cylinder(d=2.75, h=3);
    }
    
    // Header down
    translate([3.5-85/2+29-10*2.54,49/2-2.54,-8])
      color("darkgrey") cube([2.54*20,5.08,8]);
    
    // Chinch
    translate([-85/2,-56/2,1.4]) 
    {
        
      //21.5

        color("black") translate([21.5-6.75,0,0]) cube([27,10,14]);        
        color("silver") translate([21.5,-9,7.5]) rotate([-90,0,0]) cylinder(d=8,h=9);
        color("silver")  translate([35,-9,7.5]) rotate([-90,0,0]) cylinder(d=8,h=9);
    }
    
    // Header top
    if( withHeader )
      translate([3.5-85/2+29-10*2.54,49/2-2.54-2*2.54,1.4])
        header(20,2);

  }
}


module header(pins, rows)
{
  color("darkgrey") cube([2.54*pins,2.54*rows,1.27]);
  
  for(x=[0:pins-1],y=[0:rows-1])
    translate([x*2.54+(1.27+.6)/2,y*2.54+(1.27+.6)/2,-3.5]) cube([0.6,0.6,11.5]);
}
    

//rpi4case();
module rpi4case()
{
    translate([32,51,14])
    rotate([0,0,-90])
    difference() {
        //main edges
        difference() {
            translate([-50,-32,-14])  cube([101, 63, 29]);
            translate([-52,-29,-9])  cube([100, 62, 25]);
        }
        
        //triming to 2mm wall when connectors are
        translate([-35,-32.1,-10]) cube([57,1.1,11]);
        translate([50,-29,-10]) cube([1.1,57,21]);
        
        // Opening and boreholes for Raspberry Pi
        translate([4, 0, -10])
            rotate([0, 0, 0]) {
            cube([85, 42,3], center=true);
            translate([-10,0,0]) cube([51, 51, 3], center = true);
            translate([32.5,0,0]) cube([20, 51, 3], center = true);

            translate([-10, 0, 0]) {
                translate([-58/2,-49/2,0])
                cylinder(h=2+0.1, d=2.75, center=true);
                translate([-58/2, 49/2,0])
                cylinder(h=2+0.1, d=2.75, center=true);
                translate([ 58/2,-49/2,0])
                cylinder(h=2+0.1, d=2.75, center=true);
                translate([ 58/2, 49/2,0])
                cylinder(h=2+0.1, d=2.75, center=true);
            }
        }

        // Opening for Ethernet
        translate([48.5, 17.75, -0.65]) rotate([0, 90, 0]) cube([13.9, 16.4, 1.2], center=true);
        translate([49.5, 17.75, -0.65]) rotate([0, 90, 0]) cube([15.9, 18.4, 1.2], center=true);
          
        // Opening for 1. USB A
        translate([48.5, -19, 0.6]) rotate([0, 90, 0]) cube([16.4, 14.9, 1.2], center=true);
        translate([49.5, -19, 0.6]) rotate([0, 90, 0]) cube([18.4, 16.9, 1.2], center=true);

        // Opening for 2. USB A
        translate([48.5, -1, 0.6]) rotate([0, 90, 0]) cube([16.4, 14.9, 1.2], center=true);
        translate([49.5, -1, 0.6]) rotate([0, 90, 0]) cube([18.4, 16.9, 1.2], center=true);

        //Opening for hole for micro USB
        translate([-27.3, -29.5, -5.825]) rotate([90, 0, 0]) cube([9.4, 3.55, 1.2], center=true);
        translate([-27.3, -30.5, -5.825]) rotate([90, 0, 0]) cube([11.4, 5.55, 1.2], center=true);

        //Opening for 1. Micro HDMI
        translate([-12.5, -29.5, -5.9]) rotate([90, 0, 0]) cube([7.9, 3.4, 1.2], center=true);
        translate([-12.5, -30.5, -5.9]) rotate([90, 0, 0]) cube([9.9, 5.4, 1.2], center=true);     
      
        //Opening for  2. Micro HDMI
        translate([1, -29.5, -5.9]) rotate([90, 0, 0]) cube([7.9, 3.4, 1.2], center=true);
        translate([1,  -30.5, -5.9]) rotate([90, 0, 0]) cube([9.9, 5.4, 1.2], center=true);

        //Opening for  Audio
        translate([15.5, -29.5, -4.6]) rotate([90, 0, 0]) cylinder(h = 2, r = 3.2, center=true);
        translate([15.5, -30.5, -4.4]) rotate([90, 0, 0]) cylinder(h = 1.2, r = 4.2, center=true);
    }  
}