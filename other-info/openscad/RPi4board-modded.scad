//------------------------------------------------------------------------
// OpenSCAD models of miscellaneous components and devices:
// various Raspberry Pi models, SainSmart Relays, PCD8544 LCD, etc.
//
// Author:      Niccolo Rigacci <niccolo@rigacci.org>
// Version:     1.0 2017-12-14
// License:     GNU General Public License v3.0
// Modified:    by Richard Jelbert 5th January 2021 for RPi 4
//------------------------------------------------------------------------

// Interference for 3D union(), difference() and intersection();
// used to avoid the manifold problem.
interf = 0.2;

//------------------------------------------------------------------------
// Matrix of 2.54 mm pins.
//------------------------------------------------------------------------
module pin_headers(cols, rows) {
    w = 2.54; h = 2.54; p = 0.65;
    for(x = [0 : (cols -1)]) {
        for(y = [0 : (rows  - 1)]) {
            translate([w * x, w * y, 0]) {
                union() {
                    color("black") cube([w, w, h]);
                    //color("gold")  translate([(w - p) / 2, (w - p) / 2, -3]) cube([p, p, 11.54]);
                }
            }
        }
    }
}

//------------------------------------------------------------------------
// Sub-models for the Raspberry Pi 4 Model
//------------------------------------------------------------------------

module ethernet_connector(x, y, z, cut=false) {
    if(!cut) {
        color("silver") cube([x, y, z]);
    }
    if(cut) {
        translate([-0.5,5,-0.5]) color("silver") cube([x+1, y, z+1]);
    }
}
module usb_connector(x, y, z, cut=false) {
    f = 0.6; // Flange
    if(!cut) {
        color("silver") cube([x, y, z]);
        translate([-f, y - f, -f])
            color("silver") cube([x + f * 2, f, z + f * 2]);
    }
    if(cut) {
        //color("silver") cube([x, y, z]);
        translate([-f-0.5, 5, -f-0.5])
            color("silver") cube([x + f * 2+1, y+10, z + f * 2+1]);
    }
}
module hdmi_connector(x, y, z, cut=false) {
    if(!cut) {
        color("silver") cube([x, y, z]);
    }
    if(cut) {
        translate([3,-0.5,-0.5]) color("silver") cube([x+5, y+1, z+1]);
    }
}
module usbc_connector(x, y, z, cut=false) {
    color("silver") cube([x, y, z]);
}
module capacitor(d, h) {
    color("silver") cylinder(r=(d / 2), h=h);
}
module micro_sd_card() {
    color("silver")   translate([1.5,  0.0, -1.5]) cube([12, 12.5, 1.5]);
    color("orange") translate([2, -3.2, -1.0]) cube([11, 15, 1.0]);
}
module audio_video(size_x, cut=false) {
    fn = 64;
    if(!cut) {
        color([58/255, 58/255, 58/255]) {
            cube([size_x, 7, 5.6]);
            translate([size_x, 7 / 2, 5.6 / 2]) rotate([0,90,0]) cylinder(d=5.6, h=2.6, $fn = fn);
        }
    }
    if(cut) {
        color([58/255, 58/255, 58/255]) {
            cube([size_x, 7, 5.6]);
            translate([size_x, 7 / 2, 5.6 / 2]) rotate([0,90,0]) cylinder(d=5.6+0.5, h=10, $fn = fn);
        }
    }
}
module cpu() {
    color("silver")
    cube([15,15,2.4]);
}

module ram() {
    color("black")
    cube([15,10.2,1]);
}

module wifi(){
    color("silver")
    cube([12,10,1.5]); 
}   

module cameracon(){
    color("black")
    cube([22,2.5,5.5]);
}


