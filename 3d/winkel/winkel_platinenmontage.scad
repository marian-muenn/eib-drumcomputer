THICKNESS = 3;
HOLE_RADIUS = 1.4;
FACETS=24;


difference(){
    cube([7, 10, THICKNESS]);
    translate([7-THICKNESS, 5, -0.1]){
        cylinder(r=HOLE_RADIUS, h=THICKNESS + 0.2, center=false, $fn=FACETS);
    }
}
rotate([0,-90,0]){
    difference(){
        cube([12.5 + THICKNESS, 10, THICKNESS]);
        translate([12, 5, -0.1]){
            cylinder(r=HOLE_RADIUS, h=THICKNESS + 0.2, center=false, $fn=FACETS);
        }
    }
}