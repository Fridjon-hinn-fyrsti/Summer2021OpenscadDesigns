



module thread(thread_width, wall_width, thread_depth,  n, r){
    detail = 10;
    for(j = [0:n-1])
    for(i = [1:detail])
        let(angle=i*360/detail, x=r*cos(angle),y=r*sin(angle),z=(i/detail+j)*(thread_width+wall_width))
        translate([x,y,z])rotate([0,0,angle])cube([thread_depth,thread_width,thread_width],center=true);
}

