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
JACK_X_SPACING = 10.668;
JACK_Y_SPACING = 16.480;
JACK_HOLE_RADIUS = 4.2;

AUDIO_JACK_HOLE_RADIUS = 3;


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
    
    // The line out Ports
    translate([WIDTH / 2, 3/8 * HEIGHT, -0.1]){
        cylinder(h = THICKNESS+0.2, r=JACK_HOLE_RADIUS, center=false, $fn=2*HOLE_FACETS);
    }
    translate([WIDTH / 2, 1/8 * HEIGHT, -0.1]){
        cylinder(h = THICKNESS+0.2, r=JACK_HOLE_RADIUS, center=false, $fn=2*HOLE_FACETS);
    }
    
    // The audio in Ports
    translate([WIDTH / 2, 6/8 * HEIGHT, -0.1]){
        cylinder(h = THICKNESS+0.2, r=AUDIO_JACK_HOLE_RADIUS, center=false, $fn=2*HOLE_FACETS);
    }
     translate([WIDTH / 2, 5/8 * HEIGHT, -0.1]){
        cylinder(h = THICKNESS+0.2, r=AUDIO_JACK_HOLE_RADIUS, center=false, $fn=2*HOLE_FACETS);
    }
    
    // PCB MOUNTING HOLES
    translate([WIDTH -10 , HEIGHT * 1/2 - 55 / 2, -0.1]){
        cylinder(h = THICKNESS+0.2, r=PCB_HOLE_RADIUS, center=false, $fn=2*HOLE_FACETS);
        translate(PCB_HOLE_DISTANCE)
        cylinder(h = THICKNESS+0.2, r=PCB_HOLE_RADIUS, center=false, $fn=2*HOLE_FACETS);
    }

}



 // Header Text
 color(TEXT_COLOR)
 translate([WIDTH / 2, HEIGHT - FONT_SIZE_L - MOUNTING_HOLE_OFFSET_Y - 2, THICKNESS-0.1]){
    linear_extrude(TEXT_HEIGHT)
    text("out", size=FONT_SIZE_L, halign="center", font=FONT, $fn=FONT_FACETS);
}

// TEXT
translate([WIDTH / 2, 3/8 * HEIGHT + 6, THICKNESS-0.1]){
       color(TEXT_COLOR)
       linear_extrude(TEXT_HEIGHT)
       text("line out 1", size=FONT_SIZE_M, halign="center", font=FONT, $fn=FONT_FACETS);
}
translate([WIDTH / 2, 1/8 * HEIGHT + 6, THICKNESS-0.1]){
       color(TEXT_COLOR)
       linear_extrude(TEXT_HEIGHT)
       text("line out 2", size=FONT_SIZE_M, halign="center", font=FONT, $fn=FONT_FACETS);
}

// TEXT
translate([WIDTH / 2, 6/8 * HEIGHT + 4.5, THICKNESS-0.1]){
       color(TEXT_COLOR)
       linear_extrude(TEXT_HEIGHT)
       text("audio in 1", size=FONT_SIZE_M, halign="center", font=FONT, $fn=FONT_FACETS);
}
translate([WIDTH / 2, 5/8 * HEIGHT + 4.5, THICKNESS-0.1]){
       color(TEXT_COLOR)
       linear_extrude(TEXT_HEIGHT)
       text("audio in 2", size=FONT_SIZE_M, halign="center", font=FONT, $fn=FONT_FACETS);
}
