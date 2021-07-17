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

module thread(thread_width, wall_width, thread_depth,  n, r){
    detail = 100;
    for(j = [0:n-1])
    for(i = [1:detail])
        let(angle=i*360/detail, x=r*cos(angle),y=r*sin(angle),z=(i/detail+j)*(thread_width+wall_width))
        translate([x,y,z])rotate([0,0,angle])cube([thread_depth,thread_width,thread_width],center=true);
}

l = 150;
w = 50;
h = 45;

/*
slider_cover(w,l,h);
for(i=[1:3]){
    let(w = w -(2*wall_thickness + 2*fit_margin)*i)
    let(h = h -(hinge_height+wall_thickness + 2*fit_margin)*i)
    let(x=0,y=-i*10,z=-i*3.5)
    translate([x+i*50*0,y,z])slider(w,l,h);
    }
*/

module rope_spool(){
    difference(){
        translate([0,0,35/2])union(){
            cube([40*0.9,5,35], center=true);
            cube([5,40*0.9,35], center=true);
            translate([0,0,-35/2])cylinder(h=35, r=5, $fn=100);
        }
        cylinder(h=100, r=5/2, $fn=100, center=true);
        n1 = 3;
        for(j=[0:n1-1])
            for(i=[0:3])
                rotate([0,0,90*i])translate([0,10,(j+1)*35/(n1+1)])rotate([0,90,0])cylinder(h=100, r=3.5, $fn=100, center=true);
        
        n2 = 4;
        for(j=[0:n2-1])
            for(i=[0:3])
                rotate([0,0,90*i])translate([0,0,(j+1)*35/(n2+1)])rotate([0,90,45])cylinder(h=100, r=3/2, $fn=100, center=true);
            
        translate([0,0,35/2])rotate([0,90,0])cylinder(h=100,r=3/2,$fn=100, center=true);
    }
    translate([0,0,35/2])difference(){
        ring(h=35,r1=20,r2=18,$fn=100);
        translate([0,0,-35/2])thread(1.5,0.7,2.5,16,20);
        //mirror([0,0,-1])thread(1.5,0.7,2,8,20);
        translate([0,0,0])rotate([0,90,0])cylinder(h=100,r=3/2,$fn=100, center=true);
    }
}

rotate([0,0,0])rope_spool();


