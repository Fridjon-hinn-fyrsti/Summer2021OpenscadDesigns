module grooves(t1, t2, angle, length, width, depth){
    for(i=[0:length]){
        let(dz=(t1+t2)/(sin(90-angle)),x=0,y=0,z=0)
        let()
        translate([x,y,z+dz*i])rotate([0,angle,0])cube([width,depth,t1],center=true);
    }
    
}


module ring(r1,r2,h){
    difference(){
    cylinder(r=r1,h=h, $fn=100,center=true);
        cylinder(r=r2,h=h*2, $fn=100,center=true);
    }
}

difference(){
    union(){
        ring(6,4.08,4);
        for(i=[0:3])
            rotate([0,0,90*i])
        let(x=0,y=4.08,z=-1)
        
        translate([x,y,z])grooves(0.84, 1.06, 19.5, length=1, width=5, depth=1+0.5);
    }
    let(x=0,y=0,z=2.5)
    translate([x,y,z])cube([100,100,1],center=true);
    let(x=0,y=0,z=-2.5)
    translate([x,y,z])cube([100,100,1],center=true);
    
}
//translate([-2.5,+0.2,-5])cube([5,0.5,30]);