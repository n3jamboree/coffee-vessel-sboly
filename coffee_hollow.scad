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
d_depth        = 50;   // front to back, measured from inner prism face
d_height       = 6;    // rises into void from floor plane
corner_r       = 3;    // minkowski rounding radius for internal void

// Void dimensions - explicitly specified
void_prism_w   = 44;   // half width of prism void (x = -45 to 45)
void_prism_d   = 17;   // depth of prism void (y = 0 to 15)
void_cyl_r     = 44;   // radius of half cylinder void

// Derived
void_floor     = lower_flange_h + d_height + 3;     // 13.5mm
void_top       = lower_flange_h + body_height + 1;  // +1 clears top surface
void_height    = void_top - void_floor;

// Half cylinder module
module half_cylinder(r, h) {
    difference() {
        cylinder(r=r, h=h, $fn=128);
        translate([-r-1, 0, -1])
            cube([r*2+2, r+1, h+2]);
    }
}

// D-shape module - flat face at y=0, centred on x=0, extends in +Y
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

// Internal void - prism void + half cylinder void, meeting flush at y=0
module void_shape(h) {
    union() {
        // Prism void - from y=0 toward prism back
        translate([-void_prism_w, 0, 0])
            cube([void_prism_w*2, void_prism_d, h]);
        // Half cylinder void - toward curved front (negative Y)
        half_cylinder(void_cyl_r, h);
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

    // D-shaped interlock recess - flat face flush with inner prism face
    translate([0, prism_depth + wall, lower_flange_h - 1])
        rotate([0, 0, 180])
            d_shape(d_width, d_depth + wall, d_height + 1);

    // Internal void - stadium shape, minkowski rounded, starts above D feature
    translate([0, 0, void_floor])
        minkowski() {
            void_shape(void_height - corner_r);
            sphere(r=corner_r, $fn=32);
        }
}