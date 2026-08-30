# Corridor Blockout

This folder contains the Blender source and Unity-ready FBX for the indoor
corridor/courtyard blockout.

## Files

- `RootsDance_Corridor_Blockout.blend`: editable Blender source.
- `RootsDance_Corridor_Blockout.fbx`: mesh-only export for Unity (`-Z` forward,
  `Y` up, unit scale applied).

## Layout Intent

The long metal bridge is positioned and scaled as an approximate composition
reference. It crosses above the cloth-like terrain inside the building. Keep
the bridge and building as separate objects so the level artist can refine the
fit in Unity or Blender.

No mushroom or mycelium placeholder assets are included. Final fungal assets
will be supplied separately.

## Look Development

The Blender source includes an initial blue-lighting pass:

- dark blue architectural material;
- dark metallic bridge material;
- ice-blue emission on the cloth-like bottom terrain;
- blue fill, bounce, and rim lights;
- dark blue world lighting.

The FBX carries meshes and basic material data only. Recreate emission bloom,
volumetric lighting, exposure, and final color grading with the Unity URP
Volume system; Blender lights and render post-processing are not the runtime
lighting setup.

## Source Asset Attribution

Both source models are licensed under Creative Commons Attribution 4.0.

### Building / Cloth Landscape

- Work: `Siii Lab - Abstracted Cloth Landscape`
- Creator: `siii-lab`
- Source: https://sketchfab.com/3d-models/siii-lab-abstracted-cloth-landscape-6f202b59d78d4c278585b0da52c346fc
- Creator profile: https://sketchfab.com/siii-lab
- License: CC BY 4.0, https://creativecommons.org/licenses/by/4.0/
- Modification: imported into Blender, materials simplified, parts separated,
  and arranged as an indoor corridor/courtyard blockout.

### Metal Bridge

- Work: `Bridge_ Metal_10_MB`
- Creator: `Mehdi Shahsavan`
- Source: https://sketchfab.com/3d-models/bridge--metal-10-mb-5933ffc71ca5427da825715660fa16d8
- Creator profile: https://sketchfab.com/ahmagh2e
- License: CC BY 4.0, https://creativecommons.org/licenses/by/4.0/
- Modification: retained only the long bridge component, then rotated, scaled,
  and positioned for the corridor blockout.
