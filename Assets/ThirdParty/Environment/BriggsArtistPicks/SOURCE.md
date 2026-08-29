# Briggs Interior artist-selected models

These source meshes were copied from the team's local candidate library on 2026-08-29 and converted to FBX when Unity could not import the source format. Each model remains licensed under CC BY 4.0. The corresponding official Sketchfab metadata is preserved verbatim in `Attribution/`.

| Project file | Original model | Creator | Source |
|---|---|---|---|
| `Models/Chemistry_Old_Lab_Tubes.fbx` | 3rd - Chemistry // Old Lab Tubes | Ringo Gunther | <https://sketchfab.com/3d-models/3rd-chemistry-old-lab-tubes-9467a293daf04c58a4edae02a89783e6> |
| `Models/Lab_Glassware.fbx` | Lab Glassware | thelegokid4455 | <https://sketchfab.com/3d-models/lab-glassware-18910c5df5134de784ed6811407e2a05> |
| `Models/PSX_Adrenaline_Syringe.fbx` | PSX Adrenaline Syringe | ZwiebelGames | <https://sketchfab.com/3d-models/psx-adrenaline-syringe-97547a325dfc499cb3ffbb8abaa17c2a> |
| `Models/Astronomical_Quintant.fbx` | Astronomical quintant | Virtual Museums of Małopolska | <https://sketchfab.com/3d-models/astronomical-quintant-4b8e17593bd5457aaa958a85c1e5440d> |
| `Models/Kitchen_Lab_AbandonedDesk.fbx` | Kitchen And Lab by Amogusstrikesback2 | @sanyabeast / original model by amogusstrikesback2 | <https://sketchfab.com/3d-models/kitchen-and-lab-by-amogusstrikesback2-e9fdbbfb929e4bf796fa81d250fe6d64> |

Licence: <https://creativecommons.org/licenses/by/4.0/>

Conversion notes:

- Old Lab Tubes: copied from the downloaded FBX source.
- Lab Glassware: converted from the downloaded Blender file with Blender 5.2, geometry only.
- PSX Adrenaline Syringe: converted from the downloaded GLB with Blender 5.2, geometry only.
- Astronomical quintant: converted from the downloaded OBJ with Blender 5.2, geometry only. The original 8K textures are intentionally excluded; the project uses a new oxidized-brass material.
- Kitchen and Lab desk: extracted from the officially downloaded GLB with Blender 5.2. Only the
  `Kitchen_DeskBig_2` mesh is exported. `Textures/Kitchen_Lab_Desk_BaseColor.png` is a brighter,
  desaturated derivative of the supplied baked desk texture so the old wood and exposed metal remain readable under
  the Briggs PSX post-process. The preserved metadata records uploader @sanyabeast, the credited original creator
  amogusstrikesback2, and the original model link.

Project materials, colliders, scale normalization and prefab wrappers live under `Assets/RootsDance/`. Reworking a mesh or material does not remove the attribution requirement.
