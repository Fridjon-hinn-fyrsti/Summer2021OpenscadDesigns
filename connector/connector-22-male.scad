
*difference() {
	cylinder (h = 4, r=1, center = true, $fn=100);
	rotate ([90,0,0]) cylinder (h = 4, r=0.9, center = true, $fn=100);
}
*difference(){
    cube([3,3,1]);
    
    for(i=[0:3]){
        let (dx = ceil(i/2+0.1)-1, dy=i%2, r = 2, offset_ = 0.5)
        translate([dx*r+offset_,dy*r+offset_,1])cylinder (h = 1, r=0.2, center = true, $fn=100);
    }
    
    
}

module box(x,y,z,r) {translate([x-r/2,y-r/2,z-r/2])cube([r,r,r]);}
module centered_cube(x,y,z, xr,yr,zr) {translate([x-xr/2,y-yr/2,z-zr/2])cube([xr,yr,zr]);}
//box = function (x) x+x;//translate(x)cube(x);



difference(){
    //Body
    union(){
        translate([-20,-10,-5])cube([40,20,10]);
        for(i = [-1:2:1])translate([i*20,0,0])cylinder(h=10, r=10, center=true, $fn=100);
    }
    
    //Magnets
    for(i = [0:1])let (dx = 20, x = [-dx,dx][i],  y = 0, z=2){
        
        translate([x,y,z])cylinder(h=12, r=7, center=true, $fn=100);
        //Holes in Magnets
        for(i = [0:1])let ( dx = 5, x = [-dx+x,dx+x][i],  y = y)
            translate([x,y,0])cylinder(h=100, r=2.7/2, center=true, $fn=100);
    }
    
    //Ping ping holes
    for(i = [0:3])let ( dx = 3.2,dy = 3.2, x = [-dx,dx,-dx,dx][i],  y = [-dy,dy,dy,-dy][i], z=0, h = 6.5){
        translate([x,y,z])cylinder(h=100, r=2.7/2, center=true, $fn=100);
        translate([x,y,z -(10-h)/2 -1])cylinder(h=h+1, r=2.8, center=true, $fn=100);  
        
    }
    
    for(i = [0:3])let ( dx = 7,dy = 7, x = [-dx,dx,-dx,dx][i],  y = [-dy,dy,dy,-dy][i], z=0){
        translate([x,y,z])cylinder(h=100, r=2.7/2, center=true, $fn=100);
    }
}

let(x=0,y=0,z=20)difference(){
    box(x,y,z,20);
    
    for(i=[0:1])let(dy = 7, x = x, y = [-1,1][i]*dy+y, z=z+10)centered_cube(x,y,z, 200,10,35);
        
    //Drill holes for wire cover
    for(i = [0:3])let ( dx = 7,dy = 7, x = [-dx,dx,-dx,dx][i],  y = [-dy,dy,dy,-dy][i], z=0){
        translate([x,y+1,z])cylinder(h=100, r=2.7/2, center=true, $fn=100);
        translate([x,y,z])cube([2.7,2.7,500], center=true);
        translate([x,y-1,z])cylinder(h=100, r=2.7/2, center=true, $fn=100);
    }
    
    cylinder(h=100, r=7, center=true, $fn=100);
}






