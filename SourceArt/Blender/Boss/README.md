# Mutant Plant Boss

Source files and visual checks for the non-combat chase boss.

## Runtime Assets

- `Assets/RootsDance/Meshes/Characters/Boss.fbx`: final skinned boss mesh.
- `Assets/RootsDance/Meshes/Characters/Boss_Blockout_Rooted.fbx`: rooted-state blockout.
- `Assets/RootsDance/Meshes/Characters/Boss_Blockout_Uprooted.fbx`: chase-state blockout.
- `Assets/RootsDance/Materials/Boss.mat`: Unity material.
- `Assets/RootsDance/Shaders/BossPulse.shadergraph`: URP animated material graph.
- `Assets/RootsDance/Shaders/BossPulse.hlsl`: vertex sway and pulse function.

## Blender Sources

- `Boss.blend`: final source.
- `Boss_Crawl.blend`: crawl animation/pose source.
- `Boss_Blockout.blend`: rooted and uprooted blockout source.
- `scripts/`: Blender generation, rigging, export, and validation scripts.
- `BlockoutRefs/`: scale, silhouette, first-person framing, and leg-count checks.

The boss is an original project asset. It is inspired by predatory plant forms
but does not contain geometry or textures from the external reference models.
