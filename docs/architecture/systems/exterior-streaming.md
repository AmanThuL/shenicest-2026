# Exterior streaming: how Main_Environment arrives behind a playable level

Main_Environment is streamed in additively while the player is still inside the greenhouse, with
nothing on screen to show for it. This page states the rules that keep it that way. Measurements
that justified them are in git history, not here; re-measure before changing a rule.

## The rule

**A scene that streams in behind gameplay must have nothing heavy left in its activation frame.**
Unity activates a scene's objects in one main-thread frame and no `async` moves that frame. Three
things are therefore kept out of it:

| Cost | Where it goes instead | Owner |
|---|---|---|
| Deserialization | Unity's loading thread (`LoadSceneAsync`, activation held until it parks at 0.9) | `SceneLoader` |
| MeshCollider cooking | Worker threads, via `Physics.BakeMesh` in a job, before activation is allowed | `SceneLoader` + `CollisionPrebakeSet` |
| Bulk placed content (vegetation) | Spawned over frames after activation, under a per-frame budget | `StreamedPlacementSpawner` + `StreamedPlacementSet` |

Anything added to Main_Environment that violates this (a new 50k-object prefab instance, a new set
of un-cooked mesh colliders) brings the activation stall back. Bake it or stream it.

## Vegetation is baked, never instanced

`Chapter00ZoneVegetationBuilder` still authors the `C00V_Group_*` prefabs under
`Prefabs/Environment/Chapter00ZoneVegetation/`; they remain the source of truth for what the
vegetation is. They are **not allowed to stay instanced in Main_Environment**. `StreamedVegetationBaker`
(run automatically at the end of the builder, or `RootsDance > Environment > Bake Streamed Chapter 00
Vegetation`) turns each group into:

- prototype prefabs in `Prefabs/Environment/Chapter00ZoneVegetation/Streamed/`, one per distinct
  (source prefab, materials, colliders, LODs) combination;
- `Data/Environment/Chapter00StreamedVegetation.asset`, every item's prototype, group and transform;
- a `Streamed Vegetation` object under `Prefab World Builder` carrying the spawner, whose group
  parents recreate the authored `Zone/PIN/C00V_Group_*` hierarchy at runtime.

Items that carry scripts (the scannable hero) are moved up to their PIN and stay in the scene: a
placement cannot carry per-instance data.

`Clear Chapter 00 A-E Vegetation` removes the spawner too, so a cleared scene has no vegetation at all
rather than stale streamed vegetation.

## Collision cooking is prebaked

`Data/Environment/Chapter00ExteriorCollisionPrebake.asset` lists every mesh a MeshCollider in
Main_Environment uses. `SceneLoader` (Bootstrap.unity, *Scene Prebakes*) cooks them on worker threads
while the scene deserializes and only then allows activation. The vegetation bake regenerates the set;
run `RootsDance > Environment > Bake Main Environment Collision Prebake` after adding or removing
colliders in the scene by hand. A stale set costs a few wasted cooks, never correctness.

Builds also have *Prebake Collision Meshes* on in Player Settings, so a player never cooks at all.

## Who asks for the stream

Two event channels reach `SceneLoader`, and both do the same work:

- `PreloadSceneRequested` — raised by `GreenhouseExitArmer` the moment `flow.chase_started` is up.
  This is the normal path: the ask comes minutes before the player reaches a door.
- `StreamSceneRequested` — raised by an `ExteriorStreamTrigger` when the player physically reaches
  an exit corridor. A fallback for a session where the early ask never happened.

`AdditiveContentStreamed` is raised once the scene is live (the baked-sky reveal cross-fades on it).
It fires when the scene activates, not when the last streamed item has spawned; nearest items to the
greenhouse exit spawn first, so the view through the windows fills before the far side of the map.

## Budgets

The spawner registers as `IDeferredContent`. `SceneLoader` reads the registry in two situations:

- Level load behind the cover (`Data/Levels/Main.asset` from a cold start): the cover waits for
  deferred content, and the content runs at its *covered* budget. The reveal is a complete level.
- Additive stream behind gameplay: no cover, *live* budget, whatever wall time it takes.

Both budgets are inspector fields on the spawner. Raise the live budget only with a frame-time
capture in a build proving the frame still fits; the Editor adds its own per-frame cost when tens
of thousands of objects appear in the Hierarchy and is not the place to judge it.

## Dev Play

Dev Play adopts already-open scenes, so a checkpoint in the Main level starts with vegetation still
spawning at the live budget for the first seconds. That is the Editor-only cost of skipping the cover
and is not a bug.
