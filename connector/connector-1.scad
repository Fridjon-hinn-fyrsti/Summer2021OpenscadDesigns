
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

difference(){
    union(){
        translate([10,0,0])cube([40,20,10]);
        for(i = [0:1])translate([[10,50][i],10,5])cylinder(h=10, r=10, center=true, $fn=100);
    }
    
    for(i = [0:1])translate([[10,50][i],10,8])cylinder(h=12, r=7, center=true, $fn=100);
    for(i = [0:1])translate([[25,35][i],10,10])cylinder(h=100, r=2.7/2, center=true, $fn=100);
    for(i = [0:1])translate([[25,35][i],10,0])cylinder(h=13, r=3, center=true, $fn=100);

    for(i = [0:1])translate([[15,45][i],10,10])cylinder(h=100, r=2.7/2, center=true, $fn=100);
    for(i = [0:1])translate([[5,55][i],10,10])cylinder(h=100, r=2.7/2, center=true, $fn=100);
}