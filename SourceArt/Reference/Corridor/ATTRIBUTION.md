# Corridor rust references

Reference only — not shipped, not textures. The corridor's material is authored in
Substance Painter from `starter_assets` (Iron Old + Edge/Cavity Rust masks).

| file | source | licence | authors |
|---|---|---|---|
| rust_coarse_01.png | polyhaven.com/a/rust_coarse_01 | CC0 | Dimitrios Savva, Rico Cilliers |
| metal_grate_rusty.png | polyhaven.com/a/metal_grate_rusty | CC0 | Rob Tuytel, Dimitrios Savva |
| metal_plate_02.png | polyhaven.com/a/metal_plate_02 | CC0 | Rob Tuytel |
| green_metal_rust.png | polyhaven.com/a/green_metal_rust | CC0 | Rob Tuytel |

In-project rust already shipping, for look consistency:
`Assets/RootsDance/Textures/Environment/CarRustyOpenDoor_BaseMap.png` + `_Mask.png`

## rust_coarse_01/ — used as texture source, not just reference

1k JPG diffuse / normal(GL) / roughness from polyhaven.com/a/rust_coarse_01, CC0,
by Dimitrios Savva and Rico Cilliers. These feed the Painter fill layers: shelf
smart materials insert their structure but contribute no colour in a legacy
colour-managed project, so colour comes from image sources instead.
