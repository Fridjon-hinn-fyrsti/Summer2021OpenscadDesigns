module grooves(t1, t2, angle, length, width, depth){
    for(i=[0:length]){
        let(dz=(t1+t2)/(sin(90-angle)),x=0,y=0,z=0)
        let()
        translate([x,y,z+dz*i-length*dz*0.5])rotate([0,angle,0])cube([width,depth,t1],center=true);
    }
    
}


module ring(r1,r2,h){
    difference(){
    cylinder(r=r1,h=h, $fn=100,center=true);
        cylinder(r=r2,h=h*2, $fn=100,center=true);
    }
}

rod_t1 = 0.84;
rod_t2 = 1.06;
rod_angle = 19.5;

module bolt(r1, r2, h){
    difference(){
        union(){
            ring(r1,r2,h);
            for(i=[0:3])
                rotate([0,0,90*i])
                let(x=0,y=r2,z=0)
                translate([x,y,z])grooves(rod_t1, rod_t2, rod_angle, length=20, width=5, depth=1+0.5);
        }
        temp = 200;
        let(x=0,y=0,z=h/2+temp/2)
        translate([x,y,z])cube([100,100,temp],center=true);
        let(x=0,y=0,z=-h/2-temp/2)
        translate([x,y,z])cube([100,100,temp],center=true);
        
       ring(100,r1,100);
        
    }
}

tolerance = 1.07;

module sled(size){
    difference(){
    cube([size,size,5], center=true);
    cylinder(h=size*2,r=size*0.5*0.7,center=true,$fn=100);
     temp = [1,-1,-1, 1];
     for(i=[0:3])let(r=0.6*size*0.5,dx=temp[i]*r,dy=temp[(i*2)%4]*r,x=0,y=0,z=0)
         translate([x+dx,y+dy,z])cylinder(h=size*2,r=1,center=true,$fn=100);
         
    }
    
    for(i=[0:1]){
        let(dx=[-1,1][i]*(size/2-5), x=0, y=0, z=-5/2-10/2)
        difference(){
            union(){
                translate([x+dx,y,z+5/2])cube([10,size,5],center=true);
                translate([x+dx,y,z]) rotate([90,0,0])cylinder(h=size,r=6,center=true,$fn=100);
            }
            translate([x+dx,y,z]) rotate([90,0,0])cylinder(h=size*2,r=4*tolerance,center=true,$fn=100);
            translate([x,y,z])cube([100,size*0.6,12], center=true);
        }
    }
    
    let(x=(size/2-5), y=0, z=-5/2-10/2){
            difference(){
            union(){
                translate([x,y,z+5/2])cube([10,20,5],center=true);
                translate([x,y,z]) rotate([90,0,0])cylinder(h=20,r=6,center=true,$fn=100);
            }
            translate([x,y,z]) rotate([90,0,0])cylinder(h=size*2,r=4*tolerance,center=true,$fn=100);
            //translate([x,y,z])cube([100,size*0.6,10], center=true);
        }
        translate([x,y,z])rotate([90,0,0])bolt(5, 4*tolerance, 20);
    }
}

sled(70);
//ring(12, 8, 2);
  