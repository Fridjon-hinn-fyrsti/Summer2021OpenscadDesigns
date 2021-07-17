module stepper_holes(depth){
    temp = [1,-1,-1,1];
    for(i=[0:3])
        let(r = 30.5/2, dx = temp[i]*r, dz = temp[(i*2)%4]*r, x=0,y=0,z=0)
            translate([x+dx,y,z+dz])rotate([90,0,0])cylinder(h=depth,r=1.5,$fn=100,center=true);
    
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


rotate([90,0,0])difference(){
    round_cube(42,3,42, 5);
    stepper_holes(20);
}