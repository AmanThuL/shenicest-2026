# Checkpoint rescue in player builds

The hidden rescue panel lets a developer restart a stuck playtest at an authored checkpoint. It works in ordinary
desktop player builds, not only Development Builds. It is a local recovery tool, not a save system or a security boundary.

## Using it

- Press **Ctrl + Shift + D** to open or close it; **Esc** closes it without changing progress.
- Select a checkpoint, press **Reset and jump**, then press **Confirm reset and jump** to confirm the session reset.
  The developer UI uses English labels and an existing baked ASCII font, avoiding missing runtime Chinese glyphs.
- Opening the panel pauses simulation and audio, releases the cursor, and blocks gameplay input including physical
  interfaces that read `UI/Click`. Closing without jumping restores the previous pause, action and cursor state.
- The selected checkpoint replaces the running session's flags, report entries and time-of-day choice. Even a checkpoint
  in the current level reloads that entire level. There is no undo, disk save or automatic progress recovery.
- Controls are disabled during a jump. Failures stay visible in the panel so another checkpoint can be selected.
  A normal scene transition already in progress refuses a rescue request; a frozen main thread or crashed process cannot
  be repaired by an in-game panel.

## Authoring and packaging

`Data/DevPlay/` remains the single authoring source. Its `DevCheckpointSO` types stay Editor-only. The exporter copies
their stable asset GUIDs, labels, level references, spawn settings, flags and investigation targets into runtime-safe
`RescueCheckpoint` records in `Assets/RootsDance/Data/Config/RescueCheckpoints.asset`.

- **RootsDance > Dev Play > Install Build Checkpoint Rescue** creates/updates the screen prefab, installs the Debug
  actions in the project-wide input asset and wires Bootstrap. It refuses dirty open scenes, saves only those scoped
  assets, and restores the previous scene setup. It is an explicit authoring operation, not a debugging command.
- After changing checkpoint definitions, run **Tools > RootsDance > Dev Play > Refresh Rescue Checkpoints**.
- `Enabled In Player` on the generated catalog is the release switch. It is enabled for test distributions and retained
  when refreshing the catalog. Disable it before a public release if the rescue shortcut should be unavailable.
- The build preprocessor checks an enabled catalog against the current authored checkpoints and the actual build's
  scene list. Missing scenes, missing investigation references, invalid/duplicate IDs and stale generated data fail
  the build with an actionable message. It never silently changes the scene list or refreshes assets during a build.
- The catalog is referenced by Bootstrap, so its runtime records are included without `Resources`, Addressables,
  `AssetDatabase` calls or a runtime dependency on `RootsDance.Editor`.

## Runtime boundary

`CheckpointRescuePresenter` is the uGUI view/controller and talks to `ICheckpointRescueService`. The service lives beside
`GameBootstrap` and `SceneLoader`. `FirstPersonController` implements `ICheckpointSpawnTarget`; the App layer therefore
does not depend on a concrete player controller.

The operation first validates the request. It then freezes simulation, discards queued outgoing world commands and
cleans up persistent and scene-owned `IRescueResetParticipant`s. This includes dialogue cancellation, voices, subtitles,
and objects temporarily reparented to the persistent camera while inspected. The loader unloads the outgoing content
behind its cover. Only after teardown does Bootstrap replace the state contents silently; ordinary flag/report events
are not replayed. `IRescueStateRestoredParticipant` restores persistent presentation such as the final music track.

The new level loads additively. The loader's `sceneLoaded` hook positions the player before `Start`; spawn is checked
again before revealing the level. Scene-local state readers reconstruct gates, growth, helmet, lighting and active chase
state from the snapshot. Normal gameplay resumes on the existing command queue. A successful jump keeps the new level's
input/cursor setup rather than restoring a discarded scene's interaction lock.

Checkpoint definitions are authored presets, not arbitrary whole-world saves: inventory, in-progress animations and
unflagged local variables return to scene defaults. A once-only dialogue with a completed flag is suppressed when that
flag is already present; dialogue with no persistent completion flag has no historical completion record to restore.

## Verification

EditMode tests cover exported data, stale/missing build data, silent replacement of world state, discarded outgoing
commands, and exact modal action/pause restoration. PlayMode tests cover persistent dialogue cancellation and final
music restoration. Manual integration checks should include forward/backward and same-checkpoint reloads, opening while
interacting or chasing, disabled gameplay actions, repeated toggle, failure/retry and final cursor/input restoration.

Verified in Unity 6000.3.22f1 on 2026-08-30:

- Compilation succeeded. The full PlayMode suite passed all 27 tests.
- The full EditMode run passed 631 of 640 tests, with 8 failures and 1 skip. All 35 rescue-filtered tests in that
  run passed. The failures are assertions in untouched ChapterHouse first-meeting/flower-sprite content,
  Greenhouse model placement, trigger-layer scene discovery and the circulation-console theme. These content failures
  were not changed as part of rescue implementation; the full suite is not green.
- After the final font fix and added Bootstrap catalog-reference regression test, the focused rescue suite passed 36/36.
- Live Editor Play checks passed: the actual Ctrl+Shift+D action, modal pause/audio and cancellation restoration,
  chase checkpoint catch-up, backward reset clearing later flags, same-checkpoint reload, cross-level reload,
  reopening after travel, and two-click confirmation restoring a locked hidden cursor and unpaused gameplay.
- The installed catalog contains 17 checkpoints and passes validation against the enabled build scene list.
  No standalone player was exported in this task; the ordinary non-Development player path still needs a build smoke test.

The Editor Dev Play window remains an additive teleport/seed tool. Its **Go here** does not clear flags; this rescue
panel deliberately does. See [Dev Play](dev-play-checkpoints.md).
