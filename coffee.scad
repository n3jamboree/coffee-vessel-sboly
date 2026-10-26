// Coffee receptacle - dimensions in mm
// ======================================

// Key dimensions
outer_radius   = 51.0;
body_height    = 86.5;
prism_width    = 96;
prism_depth    = 21;
lower_flange_h = 4.5;
side_flange_h  = 91.0;
side_flange_w  = 4.5;  // protrusion each side of prism
side_flange_d  = 1.75;
lid_above      = 5;
lid_spigot     = 4.5;
lid_total      = 9.5;
wall           = 2.2;  // body wall thickness
d_width        = 33;   // D-shaped interlock feature
d_depth        = 50;   // front to back
d_height       = 6;    // rises into void from floor plane

// Half cylinder module
module half_cylinder(r, h) {
    difference() {
        cylinder(r=r, h=h, $fn=128);
        translate([-r-1, 0, -1])
            cube([r*2+2, r+1, h+2]);
    }
}

// D-shape module - flat face at y=0, centred on x=0
module d_shape(w, d, h) {
    r = w/2;
    rect_d = d - r;
    union() {
        translate([-r, 0, 0])
            cube([w, rect_d, h]);
        translate([0, rect_d, 0])
            cylinder(r=r, h=h, $fn=64);
    }
}

// Full model - z=0 is bottom of lower cosmetic flange
difference() {

    // Outer body
    union() {

        // Lower cosmetic flange - hollow half cylinder ring at base
        difference() {
            half_cylinder(outer_radius, lower_flange_h);
            translate([0, 1, -1])
                half_cylinder(outer_radius - wall, lower_flange_h + 2);
        }

        // Main body shifted up by lower_flange_h
        translate([0, 0, lower_flange_h]) {

            // Half cylinder body
            half_cylinder(outer_radius, body_height);

            // Prism - centred on flat face
            translate([-prism_width/2, 0, 0])
                cube([prism_width, prism_depth, body_height]);

            // Side flanges
            translate([-prism_width/2 - side_flange_w, 0, body_height - side_flange_h])
                cube([side_flange_w, side_flange_d, side_flange_h]);
            translate([prism_width/2, 0, body_height - side_flange_h])
                cube([side_flange_w, side_flange_d, side_flange_h]);
        }
    }

    // D-shaped interlock recess - subtracted from base, flush with inner prism face
    translate([0, prism_depth + wall
    , lower_flange_h - 1])
        rotate([0, 0, 180])
            d_shape(d_width, d_depth + wall, d_height + 1);
}