HE=44.45;
TE=5.08;

WIDTH= 22  * TE;
HEIGHT=3*HE-2;
THICKNESS=5;
EURORACK_HEIGHT=128.5;
PLUG_POSITION=[15,15,0];
COMB_MARGIN = 8;

// Mounting Hole Offset from the top / bottom edge
HOLE_OFFSET_Y = 4;
// Mounting Hole offset from the sides
HOLE_OFFSET_X = TE;
HOLE_RADIUS = 1.6;
// Number of Facets for the Holes. 
// A reasonably high number should be picked or else holes might end up to small
HOLE_FACETS = 48;

module plug_positive(){
  PLUG_HEIGHT=20.5;
  PLUG_WIDTH=27.5;
  cube([PLUG_WIDTH + 20, PLUG_HEIGHT + 20, THICKNESS]);
}
module plug_negative(){
  PLUG_HEIGHT=20.5;
  PLUG_WIDTH=27.5;
  PLUG_SCREW_DISTANCE = 40;
  PLUG_SCREWHOLE_RADIUS=1.55;
  PLUG_SCREW_OFFSET = (PLUG_SCREW_DISTANCE - PLUG_WIDTH) / 2;
  translate([10,10, -0.1])
  cube([PLUG_WIDTH, PLUG_HEIGHT, THICKNESS + 0.2]);
  translate([10 - PLUG_SCREW_OFFSET, 10 + PLUG_HEIGHT / 2, -0.1])
  cylinder(h = THICKNESS+0.2, r=PLUG_SCREWHOLE_RADIUS, center=false, $fn=HOLE_FACETS);
  translate([10 + PLUG_WIDTH + PLUG_SCREW_OFFSET, 10 + PLUG_HEIGHT / 2, -0.1])
  cylinder(h = THICKNESS+0.2, r=PLUG_SCREWHOLE_RADIUS, center=false, $fn=HOLE_FACETS);

}
 difference(){
    union(){
        translate([0.05,0,0])
        cube([WIDTH-0.1, HEIGHT, THICKNESS]);
        translate(PLUG_POSITION)
        plug_positive();
    }
    translate(PLUG_POSITION)
    plug_negative();
    // The four mounting holes
    for (x =[HOLE_OFFSET_X, WIDTH-HOLE_OFFSET_X]){
        for (y =[HOLE_OFFSET_Y, HEIGHT-HOLE_OFFSET_Y]){
            color([1,0,0])
            translate([x, y, -0.1]){
            cylinder(h = THICKNESS+0.2, r=HOLE_RADIUS, center=false, $fn=HOLE_FACETS); 
            };
        }
    };
}
