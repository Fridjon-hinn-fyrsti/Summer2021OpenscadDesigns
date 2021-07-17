
module ring(r1,r2,h){
    difference(){
    cylinder(r=r1,h=h, $fn=100,center=true);
        cylinder(r=r2,h=h*2, $fn=100,center=true);
    }
}


difference(){
    ring(4, 2.5, 4);
    ring(10,3,2.1);
}