// 1TE = 5.08mm
TE=5.08;
// Plate Thickness. Default for Aluminium Eurorack Panels is 2mm
THICKNESS=3;
// Width in TE
WIDTH=8*TE;
// Default Euorack module height
HEIGHT=128.5;
// Mounting Hole Offset from the top / bottom edge
MOUNTING_HOLE_OFFSET_Y = 3;
// Mounting Hole offset from the sides
MOUNTING_HOLE_OFFSET_X = 7.5;
MOUNTING_HOLE_RADIUS = 1.6;
// Number of Facets for the Holes. 
// A reasonably high number should be picked or else holes might end up to small
HOLE_FACETS = 48;
FONT_FACETS = 48;

// Parameters for the 3.5mm Jacks
JACK_HOLE_RADIUS = 4.3;
SWITCH_HOLE_RADIUS = 6.25;
POT_RADIUS=3.7;

AUDIO_JACK_HOLE_RADIUS = 3.25;

//PLATE_COLOR=[0.1, 0.1, 0.1];
//TEXT_COLOR=[1.0, 1.0, 1.0];
TEXT_COLOR=[0.1, 0.1, 0.1];
TEXT_HEIGHT=1;
PLATE_COLOR=[1.0, 1.0, 1.0];

FONT_DISTANCE=2;


PCB_HOLE_DISTANCE = [0,55,0];
PCB_HOLE_RADIUS = [1.6];


difference() {
    // The main plate
    translate([0.15,0,0])
    color(PLATE_COLOR)
    cube([WIDTH-0.15, HEIGHT, THICKNESS]);
    // The four mounting holes
    for (x =[MOUNTING_HOLE_OFFSET_X, WIDTH - MOUNTING_HOLE_OFFSET_X]){
        for (y =[MOUNTING_HOLE_OFFSET_Y, HEIGHT - MOUNTING_HOLE_OFFSET_Y]){
            color([1,0,0])
            translate([x, y, -0.1]){
                cylinder(h = THICKNESS+0.2, r=MOUNTING_HOLE_RADIUS, center=false, $fn=HOLE_FACETS); 
            };
        }
    };
    // 2 Potis
    for (dy=[5, 35]){
        // Potis
        translate([WIDTH / 2, HEIGHT*2/6 +dy, -0.1]){
            cylinder(
                h = THICKNESS+0.2, 
                r=POT_RADIUS, 
                center=false, 
                $fn=HOLE_FACETS
            );
        };
    };
    // 2 * 3.5mm Buchsen
    for (dx=[-8, 8]){
        translate([WIDTH / 2 + dx, HEIGHT/6 -2, -0.1]){
            cylinder(
                h = THICKNESS+0.2, 
                r = AUDIO_JACK_HOLE_RADIUS, 
                center=false, 
                $fn=HOLE_FACETS
            );
        };        
    }

    translate([WIDTH / 2, HEIGHT*5/6, -0.1]){
        cylinder(
            h = THICKNESS+0.2, 
            r = SWITCH_HOLE_RADIUS, 
            center=false, 
            $fn=HOLE_FACETS
        );
    };
    for (dx=[-73/2, 73/2]){
    translate([WIDTH -7, HEIGHT/2 +6 + dx, -0.1]){
        cylinder(
            h = THICKNESS+0.2, 
            r = 1.5, 
            center=false, 
            $fn=HOLE_FACETS
        );
    };
};  
};


