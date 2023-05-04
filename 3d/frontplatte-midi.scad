// 1TE = 5.08mm
TE=5.08;
// Plate Thickness. Default for Aluminium Eurorack Panels is 2mm
THICKNESS=3;
// Width in TE
WIDTH=12*TE;
// Default Euorack module height
HEIGHT=128.5;
// Mounting Hole Offset from the top / bottom edge
HOLE_OFFSET_Y = 3;
// Mounting Hole offset from the sides
HOLE_OFFSET_X = 7.5;
HOLE_RADIUS = 1.6;
// Number of Facets for the Holes. 
// A reasonably high number should be picked or else holes might end up to small
HOLE_FACETS = 12;

// Parameters for the 3.5mm Jacks
JACK_X_SPACING = 10.16;
JACK_Y_SPACING = 16.485;
JACK_HOLE_RADIUS = 3.2;

MIDI_CUTOUT_RADIUS = 7.6;

// Font Sizes
FONT_SIZE_L=10;
FONT_SIZE_M=2;
FONT_DEPTH=1.5;
FONT="Cantarell Light";

difference() {
    // The main plate
    color([0.9, 0.9, 0.9])
    cube([WIDTH, HEIGHT, THICKNESS]);
    
    // Header Text
    color([0.2,0.2,0.2])
    translate([WIDTH / 2, HEIGHT - FONT_SIZE_L - HOLE_OFFSET_Y, THICKNESS-FONT_DEPTH]){
        linear_extrude(FONT_DEPTH + 0.1)
        text("MIDI", size=FONT_SIZE_L, halign="center", font=FONT);
    }
    
    // The four mounting holes
    for (x =[HOLE_OFFSET_X, WIDTH-HOLE_OFFSET_X]){
        for (y =[HOLE_OFFSET_Y, HEIGHT-HOLE_OFFSET_Y]){
            color([1,0,0])
            translate([x, y, -0.1]){
                cylinder(h = THICKNESS+0.2, r=HOLE_RADIUS, center=false, $fn=HOLE_FACETS); 
            };
        }
    };
    translate([WIDTH / 2, 2/3 * HEIGHT, -0.1]){
        // center hole
        cylinder(h = THICKNESS+0.2, r=MIDI_CUTOUT_RADIUS, center=false, $fn=2*HOLE_FACETS);
        translate([-11.1,0,0]){
            cylinder(h = THICKNESS+0.2, r=1.7, center=false, $fn=HOLE_FACETS);

        };
        translate([11.1, 0, 0]){
            cylinder(h = THICKNESS+0.2, r=1.7, center=false, $fn=HOLE_FACETS);
        };
        translate([0, 12, THICKNESS]){
            color([0.2, 0.2, 0.2])
            linear_extrude(FONT_DEPTH + 0.1)
            text("MIDI IN", size=FONT_SIZE_M, halign="center", font=FONT);
        }
    }
    
    // The 3.5mm Jacks
    translate([
        (WIDTH - 3 * JACK_X_SPACING) / 2,
        15,
        0
    ]){
        for (i = [0:3]){
            for (j=[0:2]){
                translate([i*JACK_X_SPACING, j*JACK_Y_SPACING, 0]){
                    cylinder(h=2*THICKNESS+0.2, r=JACK_HOLE_RADIUS, center=true, $fn=HOLE_FACETS);
                    translate([0, 6, THICKNESS-0.1]){
                        color([0.2, 0.2, 0.2])
                        linear_extrude(FONT_DEPTH + 0.1)
                        text(str("OUT", (4*(4-j)+i)-7), size=FONT_SIZE_M, halign="center", font=FONT);
                    }
                }
            }
        }
    }
}