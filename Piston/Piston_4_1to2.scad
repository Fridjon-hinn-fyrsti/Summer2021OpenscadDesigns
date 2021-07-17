module ring(r1, r2, h){
    difference(){
        cylinder(r=r1, h=h, $fn=100, center=true);
        cylinder(r=r2, h=h*2, $fn=100, center=true);
    }
}

module spool(r1,r2,r3,h1,h2){
    difference(){
        ring(r1,r3,h1);
        ring(r1*2,r2,h2);
    }
}


wall_thickness = 2;
hinge_height = 9;
hinge_thickness = 5;
bearing_thickness = 4;
bearing_hole_radius = 2.4;
fit_margin = 0.25;


module slider_without_holes(w,l,h){
    difference(){
        cube([w,l,h], center=true);
        
        let(x=0,y=0,z= -hinge_height/2+wall_thickness/2)
        translate([x,y,z])cube([w-wall_thickness*2, l*2, h-wall_thickness-hinge_height], center=true);
        
        let(gap = bearing_thickness + 2*fit_margin + hinge_thickness*2 + 2.2*fit_margin)
        let(x=0,y=0,z= h/2-hinge_height/2+1)
        translate([x,y,z])cube([gap, l*2, hinge_height+2.01], center=true);
    }
    let(gap = bearing_thickness + 2*fit_margin)
    for(i=[0:1])
    {
        let(dx = [-1,1][i]*(gap/2+hinge_thickness/2),x=0,y=0+l/2-hinge_height/2,z=h/2+hinge_height/2)
            translate([x+dx,y,z])cube([hinge_thickness, hinge_height, hinge_height], center=true);
        
        let(dx = [-1,1][i]*(gap/2+hinge_thickness),x=0,y=l/2-hinge_height/2,z=h/2-hinge_height/2)
            translate([x+dx,y,z])cube([2*hinge_thickness, hinge_height, hinge_height], center=true);
    }
    
}

module slider(w,l,h){
    difference(){
        slider_without_holes(w,l,h);
        
        let(x=0,y=0+l/2-hinge_height/2,z=h/2+hinge_height/2,r = bearing_hole_radius )
        translate([x,y,z])rotate([0, 90, 0])cylinder(2000,r=r,center=true, $fn=100);
         let(x=0,y=-l/2+hinge_height/2,z=h/2-hinge_height/2, r = bearing_hole_radius)
        translate([x,y,z])rotate([0, 90, 0])cylinder(2000,r=r,center=true, $fn=100);
    }
        
        
}

module slider_cover(w,l,h){
    difference(){
    union(){
    difference(){
        slider_without_holes(w,l,h);
        
        let(x=0,y=0+l/2-hinge_height/2,z=h/2+hinge_height/2,r = bearing_hole_radius )
        translate([x,y,z])rotate([0, 90, 0])cylinder(2000,r=r,center=true, $fn=100);
        
         let(x=0,y=-l/2+hinge_height/2,z=h/2-hinge_height/2, r = bearing_hole_radius)
        translate([x,y,z])rotate([0, 90, 0])cylinder(2000,r=r,center=true, $fn=100);
        
        let(x=0,y=0,z=0)
        translate([x,y,z+h/2+hinge_height/2])cube([10000,10000,hinge_height], center=true);
    }
    let(x=0,y=l/2-hinge_height/2,z=0)
    translate([x,y,z])cube([w,hinge_height,h], center=true);
    }
    //drill holes
    for(i=[0:1])
    let(dx=[1,-1][i]*(0.8*w/2),x=0,y=l/2-hinge_height/2,z=h/2-hinge_height/2, r = bearing_hole_radius)
        translate([x+dx,y,z])rotate([90, 0, 0])cylinder(2000,r=r,center=true, $fn=100);
    
    for(i=[0:1])
    let(dx=[1,-1][i]*(0.8*w/2),x=0,y=l/2-hinge_height/2,z=-h/2+hinge_height/2, r = bearing_hole_radius)
        translate([x+dx,y,z])rotate([90, 0, 0])cylinder(2000,r=r,center=true, $fn=100);
    
    for(i=[0:1])
    let(dz=[1,-1][i]*(0.3*h/2),x=0,y=l/2-hinge_height/2,z=0, r = bearing_hole_radius)
        translate([x,y,z+dz])rotate([90, 0, 0])cylinder(2000,r=r,center=true, $fn=100);
    
    
    }
        
        
}

l = 150;
w = 50;
h = 45;


slider_cover(w,l,h);
for(i=[1:1]){
    let(w = w -(2*wall_thickness + 2*fit_margin)*i)
    let(h = h -(hinge_height+wall_thickness + 2*fit_margin)*i)
    let(x=0,y=0,z=-i*3.5)
    translate([x+i*50,y,z])slider(w,l,h);
    }





    

    
    

//translate([x,y,z])spool(