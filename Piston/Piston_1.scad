module roller(r, length, x, y, z){
        for(i=[0:1])let(
        box_size = r*1.5,
        dx = [1,-1][i]*(length/2 + box_size/2))
        translate([x+dx,y,z])cube(box_size, center=true);
    
    
        translate([x,y,z])rotate([0, 90, 0])cylinder(length,r=r*0.5,center=true, $fn=100);

}


module arm(size, length, x, y, z){
    
    difference(){
        translate([x,y,z])cube([size,length,size], center=true);
        translate([x,y,z])cube([size*0.8,length*2,size*0.8], center=true);
        translate([x,y,z+size/2])cube([size*0.5,length*0.8,size*0.8], center=true);
    }
    let(r=size*0.15,y = y+length/2-r,z=z+size/2-r-0.1*size/2)
    {
    roller(r, size*0.4, x, y+length*0.008, z);
    roller(r, size*0.4, x, y-length*0.95, z+size*0.3);
    }
    
    for(i=[0:1])let(dx = [-1,1][i]*0.7*size/2,y=y,z=z+0.6*size/2)
        translate([x+dx,y,z])cube([size*0.23,length,size*0.23], center=true);
    
    
}


arm(15,70,20,30,3);
arm(8,70,0,2,0);
//roller(5, 20, 5, 3, 10);
