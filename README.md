# Coffee Vessel

A 3D-printable receptacle that attaches to a coffee grinder to catch fresh grounds, with a removable friction-fit lid and an angled pouring hole.

Fully parametric — every dimension is a named variable — modelled in [OpenSCAD](https://openscad.org) and dimensioned for a Sboly electric coffee grinder.

## Design overview

- **Body** — a half-cylinder shell (outer radius 51 mm) merged with a rectangular prism (96 × 21 mm) on its flat face, 91 mm tall overall, hollowed internally with rounded corners.
- **Interlock** — a D-shaped recess (33 mm wide, 50 mm long, 6 mm tall) in the floor, flat face flush with the rear wall, positively locates the vessel on the grinder so it can't slip or twist.
- **Lid** — matches the outer body profile and plugs into the hollow with a 0.5 mm clearance spigot: a snug friction fit, no fasteners. A rounded-rectangle outlet hole (26 × 36 mm, r = 5 mm, rotated 80°) lets grounds pour out without removing the lid.
- Wall reference thickness: 2.2 mm.

## Files

| File | What it is |
|---|---|
| `coffee_and_lid.scad` | **Source of truth** — final model: body + lid with `show_body` / `show_lid` toggles |
| `coffee.scad` | Earlier iteration — solid outer shell only |
| `coffee_hollow.scad` | Earlier iteration — hollowed interior added |
| `coffee_and_lid.3mf` | Combined body + lid, ready to slice |
| `coffee_vessel.stl` | Body only, exported for slicing |
| `coffee_lid.stl` | Lid only, exported for slicing |
| `coffee_and_lid.off` | Neutral-format mesh export |

## Customizing

1. Open `coffee_and_lid.scad` in OpenSCAD.
2. Edit the named dimensions at the top of the file (`outer_radius`, `body_height`, `wall`, `lid_clearance`, …) to match your grinder.
3. Preview with F5, render with F6, export STL or 3MF.

The `show_body` / `show_lid` toggles render each part on its own.

## Printing notes

- Parts print separately (`coffee_vessel.stl` + `coffee_lid.stl`), or together from the 3MF for a single print.
- The lid friction fit is tuned via `lid_clearance` (0.5 mm); increase it if the lid seats too tight on your printer.

## Copyright and license

© 2026 Julian — licensed under [CC-BY-4.0](LICENSE). Modifications welcome; attribution appreciated.