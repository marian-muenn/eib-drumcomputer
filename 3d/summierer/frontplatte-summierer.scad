// 1TE = 5.08mm
TE=5.08;
// Plate Thickness. Default for Aluminium Eurorack Panels is 2mm
THICKNESS=3;
// Width in TE
WIDTH=8*TE;
// Default Euorack module height
HEIGHT=128.5;
// Mounting Hole Offset from the top / bottom edge
HOLE_OFFSET_Y = 3;
// Mounting Hole offset from the sides
HOLE_OFFSET_X = 7.5;
HOLE_RADIUS = 1.6;
// Number of Facets for the Holes. 
// A reasonably high number should be picked or else holes might end up to small
HOLE_FACETS = 48;
FONT_FACETS = 48;

// Parameters for the 3.5mm Jacks
JACK_X_SPACING = 10.668;
JACK_Y_SPACING = 16.480;
JACK_HOLE_RADIUS = 3.2;

MIDI_CUTOUT_RADIUS = 7.6;

// Font Sizes
FONT_SIZE_L=10;
FONT_SIZE_M=3.5;
FONT_DEPTH=1.5;
FONT="Corber:style=Regular";

//PLATE_COLOR=[0.1, 0.1, 0.1];
//TEXT_COLOR=[1.0, 1.0, 1.0];
TEXT_COLOR=[0.1, 0.1, 0.1];
TEXT_HEIGHT=1;
PLATE_COLOR=[1.0, 1.0, 1.0];

FONT_DISTANCE=2;
MIDI_CONNECTOR_MARGIN=2.5;
AUDIO_CONNECTOR_MARGIN=1.5;


difference() {
    // The main plate
    translate([0.15,0,0])
    color(PLATE_COLOR)
    cube([WIDTH-0.15, HEIGHT, THICKNESS]);
    
    
    // The four mounting holes
    for (x =[HOLE_OFFSET_X, WIDTH-HOLE_OFFSET_X]){
        for (y =[HOLE_OFFSET_Y, HEIGHT-HOLE_OFFSET_Y]){
            color([1,0,0])
            translate([x, y, -0.1]){
                cylinder(h = THICKNESS+0.2, r=HOLE_RADIUS, center=false, $fn=HOLE_FACETS); 
            };
        }
    };
   
    
    // The 3.5mm input Jacks
    translate([
        (WIDTH - 1 * JACK_X_SPACING) / 2,
        15 +  2 *JACK_Y_SPACING,
        0
    ]){
        for (i = [0:1]){
            for (j=[-2:1]){
                translate([i*JACK_X_SPACING, (j+1/2)*JACK_Y_SPACING, 0]){
                    cylinder(h=2*THICKNESS+0.2, r=JACK_HOLE_RADIUS+0.1, center=true, $fn=HOLE_FACETS);
                }
            }
        }
    }
       // The 6.3mm output Jack
    translate([
        WIDTH  / 2,
        4.5/6 * HEIGHT,
        0
    ]){
       cylinder(h=2*THICKNESS+0.2, r=4.5+0.1, center=true, $fn=HOLE_FACETS);
      };
      
    for (dx=[-73/2, 73/2]){
    translate([WIDTH -7, HEIGHT/2 +6+ dx, -0.1]){
        cylinder(
            h = THICKNESS+0.2, 
            r = 1.5, 
            center=false, 
            $fn=HOLE_FACETS
        );
    };
    }
 }



