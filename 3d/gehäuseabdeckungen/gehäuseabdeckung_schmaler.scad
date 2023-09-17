TE=5.08;
WIDTH= 20.5  * TE - 0.1;
HEIGHT=132;
THICKNESS=10;
EURORACK_HEIGHT=128.5;

COMB_MARGIN = 8;

// Mounting Hole Offset from the top / bottom edge
HOLE_OFFSET_Y = 3 + ( HEIGHT - EURORACK_HEIGHT)/ 2 ;
// Mounting Hole offset from the sides
HOLE_OFFSET_X = TE;
HOLE_RADIUS = 1.6;
// Number of Facets for the Holes. 
// A reasonably high number should be picked or else holes might end up to small
HOLE_FACETS = 48;

module profile(w){
    PROFILE1 = 8.8;
    PROFILE2 = 4.4;
    PROFILE3 = 80;
    THICKNESS1 = 2.5;
    THICKNESS2 = 1.2;
    THICKNESS3 = 3;
    
    cube([WIDTH, PROFILE1, THICKNESS1]);
    translate([0, PROFILE1, 0])
    cube([WIDTH, PROFILE2, THICKNESS2]);
    translate([0, PROFILE1 + PROFILE2, 0])
    cube([WIDTH, PROFILE3, THICKNESS3]);
    translate([0, HEIGHT, 0])
    mirror([0, 1,0]){
        cube([WIDTH, PROFILE1, THICKNESS1]);
        translate([0, PROFILE1, 0])
        cube([WIDTH, PROFILE2, THICKNESS2]);
        translate([0, PROFILE1 + PROFILE2, 0])
        cube([WIDTH, PROFILE3, THICKNESS3]);
    }

}

module hexagon(l)  {
	circle(d=l, $fn=6);
}

// parametric honeycomb  
module honeycomb(x, y, dia, wall)  {
	smallDia = dia * cos(30);
	projWall = wall * cos(30);

	yStep = smallDia + wall;
	xStep = dia*3/2 + projWall*2;

	difference()  {
		square([x, y]);

		// Note, number of step+1 to ensure the whole surface is covered
		for (yOffset = [0:yStep:y+yStep], xOffset = [0:xStep:x+xStep]) {
			translate([xOffset, yOffset]) {
				hexagon(dia);
			}
			translate([xOffset + dia*3/4 + projWall, yOffset + (smallDia+wall)/2]) {
				hexagon(dia);
			}
		}
	}
}
intersection(){
    difference(){

        union(){
          translate([COMB_MARGIN, COMB_MARGIN, 0])
          linear_extrude(THICKNESS)
            honeycomb(WIDTH - 2 * COMB_MARGIN, HEIGHT - 2*COMB_MARGIN, 4, 2);
          cube([WIDTH, COMB_MARGIN, THICKNESS]);
          cube([COMB_MARGIN, HEIGHT, THICKNESS]);
          translate([WIDTH-COMB_MARGIN,0, 0])
            cube([COMB_MARGIN,HEIGHT, THICKNESS]);
          translate([0, HEIGHT-COMB_MARGIN, 0])
            cube([WIDTH, COMB_MARGIN, THICKNESS]);
        }
        // The four mounting holes
        for (x =[HOLE_OFFSET_X, WIDTH-HOLE_OFFSET_X + 0.5*TE]){
            for (y =[HOLE_OFFSET_Y, HEIGHT-HOLE_OFFSET_Y]){
                color([1,0,0])
                translate([x, y, -0.1]){
                    cylinder(h = THICKNESS+0.2, r=HOLE_RADIUS, center=false, $fn=HOLE_FACETS); 
                };
            }
        };
    };
    profile(WIDTH);
};