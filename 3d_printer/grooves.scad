module grooves(t1, t2, angle, length, width, depth){
    for(i=[0:length]){
        let(dz=(t1+t2)/(sin(90-angle)),x=0,y=0,z=0)
        let()
        translate([x,y,z+dz*i])rotate([0,angle,0])cube([width,depth,t1],center=true);
    }
    
}

grooves(0.9, 1.2, 25, length=10, width=5, depth=1);
translate([-2.5,0,-5])cube([5,0.5,30]);