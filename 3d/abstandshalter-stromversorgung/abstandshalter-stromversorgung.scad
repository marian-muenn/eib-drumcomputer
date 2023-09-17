for(i =[0:2]) {
    for (j =[0:2])
        translate([i*20, j*20, 0])
        spacer();
} 

module spacer(){
    difference(){
        cylinder(12, 3, 3, $fn=6);
        translate([0,0,-1])
        cylinder(14, 1.5, 1.5, $fn=8);
    }
}
