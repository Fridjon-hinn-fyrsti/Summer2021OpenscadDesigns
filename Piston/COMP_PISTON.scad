//MY LIBRARY

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
module thread(thread_width, wall_width, thread_depth,  n, r){
    detail = 100;
    for(j = [0:n-1])
    for(i = [1:detail])
        let(angle=i*360/detail, x=r*cos(angle),y=r*sin(angle),z=(i/detail+j)*(thread_width+wall_width))
        translate([x,y,z])rotate([0,0,angle])cube([thread_depth,thread_width,thread_width],center=true);
}
module stepper_holes(depth){
    temp = [1,-1,-1,1];
    for(i=[0:3])
        let(r = 31/2, dx = temp[i]*r, dz = temp[(i*2)%4]*r, x=0,y=0,z=0)
            translate([x+dx,y,z+dz])rotate([90,0,0])cylinder(h=depth,r=1.5*1.04,$fn=100,center=true);
    
}
module round_cube(size_x, size_y, size_z, r){
    temp = [1,-1,-1, 1];
    difference(){
        cube([size_x, size_y, size_z], center=true);
        for(i=[0:3])let(dx=temp[i]*(size_x/2-r/2+2.5),dz=temp[(i*2)%4]*(size_z/2-r/2+2.5))
            translate([dx,0,dz])cube([r+5, size_y+5, r+5], center=true);
    }
    for(i=[0:3])let(dx=temp[i]*(size_x/2-r),dz=temp[(i*2)%4]*(size_z/2-r))
        translate([dx,0,dz])rotate([90,0,0])cylinder(h=size_y,r=r,center=true,$fn=100);
}



//CODE

module piston_holes(depth){
    l = 150;
    w = 50;
    h = 45;
    wall_thickness = 2;
    hinge_height = 9;
    hinge_thickness = 5;
    bearing_thickness = 4;
    bearing_hole_radius = 2.4;
    fit_margin = 0.25;
     
     //drill holes
    for(i=[0:1])
    let(dx=[1,-1][i]*(0.8*w/2),x=0,y=0,z=h/2-hinge_height/2, r = bearing_hole_radius)
        translate([x+dx,y,z])rotate([90, 0, 0])cylinder(depth,r=r,center=true, $fn=100);

    for(i=[0:1])
    let(dx=[1,-1][i]*(0.8*w/2),x=0,y=0,z=-h/2+hinge_height/2, r = bearing_hole_radius)
        translate([x+dx,y,z])rotate([90, 0, 0])cylinder(depth,r=r,center=true, $fn=100);
}


//TEST

difference(){
    round_cube(50,5,50,5);
    piston_holes(100);
    rotate([90,0,0])cylinder(h=100,r=20,$fn=100,center=true);
}
cube([50,5,5],center=true);
difference(){
    for(i=[0:1])
        let(dx=[-1,1][i]*(50/2-5/2))
            translate([dx,-70/2,0])rotate([0,0,90])round_cube(70,5,10, 1);
    translate([0,-65,0])rotate([0,90,0])cylinder(h=100,r=5/2, center=true, $fn=100);
}

