# Coffee Vessel

A 3D-printable container for a SBOLY coffee grinder, with a lid

Fully parametric — every dimension is a named variable — modelled in [OpenSCAD](https://openscad.org)

I made this because the Sboly grinder seems to have been designed by someone who does not drink coffee. I found the controls to be vague, but the worst was the collection vessel. It has lots of annoying corners inside where the grounds lodge, and needs frequent cleaning. So I made a 3D printed version with rounded internals and no true corners at all inside.

I have included some of the 'work in progress' files, in case they are of use.

I am a total beginner with 3D printing. This is my first project. I printed it in a fetching purple colour on a friend's printer. I would make the rear flat wall thicker, and the lid is a bit loose. But I've printed my copy now and I'm not going to do it again. If you tweak it, please send me a PR!

# Parts

1. The Body - modelled after the original on the external faces. Rounded on the inside
2. The Lid - just a lid, with a hole in the right place.

## Files

| File | What it is |
| --- | --- |
| `coffee_and_lid.scad` | **Source of truth** — final model: body + lid with `show_body` / `show_lid` toggles |
| `coffee.scad` | Earlier iteration — solid outer shell only |
| `coffee_hollow.scad` | Earlier iteration — hollowed interior added |
| `coffee_and_lid.3mf` | Combined body + lid, ready to slice |
| `coffee_vessel.stl` | Body only, exported for slicing |
| `coffee_lid.stl` | Lid only, exported for slicing |
| `coffee_and_lid.off` | Neutral-format mesh export |

## Customizing

1. Open `coffee_and_lid.scad` in OpenSCAD.
2. Edit the named dimensions at the top of the file
3. Preview with F5, render with F6, export STL or 3MF.

## Printing notes

- Parts print separately (`coffee_vessel.stl` + `coffee_lid.stl`), or together from the 3MF for a single print.
- The lid friction fit is tuned via `lid_clearance` (0.5 mm). Tune this if it's a bit loose.

## Copyright and license

© 2026 N3jamboree — licensed under [CC-BY-4.0](LICENSE). Modifications welcome; attribution appreciated.

