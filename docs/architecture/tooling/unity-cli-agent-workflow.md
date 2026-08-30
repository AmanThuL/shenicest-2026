# Driving the Editor from the shell: Unity CLI + Pipeline (humans and AI agents)

> **Scope:** Running tests and builds, and inspecting or driving the *open* Editor (Play mode, scenes, Console, screenshots, C# eval, breakpoints) from a terminal with the official Unity CLI and the `com.unity.pipeline` package — for teammates and for AI agents working on a machine where the Editor is open.
> **Applies to:** everyone who runs `unity …` against this project; every agent instruction file (`AGENTS.md`, personal `CLAUDE.local.md`).
> **Status:** verified 2026-08-25 on macOS (Apple Silicon), Unity 6000.3.22f1, Unity CLI 1.0.0-beta.5, `com.unity.pipeline` 0.5.0-exp.1. The package was added on branch `chore/agent-debug-workflow` and **adopted by the team on 2026-08-25** (section 3). Anything marked **UNVERIFIED** was read from `unity <cmd> --help` or the docs, not exercised.

Owning guidelines: test/build commands and IDE debugging in [08](../../guidelines/08-testing-tooling.md); package policy in [09](../../guidelines/09-packages-systems.md); what is committed in [06](../../guidelines/06-version-control.md). This document adds the how-to on top of them and changes none of their rules.

## TL;DR — rules at a glance

1. **MAY** use the official Unity CLI (`unity`) in two modes: Editor **closed** → `unity test` / `unity build` / `unity run` spawn a batchmode Editor (the `-batchmode` commands of 08 with nicer output); Editor **open** → `unity command <tool>` talks to it over loopback HTTP (needs `com.unity.pipeline`).
2. **MUST** run `unity status` first: one Editor per project — batch commands collide with an open Editor.
3. **MUST** pass tool parameters as `--name value`; `name=value` is silently dropped. Parameters that collide with CLI options go after `--`.
4. **MUST** wrap every Pipeline call in `timeout` and poll `editor_status` after anything that reloads the domain (Play entry, recompile, Code Optimization switch): the server is down during reloads, and a hang means the Editor is stopped at a breakpoint.
5. **MUST** treat `eval` / `eval_file` as running an Editor script: a C# method body, `return` a string, fully-qualified types, no `using`.
6. **SHOULD** read logs with `console --tail N --level … --since <cursor>` (survives reloads), not `get_console_logs` (emptied by every reload).
7. **SHOULD** run tests as `unity command --detach run_tests --mode editor [--filter <Fixture>]` + `unity job wait <id>`; call `recompile` at most once per edit and poll `recompile_status`.
8. **NEVER** `save_scene` / `save_all` / `build` / asset-writing `menu` items / `capture_* --save_path` from an agent unless the human asked; **NEVER** leave Play mode running, a debugger attached or Code Optimization changed. `git status --short` is identical before and after a session.
9. **NEVER** open **Window > Pipeline > Settings…** — it writes `Assets/Settings/Pipeline/…` outside `Assets/RootsDance/`.
10. **NEVER** add a `RuntimePipelineManager` component to a scene: the package's Player-side server stays inert only while none exists.
11. **MUST** commit the package as `Packages/manifest.json` + `Packages/packages-lock.json` in one `chore(packages):` commit — after the team confirms section 3.
12. **MAY** switch the Editor to **Debug** Code Optimization from the shell for a breakpoint session (≈ 14 s reload each way); **MUST** restore **Release** afterwards (08).

## 1. What you need

| Item | Detail |
|---|---|
| Unity CLI `unity` (1.0.0-beta.5, 2026-08-13) | macOS: `brew install --cask unity-cli`, or `curl -fsSL https://public-cdn.cloud.unity3d.com/hub/prod/cli/install.sh \| UNITY_CLI_CHANNEL=beta bash`; Unity Hub also installs it; `unity upgrade` self-updates. Needs macOS 14+ and Unity 6.0+ for Editor control. |
| Sign-in | `unity auth login` once (OAuth; token in the keychain). Exit code 3 = auth problem. |
| `PATH` | The binary lives in `~/.unity/bin/`; the installer adds `source ~/.unity/env` to the interactive shell rc only. Non-interactive shells (agents, IDE tasks, cron) must call `~/.unity/bin/unity` by absolute path or `source ~/.unity/env` first. |
| Editor-open mode | `com.unity.pipeline` in `Packages/manifest.json` (`unity pipeline install` writes `"com.unity.pipeline": "0.5.0-exp.1"`). Gotcha: an Editor that is already open resolves an externally edited manifest only when its window regains focus; ≈ 60 s later `unity status` reports `7800 ready`. |
| Health check | `unity status` (port, state, Editor PID) and `unity pipeline list` (Editors with a reachable server). `unity --json command --detail full` lists all 143 tools with schemas (`.data.commands[]{name,parameters[],schema}`); narrow with `--query <term>` / `--tag <tag>`. |

`unity mcp` (stdio MCP over the same server) and `unity skill install claude-code` (installs a `unity-cli` skill into `~/.claude/skills/`) exist; Unity's own guidance is that shell-capable agents call `unity command` / `eval` directly, which is what this document does. **[project decision: no Unity MCP server is configured]**

## 2. Two modes

| Editor | Command family | What happens | Equivalent in [08](../../guidelines/08-testing-tooling.md) / `AGENTS.md` |
|---|---|---|---|
| **open** | `unity status`, `unity list`, `unity command <tool> [--param value]`, `unity job wait <id>` | HTTP to the running Editor on `127.0.0.1:78xx` (ports 7800–7849); bearer token + port in `Library/Pipeline/.unity-pipeline-port` (mode 0600, rewritten each heartbeat) | none — new capability |
| **closed** | `unity test [project] --mode editor\|playmode [--filter <regex>] --output <dir>` | spawns a batchmode Editor, writes an NUnit/JUnit report | `-batchmode -runTests -testPlatform EditMode -testResults …` |
| **closed** | `unity build --profile Assets/RootsDance/Settings/BuildProfiles/<name>.asset -o <dir>` | batchmode build from a committed Build Profile (pass the asset path, not a name) | `-batchmode -quit -activeBuildProfile … -build …` |
| **closed** | `unity run -- -executeMethod <Type.Method> …` | raw Editor arguments | the `-executeMethod` escape hatch |
| open → closed | `unity projects close` | closes the running Editor gracefully | — |

The batch commands are **UNVERIFIED** in this project (the Editor was open during the spike; documented from `--help` and the docs). One Editor per project still holds: run batch commands only when `unity status` shows no Editor, or close it.

## 3. The package decision: `com.unity.pipeline` 0.5.0-exp.1

**What it is.** An experimental Unity package (`-exp`: hidden from the Package Manager UI, API may change; its changelog never mentions 6.3, but the code has `UNITY_6000_3_OR_NEWER` branches) that starts a loopback HTTP "Pipeline" server inside the Editor and exposes 143 tools (sections 5–8). `LICENSE.md` = Unity Package Distribution License (the README says Companion License; `LICENSE.md` governs). Dependencies: `com.unity.test-framework` 1.1.33, `com.unity.nuget.newtonsoft-json` 3.0.2, `com.unity.nuget.mono-cecil` 1.11.6; the lock file gains `com.unity.nuget.newtonsoft-json`. Assemblies: `Unity.Pipeline` (Runtime, **all platforms**), `Unity.Pipeline.Editor`, `Unity.Pipeline.CodeGen` (Editor). It shipped in the Universal 3D template manifest and was removed at import on 2026-08-24 as "experimental" ([09](../../guidelines/09-packages-systems.md)); this branch re-adds it.

**What it costs the team** — audit of `Library/PackageCache/com.unity.pipeline@<hash>/` (`P` below); ⚠ = worry:

- ⚠ **Player builds.** The HTTP server code is compiled into every Player (only Roslyn eval/hot-reload is `#if UNITY_EDITOR || (UNITY_STANDALONE && DEBUG)`); no listener starts unless a `RuntimePipelineManager` component with `enableInBuilds` (default off) sits in a build scene — `P/Runtime/PlayerSupport/RuntimePipelineManager.cs:25,41,122-128`; the build processor only warns. `ConsoleLogCapture.RuntimeBootstrap` (`[RuntimeInitializeOnLoadMethod]`) runs in every Player — a 2000-entry log ring buffer, cheap. Bundled Roslyn DLLs ≈ 9.8 MB (`P/Runtime/Plugins/CodeAnalysis/*.dll.meta`, enabled for Win/Win64/OSX/Linux64); nothing strips them for release builds (effect of managed stripping UNVERIFIED). Every Player build logs "No RuntimePipelineManager components found…" and additively opens every build scene during preprocess.
- ⚠ **Editor, for everyone with the package.** `[InitializeOnLoad]` starts the server on every domain reload (unless a settings asset sets AutoStart = false); one Console warning per reload — "Editor is not in automated mode… start with -automated" (not from `RootsDance.*`, so 08 rule 12 is not broken, but a persistent yellow line); **auto-tick is on by default** — it forces `EditorApplication.SignalTick` via reflection so the Editor keeps compiling and playing while unfocused (CPU/battery); three extra assemblies per reload; a possible macOS firewall prompt.
- ⚠ **`Window > Pipeline > Settings…`** creates `Assets/Settings/Pipeline/EditorPipelineManager.asset` **outside** `Assets/RootsDance/` ([02](../../guidelines/02-project-structure.md)). Do not click it; if you did, move or delete the asset inside the Editor.
- **Security.** Binds `http://+:<port>/` (wildcard at socket level) but answers 403 to non-loopback addresses and to any request carrying an `Origin` header (`P/Runtime/Common/BasePipelineServer.cs:273-276,452-467`); bearer token = 256-bit CSPRNG, constant-time compare, held in `SessionState` and `Library/Pipeline/.unity-pipeline-port`. `eval` runs arbitrary C# on the Editor main thread — the same trust level as a script in the project.
- **Neutral.** The IL post-processor (`P/CodeGen/HotReloadInPlaceILPostProcessor.cs`) only weaves assemblies that reference `Unity.Pipeline` and contain `[HotReload]` methods — zero effect on `RootsDance.*`. No scripting defines, no `ProjectSettings/` changes, no auto-refresh or focus changes.

**What changes in git.** Only `Packages/manifest.json` and `Packages/packages-lock.json` — commit both as `chore(packages): add com.unity.pipeline 0.5.0-exp.1` ([06](../../guidelines/06-version-control.md) rule 11). `Library/Pipeline/`, `Temp/pipeline_*.json` and `Logs/pipeline.log` (request logging, off by default) are already ignored.

**Adopted by the team on 2026-08-25 under the conditions below. [project decision]**

1. Keep `com.unity.pipeline` on `develop` for the hackathon so every teammate (and their agents) can use sections 5–9 without touching the manifest; TL;DR rules 9–10 then apply to everyone.
2. Nobody adds a `RuntimePipelineManager`; nobody opens the Settings window; the "not in automated mode" warning is accepted as known noise.
3. Before the submission build from `main`, either remove the package in its own `chore(packages):` commit, or check one `*-Release` build's size and log for the Roslyn DLLs (UNVERIFIED today) and record the result here.
4. Alternative if rejected: each user installs it locally and never commits the manifest — workable, but `git status` is then never clean and every `chore(packages):` merge conflicts; not recommended.

## 4. CLI syntax rules (all verified)

- Output: `--no-banner`; `--json` (or `--format json|tsv|ndjson|human`; piped output defaults to TSV); `--non-interactive`, `--quiet`; env `UNITY_FORMAT`, `UNITY_NON_INTERACTIVE`, `UNITY_PROJECT_PATH`, `UNITY_NO_PAGER=1` (`unity list` rejects `--no-pager`).
- Tool parameters: `--name value` or `--name=value`; a bare flag (`--additive`) means true; `--include_inactive false` for an explicit false. **`name=value` is silently dropped** — the call still returns `success: true` with `parameters: {}`; check `.data.parameters` whenever a tool seems to ignore you.
- Parameters that collide with CLI options go after `--`: `unity command eval --code '…' -- --timeout 9000` (`eval`'s main-thread timeout in ms; default 5000 → HTTP 400 "Main thread operation timed out").
- Envelope: `{success, data: {command, parameters, result}, errors[], warnings[]}`. Exit codes: 0 ok · 2 usage · 3 auth · 6 operation failed (e.g. tests failed) · 7 retryable service error.
- Long operations: `unity command --detach run_tests …` returns a job id; `unity job wait <id> [--timeout … --poll-interval …]`, `unity job status|cancel <id>`. Jobs are lost on domain reload.
- During **any** domain reload (Play-mode entry, recompile, Code Optimization switch) the server is **down** — a network error ("No Unity Editor instances found with reachable Pipeline servers"), not a 503 — poll `unity command editor_status` until it answers. A 503 with `retryable: true` ("settling") occurs only on cold import.
- Running Player builds: `unity command --runtime <exe-name> <tool>` / `--runtime-path <dir>` (ports 7900–7949; needs a `RuntimePipelineManager` with `enableInBuilds`). UNVERIFIED and not used here (TL;DR 10).

## 5. Scene-debugging loop (Editor open) — verified

```bash
U=unity                                   # ~/.unity/bin/unity in a non-interactive shell
S=/abs/dir/outside/Assets                 # where dump-hierarchy.cs / dump-play.cs (below) live
ENV=Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Environment.unity
GP=Assets/RootsDance/Scenes/Levels/PlayerTest/PlayerTest_Gameplay.unity
pm(){ timeout 5 $U --no-banner --json command editor_status 2>/dev/null | jq -r '.data.result.playMode // "down"'; }
wait_pm(){ until [ "$(pm)" = "$1" ]; do :; done; }     # ≈ 0.1 s per poll; "down" while the domain reloads
wait_s(){ t=$(date +%s); while [ $(( $(date +%s)-t )) -lt "$1" ]; do pm >/dev/null; done; }  # busy-wait: some agent sandboxes block sleep

$U --no-banner status                                                        # 7800 ready … PID
$U --no-banner --json command list_open_scenes | jq -c '.data.result.scenes[]|{name,isActive,isDirty}'  # abort if any isDirty; note the set
$U --no-banner --json command open_scene --path $ENV                         # Single → becomes the active scene
$U --no-banner --json command open_scene --path $GP --additive               # bare flag == true
$U --no-banner --json command eval_file --file $S/dump-hierarchy.cs | jq -r '.data.result.result'
$U --no-banner --json command editor_play | jq -c .data.result               # "Entered play mode" after 0.2 s, then the server goes down
wait_pm playing; wait_s 2                                                    # first Play entry ≈ 18 s, later ≈ 3 s
$U --no-banner --json command eval_file --file $S/dump-play.cs | jq -r '.data.result.result'
$U --no-banner --json command eval --code 'return Time.frameCount;' | jq .data.result.result
$U --no-banner --json command screenshot --view game --output $S/game.png | jq -c .data.result   # 1920×1080 PNG, 0.3 s
$U --no-banner --json command console --tail 30 --level warn | jq -c '.data.result.entries[]|{level,message}'
$U --no-banner --json command editor_stop; wait_pm stopped                   # 0.6 s
$U --no-banner --json command open_scene --path $GP                          # restore the original scene set (Single open)
```

Observed on `PlayerTest`: Play mode keeps ticking while the Editor is unfocused (`Application.runInBackground = true` + auto-tick; `frameCount` 1996 → 3566 in ≈ 2 s, `Application.isFocused` reads true); `sceneCount=3 active=PlayerTest_Environment : PlayerTest_Environment PlayerTest_Gameplay Bootstrap` (the `BootstrapLoader` added `Bootstrap`); Player at (0.00, 1.08, -10.00); `Camera.main = Main Camera`; `CinemachineBrain` active vcam `FirstPersonCamera`; the Game-view screenshot showed sky, ground and landmark cubes — usable for visual verification.

- `screenshot --view scene` fails in Play mode ("No active Scene view") and works in edit mode (1451×924). `capture_game_view --source screen --max_resolution 320` returns inline base64; its `save_path` is project-relative and would write inside the repo — use `screenshot --output <abs path>`.
- `set_active_scene` errors if the scene is already active; a Single `open_scene` already makes it active.
- `get_scene_hierarchy --path <scene>` → `{sceneName, isActive, isDirty, roots[{name, instanceId, hierarchyPath, activeSelf, components[], children[]}]}` — names and component types only, no transforms or values; use `eval_file` for those. `get_serialized_fields --target <hierarchyPath> --component <Type>` exists (not exercised).

`dump-hierarchy.cs` — every loaded scene's roots (4 levels deep), component lists, positions of roots / `Player` / cameras, Cinemachine `Follow` / `LookAt`:

```csharp
var sb = new System.Text.StringBuilder();
System.Action<GameObject, int> dump = null;
dump = (go, depth) =>
{
    sb.Append(new string(' ', depth * 2)).Append(go.activeSelf ? "" : "(off) ").Append(go.name);
    var comps = go.GetComponents<Component>();
    var names = new System.Collections.Generic.List<string>();
    foreach (var c in comps)
    {
        if (c == null) { names.Add("<missing>"); continue; }
        var t = c.GetType();
        if (t == typeof(Transform)) continue;
        names.Add(t.Name);
        if (t.Name == "CinemachineCamera")
        {
            var follow = t.GetProperty("Follow") != null ? t.GetProperty("Follow").GetValue(c) as Transform : null;
            var lookAt = t.GetProperty("LookAt") != null ? t.GetProperty("LookAt").GetValue(c) as Transform : null;
            sb.Append("  [CM Follow=" + (follow == null ? "null" : follow.name) + " LookAt=" + (lookAt == null ? "null" : lookAt.name) + "]");
        }
    }
    sb.Append("  {" + string.Join(", ", names) + "}");
    if (depth == 0 || go.name == "Player" || go.GetComponent<Camera>() != null)
        sb.Append("  pos=" + go.transform.position.ToString("F2"));
    sb.Append('\n');
    if (depth < 4)
        for (int i = 0; i < go.transform.childCount; i++) dump(go.transform.GetChild(i).gameObject, depth + 1);
};
int n = UnityEngine.SceneManagement.SceneManager.sceneCount;
var active = UnityEngine.SceneManagement.SceneManager.GetActiveScene();
sb.Append("sceneCount=" + n + " active=" + active.name + "\n");
for (int i = 0; i < n; i++)
{
    var s = UnityEngine.SceneManagement.SceneManager.GetSceneAt(i);
    sb.Append("== scene[" + i + "] " + s.name + " loaded=" + s.isLoaded + " dirty=" + s.isDirty + " roots=" + s.rootCount + "\n");
    if (!s.isLoaded) continue;
    foreach (var root in s.GetRootGameObjects()) dump(root, 0);
}
return sb.ToString();
```

`dump-play.cs` — Play-mode state, scene list, Player position, `Camera.main`, active Cinemachine camera:

```csharp
var sb = new System.Text.StringBuilder();
sb.Append("isPlaying=" + EditorApplication.isPlaying + " frame=" + Time.frameCount + " timeScale=" + Time.timeScale + " runInBg=" + Application.runInBackground + " focused=" + Application.isFocused + "\n");
int n = UnityEngine.SceneManagement.SceneManager.sceneCount;
sb.Append("sceneCount=" + n + " active=" + UnityEngine.SceneManagement.SceneManager.GetActiveScene().name + " :");
for (int i = 0; i < n; i++) sb.Append(" " + UnityEngine.SceneManagement.SceneManager.GetSceneAt(i).name);
sb.Append("\n");
var player = GameObject.Find("Player");
sb.Append("Player=" + (player == null ? "null" : player.transform.position.ToString("F2")) + "\n");
var cam = Camera.main;
sb.Append("Camera.main=" + (cam == null ? "null" : cam.name + " pos=" + cam.transform.position.ToString("F2")) + "\n");
var brain = UnityEngine.Object.FindFirstObjectByType<Unity.Cinemachine.CinemachineBrain>();
sb.Append("Brain=" + (brain == null ? "null" : brain.name + " active=" + (brain.ActiveVirtualCamera == null ? "null" : brain.ActiveVirtualCamera.Name)) + "\n");
return sb.ToString();
```

(`GameObject.Find` is fine here — this is a throw-away diagnostic snippet, not gameplay code; [03](../../guidelines/03-architecture-patterns.md) still bans it in `RootsDance.*`.)

## 6. Inspecting state with `eval` / `eval_file` (verified)

- The snippet is a C# **method body** (a statement list): `return x;` yields the value; no `return` → `result: null`; a bare expression fails with "; expected".
- `using` directives are rejected — fully qualify. `UnityEngine` and `UnityEditor` are pre-imported; project types (`RootsDance.Player.FirstPersonController`) and package types (`Unity.Cinemachine.CinemachineBrain`) resolve. Write `UnityEngine.Object.FindFirstObjectByType<T>()` — bare `Object.` is ambiguous.
- Serialization: numbers, strings and arrays come back as JSON; everything else is `ToString()` (`Vector3` → `"(1.00, 2.00, 3.00)"`; a `UnityEngine.Object` → `null`). Build a string (`StringBuilder`) and return it.
- Compile errors arrive as `errors[].message` "Compilation Failed … (line,col)"; exceptions as "Runtime Error …". `Debug.Log` inside a snippet does **not** appear in `output` — read the Console (section 7).
- Shell quoting: single-quote the whole snippet; `"` and `$"…"` pass through; anything longer than one line goes into a file and `eval_file --file /abs/path.cs` (read by the Editor process; must end in `.cs`; keep such files outside `Assets/`).
- Cost ≈ 0.7–1.0 s per call (Roslyn). Timeout 5000 ms by default → `-- --timeout 9000` for heavier snippets.

## 7. Console

- `console --tail N --level log|warn|error [--since <cursor>]` keeps a session-wide buffer with `seq` / `cursor` / `dropped` that **survives domain reloads** — prefer it; pass the last `cursor` back to read only what is new.
- `get_console_logs --severity error --limit N` → `{total, returned, logs[{type, message, stackTrace, timestampUtc}]}`, but its buffer **empties on every domain reload** (0 entries right after entering Play mode).
- `clear_console` → `{cleared: true}`. `RootsDance.Core.Log` output is captured like any `Debug.Log`; the level's happy path logs nothing.

## 8. Edit → recompile → tests loop (verified)

1. Edit scripts. `unity command recompile` → `{status: "up_to_date"}` when nothing changed (no reload); otherwise the server goes down ≈ 2 s for a no-op reload, longer for a real rebuild.
2. Poll `unity command recompile_status` → `{status, failed, errors[]}`; tolerate connection errors while the domain reloads. At most one `recompile` per edit cycle.
3. `unity command list_tests --mode editor` → `{Count: 25, Tests[{FullName, Mode, Assembly, Categories, Explicit}]}`.
4. `unity command --detach run_tests --mode editor [--filter <Fixture>]` → job id; `unity job wait <id>` (7.0 s for the 25 EditMode tests) → `Summary{Total, Passed, Failed, Skipped, Inconclusive}` + `Results[{FullName, Status, Duration}]`. JSON only — `Logs/TestResults/` is not written; the PR still states the suite was run (08 review checklist).

## 9. Breakpoints

- Code Optimization must be **Debug**; in **Release** no debugger can attach ([Debug C# code in Unity](../../reference/testing-tooling/manual-managed-code-debugging.md)). From the shell: `unity command eval --code 'UnityEditor.Compilation.CompilationPipeline.codeOptimization = UnityEditor.Compilation.CodeOptimization.Debug; return "ok";'` returns in 0.5 s; the rebuild + reload starts ≈ 1.8 s later, the server is down ≈ 12.6 s and back after ≈ 14.4 s; `Library/ScriptAssemblies/*.pdb` are rewritten. Read it back with `--code 'return UnityEditor.Compilation.CompilationPipeline.codeOptimization.ToString();'`. Restore **Release** afterwards (another ≈ 14 s) — 08 wants Release for representative Play performance.
- The Editor's Mono soft-debugger port is `56000 + (pid % 1000)`, loopback only; `process_id` and `version` are in `Library/EditorInstance.json` (what IDEs read to attach).
- Attach before or after `editor_play` — both bind; a breakpoint set before Play goes "Assembly unloaded" and is re-verified ≈ 0.5 s after the reload.
- While stopped at a breakpoint the Editor is **fully frozen**: the Pipeline server does not answer (`editor_status` hangs — hence `timeout 5` on every call; a hang means "stopped") and answers again 0.6 s after *continue*. If the debugger client dies while stopped, the Editor stays frozen until the connection drops — disconnect in a `finally`.
- IDEs (all attach to the open Editor; setup in [08 — IDE setup](../../guidelines/08-testing-tooling.md#ide-setup)): Cursor / VS Code with DotRush → "Unity Debugger" (F5, attach); VS Code → Microsoft `visualstudiotoolsforunity.vstuc` (not on Open VSX, so not in Cursor); Rider → Attach to Unity Editor; Visual Studio 2022 → Attach to Unity.
- Headless: the spike author has a personal stdio-DAP client that drives the DotRush Mono adapter without an IDE (breakpoints, conditions, variable dumps, `evaluate`). It can be promoted into the repo if the team wants an agent-drivable debugger; it is deliberately not documented here.
- Fallback without a debugger: `Debug.Break()` in the code under study, then an `eval_file` dump while paused.

## 10. Safety rules for agents

1. **MUST** `list_open_scenes` before switching scenes and abort if any scene `isDirty`; remember the original set and restore it at the end (Single `open_scene` of what was open).
2. **NEVER** `save_scene`, `save_all`, `AssetDatabase.SaveAssets` (via `eval`), `build`, `menu` items that write assets, or `capture_* --save_path`, unless the human asked for exactly that.
3. **NEVER** leave Play mode running: `editor_stop`, then verify `stopped`.
4. **NEVER** leave a debugger attached or the Editor stopped at a breakpoint; verify no debug-adapter process is left (`pgrep -fl monodbg` for DotRush).
5. **MUST** restore Code Optimization to what it was.
6. **MUST** leave `git status --short` unchanged by a debugging session (scenes, assets, `Packages/`, `ProjectSettings/`).
7. **MUST** treat `eval` as arbitrary code on the main thread — the same care as running an Editor script.
8. **MUST** `recompile` at most once per edit cycle, poll `recompile_status`, expect the server to be down during reloads, and wrap every call in `timeout`.

## 11. Timings (one machine, 2026-08-25)

| Operation | Measured |
|---|---|
| `editor_status` poll | ≈ 0.1 s |
| `eval` / `eval_file` | 0.7–1.0 s |
| `screenshot --view game` (1920×1080 PNG) | 0.3 s |
| `editor_play` → response / → `playing` | 0.2 s / first Play entry ≈ 18 s, later ≈ 3 s |
| `editor_stop` → `stopped` | 0.6 s |
| `run_tests --mode editor` (25 tests) via `job wait` | 7.0 s |
| No-op `recompile` reload (`RequestScriptCompilation`) | ≈ 2 s server down |
| Code Optimization Debug ↔ Release | ≈ 12.6 s down, ≈ 14.4 s until answering |
| Open Editor picks up an externally edited manifest | ≈ 60 s after its window gains focus |
| Breakpoint verified after set / re-bound after `editor_play` | ≈ 3 s / ≈ 0.5 s |
| `editor_play` → first breakpoint hit / attach-after-Play → hit | 11.2 s / 0.9 s |
| *continue* → Editor answering again | 0.6 s |

Debugger's effect on Play-entry time: UNVERIFIED (no baseline).

## 12. Sources

Live pages (not snapshotted in `../../reference/`), consulted 2026-08-25:

1. Unity CLI — https://docs.unity.com/en-us/unity-cli/unity-cli
2. Use Unity CLI — https://docs.unity.com/en-us/unity-cli/use-unity-cli
3. Unity CLI reference — https://docs.unity.com/en-us/unity-cli/unity-cli-reference
4. Unity Pipeline package (Unity Production Pipeline → local tools / CLI) — https://docs.unity.com/en-us/unity-production-pipeline/local-tools-cli/unity-pipeline-package
5. `com.unity.pipeline` 0.5 manual — https://docs.unity3d.com/Packages/com.unity.pipeline@0.5/manual/index.html

Package documentation, present after import in `Library/PackageCache/com.unity.pipeline@<hash>/` (not committed): `CLAUDE.md`, `.claude/skills/unity-pipeline/SKILL.md`, `Documentation~/{index,connectivity,runtime-setup,hot-reload, safety-and-mutations,testing}.md`, `Documentation~/commands/*.md` (scenes, scripts, capture, build-and-compilation, editor-lifecycle-and-observability, …).

Repository: [08 Testing, tooling and IDE setup](../../guidelines/08-testing-tooling.md) (CLI test/build commands, IDE attach), [09 Packages and game systems](../../guidelines/09-packages-systems.md) (package policy), [06 Version control](../../guidelines/06-version-control.md) (what is committed), [Debug C# code in Unity](../../reference/testing-tooling/manual-managed-code-debugging.md) (Code Optimization, attaching).
