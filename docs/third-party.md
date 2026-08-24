# Third-party code and assets — record of exceptions

Guideline [02 Project structure](guidelines/02-project-structure.md) section 5 says vendor content goes under `Assets/ThirdParty/<Package>/`, is never edited, and that any exception (vendor-required path, unavoidable local edit) is recorded here so it survives the next update. One entry per package.

| Package | Version | Location | Exception / local edits | Owner guideline |
|---|---|---|---|---|
| Odin Inspector and Serializer (Sirenix) | 4.0.2.3 | `Assets/Plugins/Sirenix/` | **Vendor-required path**: Odin installs to and locates itself from `Assets/Plugins/Sirenix/` (`Odin Inspector/Assets/Editor/OdinPathLookup.asset`, the `Config/Editor/*.asset` files and the per-platform `Assemblies/` sub-folders are resolved relative to it), so it stays there instead of `Assets/ThirdParty/`. No local edits. Odin writes `ODIN_INSPECTOR*` scripting defines into `ProjectSettings/ProjectSettings.asset` per active build target group. The Odin serializer is deliberately unused. Imported 2026-08-24 as a team decision (each teammate holds a seat licence). | [12 Odin Inspector](guidelines/12-odin-inspector.md) |

When adding a row: package name, exact version, path, *why* it is an exception, and every file you had to touch (so the edit can be re-applied after a vendor update).