//------------------------------------------------------------------------
// Raspberry Pi 4 Model B
//------------------------------------------------------------------------
//board_raspberrypi_4_model_b(cut=true);
//board_raspberrypi_4_model_b(cut=false);
module board_raspberrypi_4_model_b(cut=false) {
    fn = 64;
    x  = 56;     y = 85;    z = 1.40;  // Measured PCB size
    ex = 15.9; ey = 21.5; ez = 13.5;   // Ethernet port size
    ux = 13.1; uy = 17.1; uz = 15.5;   // Measured USB connector size
    hx = 7.80; hy = 6.5; hz = 3;  // Measured micro HDMI connector size
    mx =  7.60; my =  9; mz = 3.20;  // Measured USB-C power connector size
    // The origin is the lower face of PCB.
    if(!cut) {
        translate([0, 0, z]) {
            
            translate([56-32.5-7.5,3.5+25.75-7.5,0])  cpu();
            translate([56-32.5-7.5,3.5+43.75-7.5,0])  ram();
            translate([7,6.5,0])    wifi();
            translate([(56/2)-12,(4-1.25),0]) cameracon();
            translate([(56)-22.3,(45),0]) cameracon();
            translate([1.0, 7.1, 0])    pin_headers(2, 20);
            translate([x-(ex/2)-45.75, y - ey + 2.1, 0])    ethernet_connector(ex, ey, ez);
            translate([x-(ux/2)-27, 85 - uy + 2.1, 0])  usb_connector(ux, uy, uz);
            translate([x-(ux/2)-9, 85 - uy + 2.1, 0])   usb_connector(ux, uy, uz);
            translate([x - hx + 1.8, (3.5+7.7+14.8-(hy/2)), 0]) hdmi_connector(hx, hy, hz);
            translate([x - hx + 1.8, (3.5+7.7+14.8+13.5-(hy/2)), 0])    hdmi_connector(hx, hy, hz);
            translate([x - 12.8, 50, 0])    audio_video(12.8);
            translate([x - mx + 1, (3.5+7.7-(my/2)), 0])    usbc_connector(mx, my, mz);
            //translate([20.5, 0.8, -z])  micro_sd_card();
            translate([0, 0, -z]) {
                color("green") linear_extrude(height=z)
                    difference() {
                        hull() {
                            translate([  3,   3]) circle(r=3, $fn = fn);
                            translate([x-3,   3]) circle(r=3, $fn = fn);
                            translate([x-3, y-3]) circle(r=3, $fn = fn);
                            translate([  3, y-3]) circle(r=3, $fn = fn);
                        }
                        raspberrypi_4_model_b_holes();
                    }
            }
        }
    }
    
    if(cut) {
       translate([0, 0, z]) {
            translate([x-(ex/2)-45.75, y - ey + 2.1, 0])    ethernet_connector(ex, ey, ez, cut=true);
            translate([x-(ux/2)-27, 85 - uy + 2.1, 0])  usb_connector(ux, uy, uz, cut=true);
            translate([x-(ux/2)-9, 85 - uy + 2.1, 0])   usb_connector(ux, uy, uz, cut=true);
            translate([x - hx + 1.8, (3.5+7.7+14.8-(hy/2)), 0]) hdmi_connector(hx, hy, hz, cut=true);
            translate([x - hx + 1.8, (3.5+7.7+14.8+13.5-(hy/2)), 0])    hdmi_connector(hx, hy, hz, cut=true);
            translate([x - 12.8, 50, 0])    audio_video(12.8, cut=true);
            //translate([x - mx + 1, (3.5+7.7-(my/2)), 0])    usbc_connector(mx, my, mz, cut=true);
       }
   }
}

//------------------------------------------------------------------------
// Holes for Raspberry Pi 4 Model B
//------------------------------------------------------------------------
module raspberrypi_4_model_b_holes() {
    x = 56;
    fn = 64;
    translate([3.5, 3.5])            circle(r=(2.75 / 2), $fn=fn);
    translate([(x - 3.5), 3.5])      circle(r=(2.75 / 2), $fn=fn);
    translate([3.5, 3.5 + 58])       circle(r=(2.75 / 2), $fn=fn);
    translate([(x - 3.5), 3.5 + 58]) circle(r=(2.75 / 2), $fn=fn);
}



//board_raspberrypi_4_model_b();
