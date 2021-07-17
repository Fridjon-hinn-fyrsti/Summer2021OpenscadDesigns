
module ring(r1,r2,h){
    difference(){
    cylinder(r=r1,h=h, $fn=100,center=true);
        cylinder(r=r2,h=h*2, $fn=100,center=true);
    }
}





cube([50,50,5], center=true);
for(i=[0:1]){
    let(dx=[-1,1][i]*(25-5), x=0, y=0, z=-5/2-10/2)
    difference(){
        union(){
            translate([x+dx,y,z+5/2])cube([10,50,5],center=true);
            translate([x+dx,y,z]) rotate([90,0,0])cylinder(h=50,r=5,center=true,$fn=100);
        }
        translate([x+dx,y,z]) rotate([90,0,0])cylinder(h=100,r=4,center=true,$fn=100);
    }


}

ring(12, 8, 2);
  