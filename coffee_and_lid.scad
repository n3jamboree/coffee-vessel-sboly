// Coffee receptacle - dimensions in mm
// ======================================

// Key dimensions
outer_radius   = 51.0;
body_height    = 86.5;
prism_width    = 96;
prism_depth    = 21;
lower_flange_h = 4.5;
side_flange_h  = 91.0;
side_flange_w  = 4.5;
side_flange_d  = 1.75;
lid_above      = 5;
lid_spigot     = 4.5;
lid_total      = 9.5;
wall           = 2.2;
d_width        = 33;
d_depth        = 50;
d_height       = 6;
corner_r       = 4;
lid_clearance  = 0.5;

// Void dimensions
void_prism_w   = 43;
void_prism_d   = 16;
void_cyl_r     = 43;

// Lid hole
hole_w         = 26;   // narrow dimension
hole_d         = 36;   // long dimension
hole_r         = 5;    // corner radius
hole_angle     = 80;  // clockwise from above
hole_x         = 10.7;
hole_y         = -1;

// Show/hide lid for inspection
show_lid       = true;
show_body      = true;

// Derived
void_floor     = lower_flange_h + d_height + 6;
void_top       = lower_flange_h + body_height + 1;
void_height    = void_top - void_floor;
body_top       = lower_flange_h + body_height;

// Half cylinder module
module half_cylinder(r, h) {
    difference() {
        cylinder(r=r, h=h, $fn=128);
        translate([-r-1, 0, -1])
            cube([r*2+2, r+1, h+2]);
    }
}

// D-shape module
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

// Internal void shape
module void_shape(h) {
    union() {
        translate([-void_prism_w, 0, 0])
            cube([void_prism_w*2, void_prism_d, h]);
        half_cylinder(void_cyl_r, h);
    }
}

// Lid spigot shape - void_shape shrunk by lid_clearance
module spigot_shape(h) {
    union() {
        translate([-(void_prism_w - lid_clearance), 0, 0])
            cube([(void_prism_w - lid_clearance)*2, void_prism_d - lid_clearance, h]);
        half_cylinder(void_cyl_r - lid_clearance, h);
    }
}

// Rounded rectangle for lid hole
module rounded_rect(w, d, h, r) {
    minkowski() {
        cube([w - 2*r, d - 2*r, h]);
        cylinder(r=r, h=0.01, $fn=32);
    }
}

// Lid module
module lid() {
    difference() {
        union() {
            // Upper part - matches external body profile
            translate([0, 0, lid_spigot]) {
                half_cylinder(outer_radius, lid_above);
                translate([-prism_width/2, 0, 0])
                    cube([prism_width, prism_depth, lid_above]);
            }
            // Lower spigot - derived from void_shape
            spigot_shape(lid_spigot);
        }

        // Lid hole - rounded rectangle, rotated 15 degrees clockwise
        translate([hole_x, hole_y, -1])
            rotate([0, 0, hole_angle])
                translate([-(hole_w - 2*hole_r)/2, -(hole_d - 2*hole_r)/2, 0])
                    rounded_rect(hole_w, hole_d, lid_total + 2, hole_r);
    }
}

// Full model
if (show_body) {
    difference() {
        union() {
            difference() {
                half_cylinder(outer_radius, lower_flange_h);
                translate([0, 1, -1])
                    half_cylinder(outer_radius - wall, lower_flange_h + 2);
            }
            translate([0, 0, lower_flange_h]) {
                half_cylinder(outer_radius, body_height);
                translate([-prism_width/2, 0, 0])
                    cube([prism_width, prism_depth, body_height]);
                translate([-prism_width/2 - side_flange_w, 0, body_height - side_flange_h])
                    cube([side_flange_w, side_flange_d, side_flange_h]);
                translate([prism_width/2, 0, body_height - side_flange_h])
                    cube([side_flange_w, side_flange_d, side_flange_h]);
            }
        }
        translate([0, prism_depth + wall, lower_flange_h - 1])
            rotate([0, 0, 180])
                d_shape(d_width, d_depth + wall, d_height + 1);
        translate([0, 0, void_floor])
            minkowski() {
                void_shape(void_height - corner_r);
                sphere(r=corner_r, $fn=32);
            }
    }
}

// Lid - translated to sit on top of body
if (show_lid) {
    translate([0, 0, body_top])
        lid();
}