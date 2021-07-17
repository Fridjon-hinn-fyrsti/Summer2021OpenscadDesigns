module roller(r, length, x, y, z){
        for(i=[0:1])let(
        box_size = r*1.5,
        dx = [1,-1][i]*(length/2 + box_size/2))
        translate([x+dx,y,z])cube(box_size, center=true);
    
    
        translate([x,y,z])rotate([0, 90, 0])cylinder(length,r=r*0.5,center=true, $fn=100);

}
module box(size, length, height, x, y, z){
     difference(){
        translate([x,y,z])cube([size,length,height], center=true);
        translate([x,y,z])cube([size*0.8,length*2,height*0.8], center=true);
        translate([x,y,z+size/2])cube([size*0.48,length*1.8,height*0.8], center=true);
    }    
    for(i=[0:1])
        let(r=3, x=x,y=0,z=z+height/2-r  - (height/8), dx = [-1,1][i]*(0.9*size/2-5/2))
        //let(dx = [-1,1][i]*(0.9*size/2-5/2),y=y,z=z+height/4)
        translate([x+dx,y,z])cube([5,length,10], center=true);
    
    for(i=[0:1])let(cube_h = 10, dx = [-1,1][i]*0.6*size/2,y=y-length/2+5,z=z+height/2+cube_h/2)
        translate([x+dx,y,z])cube([5,10, cube_h], center=true);
    
}


module arm(size, length, height, x, y, z){
    
    difference(){
        box(size, length, height, x, y, z);
        let(r=3, x=x,y=y+length/2-r - (length/70),z=z+height/2-r  - (height/8))
        translate([x,y,z])rotate([0, 90, 0])cylinder(length,r=r,center=true, $fn=100);
        
        let(r=3, x=x,y=y-(length/2-r - (length/70)),z=z+height/2-r  + 8)
        translate([x,y,z])rotate([0, 90, 0])cylinder(length,r=r,center=true, $fn=100);
        //translate([x,y,z])rotate([0, 90, 0])cylinder(length,r=r,center=true, $fn=100);
    }
}


arm(40,110,40,0,0,0);
arm(31,110,21,40,0,-4.9);
//arm(8,70,0,2,0);
//roller(5, 20, 5, 3, 10);
