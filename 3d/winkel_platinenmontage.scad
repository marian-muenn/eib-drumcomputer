THICKNESS = 3;
HOLE_RADIUS = 1.4;
FACETS=24;


difference(){
    cube([10, 10, THICKNESS]);
    translate([10.5-THICKNESS, 5, -0.1]){
        cylinder(r=HOLE_RADIUS, h=THICKNESS + 0.2, center=false, $fn=FACETS);
    }
}
rotate([0,-90,0]){
    difference(){
        cube([10.5 + THICKNESS, 10, THICKNESS]);
        translate([11, 5, -0.1]){
            cylinder(r=HOLE_RADIUS, h=THICKNESS + 0.2, center=false, $fn=FACETS);
        }
    }
}