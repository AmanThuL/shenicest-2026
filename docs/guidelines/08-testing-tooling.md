# 08. Testing, tooling and IDE setup

> **Scope:** How we write and run automated tests (Unity Test Framework), measure coverage, produce builds from the Editor and the command line, set up IDEs and analyzers, and keep the Console clean.
> **Applies to:** all C# under `Assets/RootsDance/Scripts` and `Assets/RootsDance/Tests`, the build profiles under `Assets/RootsDance/Settings/BuildProfiles`, and every teammate's (and agent's) local toolchain.
> **Status:** Unity 6000.3 LTS · last reviewed 2026-08-25

C# style itself (naming, braces, `.editorconfig` contents) is owned by [01 C# style](./01-csharp-style.md); assembly/folder layout by [02 Project structure](./02-project-structure.md); which logic goes into plain C# classes by [03 Architecture](./03-architecture-patterns.md); per-frame logging cost by [05 Performance](./05-performance.md); what is committed by [06 Version control](./06-version-control.md).

## TL;DR — rules at a glance
1. **MUST** keep tests in `Assets/RootsDance/Tests/EditMode` (asmdef `RootsDance.Tests.EditMode`, platform **Editor** only) and `Assets/RootsDance/Tests/PlayMode` (asmdef `RootsDance.Tests.PlayMode`, **Any Platform**); both reference `RootsDance.Runtime`, never `Assembly-CSharp`.
2. **MUST** write EditMode `[Test]`s for pure C# logic (no `MonoBehaviour`, no scene); PlayMode `[UnityTest]`s only for critical integration (bootstrap loads, player moves, core interaction).
3. **MUST** structure every test Arrange / Act / Assert, name it `Method_Scenario_ExpectedResult`, one fixture `<TypeName>Tests` per type under test.
4. **SHOULD** assert with the constraint model `Assert.That(actual, Is.EqualTo(expected))`; **MUST** compare `Vector3`/`Quaternion`/`Color` through the `UnityEngine.TestTools.Utils` comparers (`Is.EqualTo(v).Using(Vector3EqualityComparer.Instance)`).
5. **MUST** use `[Test]` unless the test has to yield; then `[UnityTest]` returning `IEnumerator` (`yield return null` = one frame).
6. **MUST** declare every error/exception the code under test logs with `LogAssert.Expect(...)`; any unexpected error log fails the test.
7. **MUST** destroy every GameObject/asset a test creates in `[TearDown]` (or `[UnityTearDown]`); tests never leave state behind.
8. **MUST** run the EditMode suite before opening a PR into `develop` (branch model: [06](./06-version-control.md)) — Test Runner window or the CLI below; **NEVER** pass `-quit` to a `-runTests` run; close the Editor first (one instance per project).
9. **MUST** build only through Build Profiles stored in `Assets/RootsDance/Settings/BuildProfiles/`; CLI builds are `-batchmode -quit -projectPath … -activeBuildProfile … -build … -logFile …`, one platform per invocation.
10. **MUST** use Visual Studio 2022, VS Code or Rider with Unity's integration package; **NEVER** install `com.unity.ide.vscode`; **NEVER** commit `.csproj`, `.sln`, `.vscode/`, `.idea/`.
11. **MUST** treat the repo-root `.editorconfig` as the single source of style *and* analyzer severity (`dotnet_diagnostic.<ID>.severity`); no analyzer DLLs in `Assets/` during the hackathon.
12. **MUST** keep the Console free of errors and warnings from `RootsDance.*` assemblies on `develop` and `main`; **NEVER** call `Debug.Log*` outside `RootsDance.Core.Log` (and `_Sandbox/`), and never log from `Update`/`FixedUpdate`/`LateUpdate` — see [04](./04-unity-scripting-rules.md).
13. **MUST** tag tests slower than ~1 s `[Explicit, Category("Integration")]` so **Run All** stays fast.
14. **SHOULD** run Project Auditor before the final build; **MAY** run Code Coverage on `RootsDance.Runtime` to find untested logic — no coverage gate.
15. **MAY** drive an *open* Editor from the shell with the official Unity CLI + `com.unity.pipeline` (recompile, tests, Play mode, Console, screenshots, C# eval) — how-to and safety rules in [Unity CLI agent workflow](../architecture/tooling/unity-cli-agent-workflow.md); **NEVER** save scenes/assets, build, or leave Play mode running / a debugger attached through it unless asked.

## What to test in a hackathon

Test the code that is cheap to test and expensive to get wrong; skip the rest. **[project decision]**

| Test it (EditMode, `[Test]`) | Maybe (PlayMode, `[UnityTest]`) | Do not automate |
|:--|:--|:--|
| Damage/score/economy math, state machines, inventory rules, timers, parsers, save-data models — any plain C# class from [03](./03-architecture-patterns.md) | Bootstrap scene loads and spawns the player; player input moves the character; one end-to-end "core loop" smoke test | Visual look, animation feel, camera tuning, audio, UI layout, performance (use the Profiler instead) |

- *Why:* Unity Test Framework (UTF) runs NUnit tests inside the Editor; EditMode tests are plain NUnit and run in milliseconds, PlayMode tests enter Play mode and run as coroutines, which is slower and flakier. Unity's own recommendation is `[Test]` unless you need to skip frames or yield Editor instructions.
- *Source:* [Testing your code](../reference/testing-tooling/manual-test-framework-introduction.md), [Edit mode and Play mode tests](../reference/testing-tooling/manual-edit-mode-vs-play-mode-tests.md), [Testing and QA tips](../reference/testing-tooling/how-to-testing-and-quality-assurance-tips-unity-projects.md) ("since UTF uses a Test Assembly Definition, you'll need to break your project down into runtime assembly definitions … it encourages you to write more modular code").

UTF is a core package shipped with the Editor (1.6 in 6000.3) and bundles a custom NUnit based on **3.5** — do not rely on NUnit features newer than 3.5. *Source:* [Testing your code](../reference/testing-tooling/manual-test-framework-introduction.md), [Test Framework changelog](../reference/testing-tooling/test-framework-1-6-changelog-changelog.md).

## Test assemblies

**MUST** have exactly two test assemblies, created once and committed (decision 3 of the project facts):

```
Assets/RootsDance/Tests/
├── EditMode/
│   ├── RootsDance.Tests.EditMode.asmdef
│   └── <Feature>/<TypeName>Tests.cs        (namespace RootsDance.Tests.EditMode.<Feature>)
└── PlayMode/
    ├── RootsDance.Tests.PlayMode.asmdef
    └── <Feature>/<TypeName>Tests.cs        (namespace RootsDance.Tests.PlayMode.<Feature>)
```

Create them with **Assets > Create > Testing > Test Assembly Folder** (or the button in **Window > General > Test Runner**), rename, then fix the `name` field in the Inspector — renaming the file does not rename the assembly. Create test scripts with **Assets > Create > Testing > C# Test Script**. *Source:* [Create a test assembly](../reference/testing-tooling/manual-workflow-create-test-assembly.md), [Create a test](../reference/testing-tooling/manual-workflow-create-test.md).

The two asmdef files are defined once, byte-for-byte, in [02 Project structure — section 8](./02-project-structure.md#8-scripts-namespaces-and-assembly-definitions); create them via Test Runner, then paste 02's JSON. Do not edit them except to add a legitimate reference.

- *Why:* An assembly is a test assembly when it references `nunit.framework.dll` plus `UnityEngine.TestRunner` (and, for EditMode only, `UnityEditor.TestRunner`). **Editor** as the only platform makes it an EditMode assembly; an empty platform list ("Any Platform") makes it a PlayMode assembly that can also run in a Player. Test assemblies are excluded from normal Player builds. The `"optionalUnityReferences": ["TestAssemblies"]` form still shown on the manual page is **legacy** (pre-2019 asmdef format); 6000.3's Test Runner does not write it — never hand-write it.
- *Source:* [Edit mode and Play mode tests](../reference/testing-tooling/manual-edit-mode-vs-play-mode-tests.md), [Create a test assembly](../reference/testing-tooling/manual-workflow-create-test-assembly.md), [Assembly Definition file format](../reference/project-structure/manual-assembly-definition-file-format.md), [Create an Assembly Definition — test assemblies](../reference/project-structure/manual-assembly-definitions-creating.md).

**NEVER** reference `Assembly-CSharp` from a test assembly — it cannot be referenced; code that needs testing must live in `RootsDance.Runtime` (or `RootsDance.Editor`). *Source:* [Edit mode and Play mode tests](../reference/testing-tooling/manual-edit-mode-vs-play-mode-tests.md).

**MAY** add `Unity.InputSystem` + `Unity.InputSystem.TestFramework` (requires `"testables": ["com.unity.inputsystem"]` in `Packages/manifest.json`) to the PlayMode assembly for `InputTestFixture` tests. **NEVER** add `Unity.UI.TestFramework.Runtime` (package *UI Test Framework*): it simulates UI Toolkit interaction only, and our runtime UI is uGUI ([09](./09-packages-systems.md#ugui-runtime-ui)) — test a presenter by driving its public methods and event channels instead. *Source:* [How to run automated tests](../reference/testing-tooling/how-to-automated-tests-unity-test-framework.md), [Add tests to your package — testables](../reference/testing-tooling/manual-cus-tests.md), [Input System — Testing](../reference/testing-tooling/inputsystem-1-20-testing.md), [UI Test Framework — install](../reference/testing-tooling/ui-test-framework-6-3-install-and-set-up.md).

## Writing tests

### Structure and naming

- **MUST** follow Arrange / Act / Assert with the three blocks separated by a blank line; the Act block is as short as possible; name the instance under test `<thing>UnderTest`. *Source:* [Course 2. Arrange, Act, Assert](../reference/testing-tooling/manual-arrange-act-assert.md).
- **MUST** name test methods `Method_Scenario_ExpectedResult` (the manual's own async example is `MakeBreakfast_InTheMorning_IsEdible`), fixtures `<TypeName>Tests`, one fixture per type, file name = fixture name. **[project decision]** *Source:* [Asynchronous tests](../reference/testing-tooling/manual-reference-async-tests.md).
- **MUST** mark slow tests `[Explicit, Category("Integration")]` so they only run when selected. *Source:* [Course 10. Long running tests](../reference/testing-tooling/manual-long-running-tests.md).
- *Why:* AAA and the `Method_Scenario_ExpectedResult` name let a reader see what failed without opening the test; `[Explicit]` keeps **Run All** under a few seconds.

```csharp
using NUnit.Framework;
using RootsDance.Player;

namespace RootsDance.Tests.EditMode.Player
{
    public class HealthTests
    {
        [Test]
        public void TakeDamage_AmountExceedsCurrent_ClampsToZero()
        {
            // Arrange
            var healthUnderTest = new Health(10);

            // Act
            healthUnderTest.TakeDamage(25);

            // Assert
            Assert.That(healthUnderTest.Current, Is.EqualTo(0));
            Assert.That(healthUnderTest.IsDead, Is.True);
        }

        [TestCase(10, 3, 7)]
        [TestCase(10, 0, 10)]
        public void TakeDamage_Amount_ReducesCurrent(int max, int damage, int expected)
        {
            var healthUnderTest = new Health(max);

            healthUnderTest.TakeDamage(damage);

            Assert.That(healthUnderTest.Current, Is.EqualTo(expected));
        }
    }
}
```

`[TestCase]` and `[ValueSource]` work on `[Test]`; `[UnityTest]` only supports `[ValueSource]`. *Source:* [Parameterized tests](../reference/testing-tooling/manual-reference-tests-parameterized.md).

### Assertions

- **SHOULD** use the constraint model (`Assert.That(x, Is.GreaterThan(20))`, `Does.Contain(...)`) — failure messages read like the intent. *Source:* [Course 3. Semantic test assertion](../reference/testing-tooling/manual-semantic-test-assertion.md).
- **MUST** compare Unity value types with tolerance: `Assert.That(actual, Is.EqualTo(expected).Using(Vector3EqualityComparer.Instance));` (default error `0.0001f`; `new Vector3EqualityComparer(1e-6f)` for a custom one). Comparers live in `UnityEngine.TestTools.Utils`. *Source:* [Asserting and comparing](../reference/testing-tooling/manual-asserting-and-comparing.md), [Vector3EqualityComparer](../reference/testing-tooling/test-framework-1-6-unityengine-testtools-utils-vector3equalitycomparer.md).
- If you need Unity's extra constraints (`UnityEngine.TestTools.Constraints.Is`, e.g. allocation checks), alias it explicitly: `using Is = UnityEngine.TestTools.Constraints.Is;` — otherwise `Is` is ambiguous. *Source:* [Asserting and comparing](../reference/testing-tooling/manual-asserting-and-comparing.md).
- **NEVER** `using UnityEngine.Assertions;` in a test file — its `Assert` clashes with NUnit's. Runtime invariants use `Debug.Assert` per [04](./04-unity-scripting-rules.md); like the `UnityEngine.Assertions.Assert` class it is compiled only when `UNITY_ASSERTIONS` is defined (development builds). *Source:* [Assertions.Assert](../reference/testing-tooling/scriptref-assertions-assert.md).
- *Why:* constraint failures print expected vs actual in words; float tolerance avoids flaky equality on physics/transform maths; the `Is` alias and the NUnit/Unity `Assert` clash are the two common compile errors in new test files.

### Logs are assertions too

A test **fails** when anything logs an error or exception during the test, and it also fails when an expected log never appears. **MUST** declare expected error logs:

```csharp
// using UnityEngine;            (LogType)
// using UnityEngine.TestTools;  (LogAssert)
[Test]
public void Load_MissingFile_LogsErrorAndReturnsDefault()
{
    var loaderUnderTest = new SaveLoader();
    LogAssert.Expect(LogType.Error, "Save file not found: missing.sav");

    SaveData result = loaderUnderTest.Load("missing.sav");

    Assert.That(result, Is.EqualTo(SaveData.Default));
}
```

`LogAssert.Expect(LogType type, string message)` / `Expect(LogType type, Regex message)` (plus overloads without a `LogType`), and `LogAssert.NoUnexpectedReceived()` to fail on *any* extra log. Use the regex overload when the message contains numbers or durations. Place `Expect` before the code under test — the check runs at the end of the frame.
- *Why:* UTF treats any error/exception log as a failure, so tests of error paths must declare the log or they fail for the wrong reason.
- *Source:* [Asserting and comparing](../reference/testing-tooling/manual-asserting-and-comparing.md), [Course 5. Asserting and expecting logs](../reference/testing-tooling/manual-asserting-logs.md), LogAssert API (https://docs.unity3d.com/Packages/com.unity.test-framework@1.6/api/UnityEngine.TestTools.LogAssert.html).

### `[Test]` vs `[UnityTest]`, setup and teardown

- **MUST** prefer `[Test]`; use `[UnityTest]` (return `IEnumerator`) only to skip frames (`yield return null`), wait (`yield return new WaitForSeconds(…)`, PlayMode only) or yield Editor instructions (`EnterPlayMode`, `ExitPlayMode`, `RecompileScripts`, `WaitForDomainReload`, EditMode only). EditMode `[UnityTest]`s run in `EditorApplication.update`, not as coroutines. *Source:* [Edit mode and Play mode tests](../reference/testing-tooling/manual-edit-mode-vs-play-mode-tests.md), [Course 9. UnityTest attribute](../reference/testing-tooling/manual-unitytest-attribute.md), [Yield instructions for the Editor](../reference/testing-tooling/manual-reference-custom-yield-instructions.md).
- **MUST** clean up in `[TearDown]` (runs even when the test fails); use `[UnitySetUp]`/`[UnityTearDown]` (`IEnumerator`) when setup needs to yield. `[SetUp]` runs on base classes first, `[TearDown]` on derived first. *Source:* [Course 6. SetUp and TearDown](../reference/testing-tooling/manual-setup-teardown.md), [UnitySetUp / UnityTearDown](../reference/testing-tooling/manual-reference-unitysetup-and-unityteardown.md).
- Async: `[Test] public async Task …` is supported (awaited on the main thread each update). `Awaitable` is **not** a valid test return type; test `Awaitable` code with the manual's pattern — a `[UnityTest] public IEnumerator` test that declares a local `async Awaitable TestImplementation()` and `return TestImplementation();` (`Awaitable` implements `IEnumerator`). **NEVER** use `Assert.ThrowsAsync` — it freezes the Editor; wrap in `try`/`catch` and assert a flag. *Source:* [Asynchronous tests](../reference/testing-tooling/manual-reference-async-tests.md), [Awaitable examples — Asynchronous tests](../reference/scripting/manual-async-awaitable-examples.md).

PlayMode example — self-contained, no scene dependency (integration test of Unity's own `Rigidbody`; the fixture is named after the component under test; file `Assets/RootsDance/Tests/PlayMode/Player/RigidbodyTests.cs`):

```csharp
using System.Collections;
using NUnit.Framework;
using UnityEngine;
using UnityEngine.TestTools;

namespace RootsDance.Tests.PlayMode.Player
{
    public class RigidbodyTests
    {
        private GameObject m_body;

        [SetUp]
        public void SetUp()
        {
            m_body = new GameObject("Body");
            m_body.AddComponent<Rigidbody>();
        }

        [TearDown]
        public void TearDown()
        {
            Object.Destroy(m_body);
        }

        [UnityTest]
        public IEnumerator FixedUpdate_WithGravity_MovesBodyDown()
        {
            float startY = m_body.transform.position.y;

            yield return new WaitForFixedUpdate();

            Assert.That(m_body.transform.position.y, Is.LessThan(startY));
        }
    }
}
```

- Scene-based tests: load the scene in the test, restore a clean scene in `[TearDown]` (EditMode: `EditorSceneManager.OpenScene(...)` / `EditorSceneManager.NewScene(NewSceneSetup.DefaultGameObjects, NewSceneMode.Single)`). PlayMode tests that `SceneManager.LoadScene` a scene need it in the profile's scene list. *Source:* [Course 11. Scene-based tests](../reference/testing-tooling/manual-scene-based-tests.md), [How to run automated tests](../reference/testing-tooling/how-to-automated-tests-unity-test-framework.md).
- `InitTestScene*.unity` files that PlayMode runs generate are gitignored; do not commit them. *Source:* repo `.gitignore`, [Version control](./06-version-control.md).

## Running tests

### In the Editor

**Window > General > Test Runner** → **EditMode** / **PlayMode** tab → **Run All**, **Run Selected**, or double-click a test. Filter by the search box, fixture or result icon. The **Player** tab builds and runs PlayMode tests on the active build profile's platform — not needed for this project. Rider can run UTF tests from the IDE. *Source:* [Run tests in the Test Runner window](../reference/testing-tooling/manual-workflow-run-test.md), [Run Play mode tests in a Player](../reference/testing-tooling/manual-workflow-run-playmode-test-standalone.md).

### From the command line (humans and agents)

Preconditions: the Unity Editor is **closed** on this project (only one instance can open a project), and `Logs/TestResults/` exists (`Logs/` is gitignored). **[project decision: results and logs under `Logs/TestResults/`]**

All commands in this document use the Unity Hub install path. A direct (non-Hub) download installs elsewhere — on macOS `/Applications/Unity/Unity-6000.3.22f1/Unity.app` (verified 2026-08-24 on a team machine) — so substitute your machine's Editor path throughout; verify it once with `ls "<path>/Contents/MacOS/Unity"` (macOS) or `dir "<path>\Unity.exe"` (Windows).

macOS (repo root as working directory):

```bash
mkdir -p Logs/TestResults
/Applications/Unity/Hub/Editor/6000.3.22f1/Unity.app/Contents/MacOS/Unity \
  -batchmode \
  -projectPath "$PWD" \
  -runTests -testPlatform EditMode \
  -testResults "$PWD/Logs/TestResults/EditMode.xml" \
  -logFile "$PWD/Logs/TestResults/EditMode.log"
echo "exit code: $?"
```

Windows (PowerShell, repo root as working directory):

```powershell
New-Item -ItemType Directory -Force Logs\TestResults | Out-Null
& "C:\Program Files\Unity\Hub\Editor\6000.3.22f1\Editor\Unity.exe" `
  -batchmode `
  -projectPath "$PWD" `
  -runTests -testPlatform EditMode `
  -testResults "$PWD\Logs\TestResults\EditMode.xml" `
  -logFile "$PWD\Logs\TestResults\EditMode.log"
Write-Host "exit code: $LASTEXITCODE"
```

- `-testPlatform PlayMode` runs the PlayMode suite in the Editor; omitting `-testPlatform` means EditMode. Narrow a run with `-assemblyNames "RootsDance.Tests.EditMode"`, `-testFilter "RootsDance.Tests.EditMode.Player.HealthTests"` (regex on the full name, `!` negates) or `-testCategory "Integration"`. `-forgetProjectPath` keeps the run out of the Hub history. **MAY** add `-nographics` for EditMode runs on machines without a GPU.
- **NEVER** add `-quit`: it kills the Editor before the tests finish. The Editor exits by itself when the run ends.
- Results are NUnit 3 XML at `-testResults`; the exit code is non-zero on failure (the manual documents no fixed table — the changelog lists `2` for inconclusive and `3` for run errors such as timeouts/build errors, and batch mode exits `1` on any exception). Read the XML and `-logFile` for the cause; `-logFile -` writes to stdout (not visible on Windows consoles).
- Windows paths must not end in a single backslash; quote any path with spaces.
- *Why:* `-quit` kills the run mid-test and a second Editor instance cannot open the project; keeping results under `Logs/TestResults/` keeps them out of git.
- *Source:* [Run tests from the command line](../reference/testing-tooling/manual-run-tests-from-command-line.md), [UTF command-line reference](../reference/testing-tooling/manual-reference-command-line.md), [Editor command line arguments](../reference/testing-tooling/manual-editorcommandlinearguments.md), [Run Unity from a command-line interface](../reference/testing-tooling/manual-command-line-run-unity.md), [Test Framework changelog](../reference/testing-tooling/test-framework-1-6-changelog-changelog.md), [Log files reference](../reference/testing-tooling/manual-log-files.md).

Compile check without tests (agents): the same command with `-quit` instead of `-runTests …` opens the project in batch mode; with compile errors batch mode quits by itself and the `error CS…` lines are in the `-logFile`. *Source:* [Safe Mode — batch mode](../reference/testing-tooling/manual-safemode.md), [Editor command line arguments — `-batchmode`](../reference/testing-tooling/manual-editorcommandlinearguments.md).

Default Editor log when `-logFile` is omitted: macOS `~/Library/Logs/Unity/Editor.log`, Windows `%LOCALAPPDATA%\Unity\Editor\Editor.log`. Player logs: macOS `~/Library/Logs/<Company Name>/<Product Name>/Player.log`, Windows `%USERPROFILE%\AppData\LocalLow\<CompanyName>\<ProductName>\Player.log`. *Source:* [Log files reference](../reference/testing-tooling/manual-log-files.md).

### Unity CLI (official)

The Unity CLI (`unity`, 1.0.0-beta.5 — install, sign-in and `PATH` notes in the [tooling doc](../architecture/tooling/unity-cli-agent-workflow.md#1-what-you-need)) wraps the batch commands above and adds control of an *open* Editor:

- Editor **closed** (same one-instance rule): `unity test --mode editor --output "$PWD/Logs/TestResults"` (`--mode playmode`, `--filter <regex>`) and `unity build --profile "Assets/RootsDance/Settings/BuildProfiles/macOS-Release.asset" -o "$PWD/Builds/macOS-Release"` spawn the same batchmode Editor as the `-runTests` / `-activeBuildProfile` commands; `unity run -- -executeMethod …` passes raw Editor arguments; `unity projects close` closes a running Editor gracefully. Documented from `--help` and the live docs, not yet exercised on this project (2026-08-25).
- Editor **open** + `com.unity.pipeline` installed: `unity status`, then `unity command recompile` / `recompile_status`, `list_tests`, `--detach run_tests --mode editor` + `unity job wait <id>`, `editor_play` / `editor_stop`, `console --tail N`, `screenshot --view game --output <abs>`, `eval` / `eval_file`. Results are JSON on stdout only (`Logs/TestResults/` is not written). Syntax traps (`--name value` only, `--` for colliding options, server down during every domain reload), the verified scene-debugging loop and the agent safety rules live in the [tooling doc](../architecture/tooling/unity-cli-agent-workflow.md). Whether `com.unity.pipeline` stays in the manifest is a pending team decision ([09](./09-packages-systems.md)).
- *Source:* [Unity CLI](https://docs.unity.com/en-us/unity-cli/unity-cli), [Unity CLI reference](https://docs.unity.com/en-us/unity-cli/unity-cli-reference), [Unity Pipeline package](https://docs.unity.com/en-us/unity-production-pipeline/local-tools-cli/unity-pipeline-package) — live pages, not snapshotted in `../reference/`.

## Code Coverage (optional)

- Install `com.unity.testtools.codecoverage` (1.3) via **Package Manager > + > Add package by name**; open **Window > Analysis > Code Coverage**, tick **Enable Code Coverage**, select `RootsDance.Runtime` under **Included Assemblies**, run tests, open `index.htm`. Switch the Editor to **Debug** code optimization (status-bar bug icon) first — coverage is inaccurate in Release mode. Enabling coverage slows the Editor; disable it when done. **[project decision: no coverage threshold; use it to find untested pure logic]**
- Batch mode (EditMode + HTML report + badge):

```bash
/Applications/Unity/Hub/Editor/6000.3.22f1/Unity.app/Contents/MacOS/Unity -batchmode -projectPath "$PWD" \
  -runTests -testPlatform EditMode -testResults "$PWD/Logs/TestResults/EditMode.xml" \
  -debugCodeOptimization -enableCodeCoverage -coverageResultsPath "$PWD/Logs/Coverage" \
  -coverageOptions "generateHtmlReport;generateBadgeReport;assemblyFilters:+RootsDance.Runtime"
```

- Limits: Editor-only (no Player coverage), OpenCover format, branch coverage always 0. Exclude helpers with `[ExcludeFromCoverage]`.
- *Source:* [About Code Coverage](../reference/testing-tooling/testtools-codecoverage-1-3-index.md), [Installing](../reference/testing-tooling/testtools-codecoverage-1-3-installingcodecoverage.md), [With Test Runner](../reference/testing-tooling/testtools-codecoverage-1-3-coveragetestrunner.md), [Using Code Coverage](../reference/testing-tooling/testtools-codecoverage-1-3-usingcodecoverage.md), [Batch mode](../reference/testing-tooling/testtools-codecoverage-1-3-coveragebatchmode.md), [Technical details](../reference/testing-tooling/testtools-codecoverage-1-3-technicaldetails.md).

## Build Profiles and batch builds

### Profiles

- **MUST** build from **File > Build Profiles** using committed build-profile assets (not the platform entries, whose shared settings leak across platforms). Create with **Add Build Profile** → platform → name → **Add Build Profile**, then move the asset *inside the Editor* to `Assets/RootsDance/Settings/BuildProfiles/`. Profiles **[project decision]**: `Windows-Release`, `macOS-Release`, `Web-Release` (if we ship Web), plus `Windows-Dev`/`macOS-Dev` copies with **Development Build** + **Script Debugging** on. Activate with **Switch Profile**.
- Scene lists: add **Scene List** via **Add Settings** only if a profile needs a different list; otherwise every profile inherits the global list (bootstrap scene first — see [11 Scenes](./11-scenes-prefabs-workflow.md)). Per-profile **Scripting Defines** are additive.
- **Development Build** defines `DEVELOPMENT_BUILD` and includes scripting debug symbols and the Profiler; **Script Debugging** (only available with Development Build) is what lets a debugger attach to the Player — both are on in the `*-Dev` profiles. Release builds are the default and contain only what is needed to run.
- *Source:* [Introduction to build profiles](../reference/testing-tooling/manual-build-profiles.md), [Create and manage build profiles](../reference/testing-tooling/manual-create-build-profile.md), [Manage scenes in a build](../reference/testing-tooling/manual-build-profile-scene-list.md), [Build Profiles window reference](../reference/testing-tooling/manual-build-profiles-reference.md), [Customize settings with build profiles](../reference/testing-tooling/manual-build-profiles-override-settings.md), [Introduction to building](../reference/testing-tooling/manual-building-introduction.md).
- As implemented (2026-08-28): only `macOS-Release` and `Windows-Release` exist, generated by `RootsDance > Build > Create Default Build Profiles`; there are no separate `*-Dev` profile assets, because per-profile Player Settings overrides are internal-only in 6.3 — a Dev profile asset could not carry its own Development Build flag. Dev builds instead pass `--dev` to `Tools/build/build.py`, which adds `BuildOptions.Development | AllowDebugging` at build time. Full rationale, the player-settings table and sources: [Build and packaging](../architecture/tooling/build-and-packaging.md).

### Command-line builds

Default route — no script needed **[project decision]**:

```bash
# macOS → macOS player (.app)
/Applications/Unity/Hub/Editor/6000.3.22f1/Unity.app/Contents/MacOS/Unity \
  -batchmode -quit \
  -projectPath "$PWD" \
  -activeBuildProfile "Assets/RootsDance/Settings/BuildProfiles/macOS-Release.asset" \
  -build "$PWD/Builds/macOS-Release/RootsDance.app" \
  -logFile "$PWD/Logs/build-macos.log"
```

```powershell
# Windows → Windows player (.exe)
& "C:\Program Files\Unity\Hub\Editor\6000.3.22f1\Editor\Unity.exe" `
  -batchmode -quit `
  -projectPath "$PWD" `
  -activeBuildProfile "Assets/RootsDance/Settings/BuildProfiles/Windows-Release.asset" `
  -build "$PWD\Builds\Windows-Release\RootsDance.exe" `
  -logFile "$PWD\Logs\build-windows.log"
```

- `-projectPath` and `-quit` are required; `-batchmode`, `-logFile` and `-activeBuildProfile` are recommended. The profile path is relative to the project root; `-build` needs the platform's extension (`.exe`, `.app`). **One platform per invocation** — switching targets inside a batch session does not take effect. `Builds/` is gitignored. Output always goes to `Builds/<ProfileName>/` at the repo root (owner: this doc; [06](./06-version-control.md) ignores it). **[project decision]**
- *Source:* [Build a player from the command line](../reference/testing-tooling/manual-build-command-line.md), [Editor command line arguments — build arguments](../reference/testing-tooling/manual-editorcommandlinearguments.md).
- `unity build --profile <profile .asset> -o <dir>` (official Unity CLI, Editor closed) is the same build with nicer output — see [Unity CLI (official)](#unity-cli-official).
- `python3 Tools/build/build.py [PROFILE] [--dev]` wraps this same route and adds preflight checks plus packaging the output into a commit-named, shareable zip. Command reference: [`Tools/build/README.md`](../../Tools/build/README.md); naming convention, zip layout, player settings and troubleshooting: [Build and packaging](../architecture/tooling/build-and-packaging.md).

Escape hatch — `-executeMethod` with a build script, only when the build needs extra steps (copy files, stamp a version). Lives in `RootsDance.Editor` (Editor-only assembly) at `Assets/RootsDance/Scripts/Editor/Build/BuildScript.cs`; the method must be `static`; throw to fail the process with exit code 1. **[project decision]**

```csharp
using System.IO;
using RootsDance.Core;
using UnityEditor;
using UnityEditor.Build;
using UnityEditor.Build.Profile;
using UnityEditor.Build.Reporting;
using UnityEngine;

namespace RootsDance.Editor.Build
{
    public static class BuildScript
    {
        private const string k_BuildRoot = "Builds";
        private const string k_AppName = "RootsDance";

        [MenuItem("RootsDance/Build/Build Active Profile")]
        public static void BuildActiveProfile()
        {
            BuildProfile profile = BuildProfile.GetActiveBuildProfile();
            if (profile == null)
            {
                throw new BuildFailedException(
                    "No active build profile. Use File > Build Profiles or -activeBuildProfile.");
            }

            string outputDirectory = Path.Combine(k_BuildRoot, profile.name);
            Directory.CreateDirectory(outputDirectory);

            var buildOptions = new BuildPlayerWithProfileOptions
            {
                buildProfile = profile,
                locationPathName = Path.Combine(
                    outputDirectory, k_AppName + GetExtension(EditorUserBuildSettings.activeBuildTarget)),
                options = BuildOptions.None
            };

            if (!Application.isBatchMode)
            {
                buildOptions.options |= BuildOptions.AutoRunPlayer;
            }

            BuildReport report = BuildPipeline.BuildPlayer(buildOptions);
            if (report.summary.result != BuildResult.Succeeded)
            {
                throw new BuildFailedException("Player build failed, see the Editor log.");
            }

            Log.Info($"Build written to {buildOptions.locationPathName}");
        }

        private static string GetExtension(BuildTarget target)
        {
            switch (target)
            {
                case BuildTarget.StandaloneWindows64:
                    return ".exe";
                case BuildTarget.StandaloneOSX:
                    return ".app";
                default:
                    return string.Empty;
            }
        }
    }
}
```

Invoke: `… -batchmode -quit -projectPath "$PWD" -activeBuildProfile "Assets/RootsDance/Settings/BuildProfiles/Windows-Release.asset" -executeMethod RootsDance.Editor.Build.BuildScript.BuildActiveProfile -logFile "$PWD/Logs/build.log"`. With `-activeBuildProfile`, Unity applies the profile's defines and compiles before calling the method.
- *Source:* [Create a custom build script](../reference/testing-tooling/manual-build-script-build.md) (`BuildPlayerWithProfileOptions`, `BuildProfile.GetActiveBuildProfile`, `BuildFailedException`, `Application.isBatchMode`), [BuildPipeline.BuildPlayer](../reference/testing-tooling/scriptref-buildpipeline-buildplayer.md), [BuildOptions](../reference/testing-tooling/scriptref-buildoptions.md), [Editor command line arguments — `-executeMethod`](../reference/testing-tooling/manual-editorcommandlinearguments.md), [EditorApplication.Exit](../reference/testing-tooling/scriptref-editorapplication-exit.md).

## IDE setup

Pick one; all three are supported and share the same project files. **[project decision: VS Code is the default on macOS, Visual Studio 2022 on Windows; Rider if you own it]**

| IDE | Install | Unity side |
|:--|:--|:--|
| **Visual Studio 2022** (Windows) | Visual Studio Community with the **Game Development with Unity** workload (= Visual Studio Tools for Unity); the Unity Hub installer offers it | package `com.unity.ide.visualstudio` (ships with the Editor's Engineering feature set) |
| **VS Code** (macOS/Windows/Linux) | Extension **Unity for Visual Studio Code** (`visualstudiotoolsforunity.vstuc`, by Microsoft) — pulls in C# Dev Kit and C# | `com.unity.ide.visualstudio` **2.0.20+** (same package) |
| **Rider** | Rider itself | `com.unity.ide.rider` |

- **MUST** set **Edit > Preferences** (macOS: **Unity > Settings**) **> External Tools > External Script Editor** to your IDE, otherwise Unity does not generate/refresh the solution for it. After adding an asmdef or package, click **Regenerate project files** there (Rider CLI equivalent: `-batchmode -quit -projectPath … -executeMethod Packages.Rider.Editor.RiderScriptEditor.SyncSolution`).
- **NEVER** install `com.unity.ide.vscode` — unsupported; the Visual Studio Editor package now serves VS Code.
- **NEVER** commit `*.csproj`, `*.sln`, `.vscode/`, `.idea/` — Unity regenerates them; they are gitignored.
- Debugging: set the Editor to **Debug** code optimization (status-bar bug icon, or **Preferences > General > Code Optimization On Startup**), then **Attach to Unity** (VS, F5), **Run and Debug → Unity Editor** (VS Code, F5), or Rider's attach. Players need **Development Build + Script Debugging**. Switch back to **Release** for representative Play-mode performance. Code Optimization can also be switched from the shell through the Unity CLI (`unity command eval` setting `CompilationPipeline.codeOptimization`; ≈ 14 s reload each way — [tooling doc §9](../architecture/tooling/unity-cli-agent-workflow.md#9-breakpoints)); in **Release** no debugger can attach at all, and while the Editor is stopped at a breakpoint it answers nothing, CLI included.
- *Source:* [IDE support](../reference/testing-tooling/manual-scripting-ide-support.md), [Unity Development with VS Code](../reference/testing-tooling/code-visualstudio-com-unity.md), [Using Visual Studio Tools for Unity](../reference/testing-tooling/learn-microsoft-com-using-visual-studio-tools-for-unity.md), [How to debug with Visual Studio 2022](../reference/testing-tooling/how-to-debugging-with-microsoft-visual-studio-2022.md), [Using the Visual Studio Editor package](../reference/testing-tooling/ide-visualstudio-2-0-using-visual-studio-editor.md), [Using the JetBrains Rider Editor package](../reference/testing-tooling/ide-rider-3-0-using-the-jetbrains-rider-editor-package.md), [External Tools preferences](../reference/testing-tooling/manual-preferences-external-tools.md), [Debug C# code in Unity](../reference/testing-tooling/manual-managed-code-debugging.md).

Agents without an IDE (Claude Code, Codex…): you cannot compile C# outside Unity. After editing scripts, run the EditMode CLI above (Editor closed), drive the open Editor through the Unity CLI (`recompile` → `recompile_status` → `run_tests`, [tooling doc](../architecture/tooling/unity-cli-agent-workflow.md)), or ask the human to check the Console; never claim "it compiles" without one of these. **[project decision]**

## Roslyn analyzers and `.editorconfig` severity

- The repo-root `.editorconfig` (contents owned by [01](./01-csharp-style.md)) is read by Visual Studio, VS Code (C# Dev Kit) and Rider, and by Unity's own compilation for analyzer diagnostics. It is the only place style and diagnostic severity are configured — **NEVER** rely on personal IDE settings, `.ruleset` files or per-user `.DotSettings`. *Source:* [Analyzer scope and rule set files](../reference/csharp-style/manual-analyzer-scope-and-diagnostics.md), [Code-style rule options](../reference/csharp-style/learn-microsoft-com-code-style-rule-options.md), [C# style guide e-book — EditorConfig](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md).
- Severity syntax (`error` / `warning` / `suggestion` / `silent` / `none`), appended to the root file:

```ini
[*.cs]
# Example: promote a diagnostic to a compile error, silence another
dotnet_diagnostic.EX0001.severity = error
dotnet_diagnostic.IDE0055.severity = suggestion
```

- **MUST NOT** add analyzer DLLs (`RoslynAnalyzer`-labelled plugins such as `Microsoft.Unity.Analyzers` or StyleCop) to `Assets/` during the hackathon: they run on every Unity compile, and Unity does not configure them automatically. The IDE-side Unity analyzers (VSTU/Rider) already give the same hints while editing. **[project decision]** *Source:* [IDE support — Code analyzers](../reference/testing-tooling/manual-scripting-ide-support.md), [Install and use an existing analyzer](../reference/csharp-style/manual-install-existing-analyzer.md), [How to debug game code with Roslyn analyzers](../reference/csharp-style/how-to-debugging-with-rosyln-analyzers.md).

## Project Auditor

- **SHOULD** run once before the final build (and after any big asset drop): install `com.unity.project-auditor` (3.0.x for 6000.3) via **Package Manager > + > Add package by name**, then **Window > Analysis > Project Auditor > Start Analysis**. Fix *Code* and *Settings* diagnostics that touch `RootsDance.*`; ignore third-party noise. The *Domain Reload* view needs **Use Roslyn Analyzers** enabled in its Preferences and matters only if we disable domain reload (see [04](./04-unity-scripting-rules.md)).
- **MAY** automate with a static `ProjectAuditorCI.AuditAndExport()` Editor method invoked through `-batchmode -quit -executeMethod`.
- *Source:* [Project Auditor package](../reference/packages/project-auditor-3-0-index.md), [Analyze your project](../reference/packages/project-auditor-3-0-analyze-project.md), [Project Auditor package page (6000.3)](../reference/packages/manual-com-unity-project-auditor.md), [Domain reloading issues](../reference/testing-tooling/project-auditor-3-0-domain-reloading-issues.md), [Run from command line](../reference/testing-tooling/project-auditor-3-0-run-from-command-line.md).

## Console and log hygiene

- **MUST**: `develop` and `main` open with a Console that shows no errors and no warnings originating in `RootsDance.*` code (compiler warnings included). Fix or justify every warning in the PR; do not filter them away. Enable **Clear on Play** / **Clear on Recompile** so what you see is fresh. **[project decision]** *Source:* [Console window reference](../reference/testing-tooling/manual-console.md).
- **NEVER** log from `Update`, `FixedUpdate`, `LateUpdate` or hot loops; log statements (and their string formatting) cost frame time and flood the log. Use **Collapse** to spot a runaway per-frame error. *Source:* [Optimize your game performance for consoles and PCs — Remove Debug Log statements](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md), [Console window reference](../reference/testing-tooling/manual-console.md), [05 Performance](./05-performance.md).
- **MUST** log through `RootsDance.Core.Log` — `Log.Info`/`Log.Warning` compile out of release builds, `Log.Error`/`Log.Exception` stay; every overload takes a `UnityEngine.Object` context so the Console highlights the object: `Log.Warning("No spawn point assigned", this);`. Direct `Debug.Log*` is allowed only inside `Log` itself and in `_Sandbox/`. `Debug` logging is not stripped from release builds by itself. Class definition and severity meanings: [04 — Logging](./04-unity-scripting-rules.md#logging). **[project decision]** *Source:* [The Debug class — Excluding Debug code from non-development builds](../reference/testing-tooling/manual-class-debug.md), [Advanced programming — Avoid debug log statements](../reference/design-patterns/how-to-advanced-programming-and-code-architecture.md), [Scripting symbol reference](../reference/scripting/manual-scripting-symbol-reference.md).
- Stack traces: keep **ScriptOnly** (default) for Error/Exception and set Log/Warning to **None** in the `*-Release` profiles' Player Settings override; **NEVER** ship **Full** (the manual recommends no stack traces in shipped builds; keeping them for Error/Exception is a **[project decision]** so bug reports stay useful). Changed in **Project Settings > Player > Other Settings > Stack Trace** or the Console menu. *Source:* [Stack trace logging](../reference/testing-tooling/manual-stack-trace.md), [Build Profiles window reference — Add Settings > Player Settings](../reference/testing-tooling/manual-build-profiles-reference.md).
- **Error Pause** in the Console toolbar pauses Play mode on the first `LogError` — turn it on when hunting a bug, off when playtesting. *Source:* [Console window reference](../reference/testing-tooling/manual-console.md).
- Everything in the Console is also in the Editor/Player log files (paths above); attach the relevant log to bug reports instead of screenshots. *Source:* [Log files reference](../reference/testing-tooling/manual-log-files.md).

## Anti-patterns

- ❌ Test scripts in `Assets/RootsDance/Scripts/…` or in a folder without a test asmdef → ✅ only under `Assets/RootsDance/Tests/EditMode|PlayMode` with the two asmdefs from [02](./02-project-structure.md).
- ❌ `[UnityTest]` for a synchronous calculation → ✅ `[Test]`; `[UnityTest]` only when the test yields.
- ❌ Testing a `MonoBehaviour` by instantiating it in PlayMode to check arithmetic → ✅ move the arithmetic into a plain class and test it in EditMode.
- ❌ `Assert.AreEqual(new Vector3(0, 1, 0), transform.up)` → ✅ `Assert.That(transform.up, Is.EqualTo(Vector3.up).Using(Vector3EqualityComparer.Instance))`.
- ❌ Letting an expected `Log.Error` (a `LogType.Error` entry) fail the test, or setting `LogAssert.ignoreFailingMessages = true` globally → ✅ `LogAssert.Expect(LogType.Error, …)` for that one message.
- ❌ `yield return new WaitForSeconds(5f)` in a default-run test → ✅ wait for the condition (`yield return null` loop with a frame cap) or tag `[Explicit, Category("Integration")]`.
- ❌ `Unity -runTests … -quit` → ✅ no `-quit` on test runs; `-quit` only on `-build` / `-executeMethod` runs.
- ❌ Building from a platform entry with **Development Build** ticked "for now" → ✅ `*-Dev` and `*-Release` profile assets.
- ❌ `BuildProfile.SetActiveBuildProfile(...)` or `BuildPlayerOptions.target` inside a batch build script to switch platform → ✅ `-activeBuildProfile` / `-buildTarget` on the command line, one platform per run.
- ❌ Committing `.csproj`/`.sln`/`.vscode/launch.json` "so the agent can build" → ✅ agents use the CLI test run; project files stay generated.
- ❌ An agent calling `unity command save_scene` / `save_all` / `build` (or `capture_* --save_path`) against the open Editor because it "seemed useful" → ✅ read-only inspection through the Pipeline; saving, building and Play-mode/debugger state changes only when the human asked, and `git status --short` unchanged afterwards ([tooling doc §10](../architecture/tooling/unity-cli-agent-workflow.md#10-safety-rules-for-agents)).
- ❌ Copying `Microsoft.Unity.Analyzers.dll` into `Assets/` to get IDE hints → ✅ the IDE integration already provides them; `.editorconfig` carries severities.
- ❌ `Debug.Log($"pos={transform.position}")` in `Update` → ✅ `Log.Info` behind a condition, or a Gizmo/`Debug.DrawRay` (development only).

## Review checklist

- [ ] New pure-logic class has an EditMode `[Test]` fixture named `<TypeName>Tests` in the mirrored namespace; tests follow AAA and `Method_Scenario_ExpectedResult`.
- [ ] Tests live only under `Assets/RootsDance/Tests/EditMode` or `…/PlayMode`; the asmdefs were not edited except to add a legitimate reference.
- [ ] `[UnityTest]` is used only where the test yields; anything slower than ~1 s is `[Explicit, Category("Integration")]`.
- [ ] Every GameObject/asset/scene the test creates or opens is cleaned up in `[TearDown]`/`[UnityTearDown]`.
- [ ] Expected error logs are declared with `LogAssert.Expect`; no `ignoreFailingMessages`.
- [ ] Unity vector/quaternion/color comparisons use the `UnityEngine.TestTools.Utils` comparers.
- [ ] PR description states the EditMode suite was run (Test Runner or CLI) and passed; CLI runs used no `-quit`.
- [ ] No new Console errors or warnings from `RootsDance.*` after **Clear on Recompile** + entering Play mode; no logging in per-frame callbacks; all logging goes through `RootsDance.Core.Log` (no direct `Debug.Log*` outside `Log` and `_Sandbox/`).
- [ ] Build-related changes touch only the profile assets in `Assets/RootsDance/Settings/BuildProfiles/` (and `BuildScript.cs` if the escape hatch is used); `Builds/` output is not committed.
- [ ] No `.csproj`, `.sln`, `.vscode/`, `.idea/`, analyzer DLLs or `.ruleset` files were added.
- [ ] If the Unity CLI was used against an open Editor: Play mode stopped, no debugger attached, Code Optimization back to Release, `git status --short` unchanged ([tooling doc §10](../architecture/tooling/unity-cli-agent-workflow.md#10-safety-rules-for-agents)).

## Sources

1. [manual-test-framework-introduction.md](../reference/testing-tooling/manual-test-framework-introduction.md) — Testing your code (UTF introduction) — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/test-framework-introduction.html
2. [manual-edit-mode-vs-play-mode-tests.md](../reference/testing-tooling/manual-edit-mode-vs-play-mode-tests.md) — Edit mode and Play mode tests — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/edit-mode-vs-play-mode-tests.html
3. [manual-workflow-create-test-assembly.md](../reference/testing-tooling/manual-workflow-create-test-assembly.md) — Create a test assembly — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-create-test-assembly.html
4. [manual-workflow-create-test.md](../reference/testing-tooling/manual-workflow-create-test.md) — Create a test — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-create-test.html
5. [manual-assembly-definition-file-format.md](../reference/project-structure/manual-assembly-definition-file-format.md) — Assembly Definition file format reference — https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definition-file-format.html
6. [manual-assembly-definitions-creating.md](../reference/project-structure/manual-assembly-definitions-creating.md) — Create an Assembly Definition (test assemblies) — https://docs.unity3d.com/6000.3/Documentation/Manual/assembly-definitions-creating.html
7. [manual-cus-tests.md](../reference/testing-tooling/manual-cus-tests.md) — Add tests to your package (`testables`) — https://docs.unity3d.com/6000.3/Documentation/Manual/cus-tests.html
8. [manual-arrange-act-assert.md](../reference/testing-tooling/manual-arrange-act-assert.md) — Course 2. Arrange, Act, Assert — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/arrange-act-assert.html
9. [manual-semantic-test-assertion.md](../reference/testing-tooling/manual-semantic-test-assertion.md) — Course 3. Semantic test assertion — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/semantic-test-assertion.html
10. [manual-asserting-and-comparing.md](../reference/testing-tooling/manual-asserting-and-comparing.md) — Asserting and comparing — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/asserting-and-comparing.html
11. [manual-asserting-logs.md](../reference/testing-tooling/manual-asserting-logs.md) — Course 5. Asserting and expecting logs — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/asserting-logs.html
12. [test-framework-1-6-unityengine-testtools-utils-vector3equalitycomparer.md](../reference/testing-tooling/test-framework-1-6-unityengine-testtools-utils-vector3equalitycomparer.md) — Vector3EqualityComparer API — https://docs.unity3d.com/Packages/com.unity.test-framework@1.6/api/UnityEngine.TestTools.Utils.Vector3EqualityComparer.html
13. [manual-unitytest-attribute.md](../reference/testing-tooling/manual-unitytest-attribute.md) — Course 9. Using the UnityTest attribute — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/unitytest-attribute.html
14. [manual-reference-custom-yield-instructions.md](../reference/testing-tooling/manual-reference-custom-yield-instructions.md) — Yield instructions for the Editor — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-custom-yield-instructions.html
15. [manual-reference-unitysetup-and-unityteardown.md](../reference/testing-tooling/manual-reference-unitysetup-and-unityteardown.md) — Setting up and tearing down tests — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-unitysetup-and-unityteardown.html
16. [manual-setup-teardown.md](../reference/testing-tooling/manual-setup-teardown.md) — Course 6. SetUp and TearDown — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/setup-teardown.html
17. [manual-reference-async-tests.md](../reference/testing-tooling/manual-reference-async-tests.md) — Asynchronous tests — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-async-tests.html
18. [manual-async-awaitable-examples.md](../reference/scripting/manual-async-awaitable-examples.md) — Awaitable code example reference — https://docs.unity3d.com/6000.3/Documentation/Manual/async-awaitable-examples.html
19. [manual-reference-tests-parameterized.md](../reference/testing-tooling/manual-reference-tests-parameterized.md) — Parameterized tests — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-tests-parameterized.html
20. [manual-long-running-tests.md](../reference/testing-tooling/manual-long-running-tests.md) — Course 10. Long running tests — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/long-running-tests.html
21. [manual-scene-based-tests.md](../reference/testing-tooling/manual-scene-based-tests.md) — Course 11. Scene-based tests — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/course/scene-based-tests.html
22. [how-to-automated-tests-unity-test-framework.md](../reference/testing-tooling/how-to-automated-tests-unity-test-framework.md) — How to run automated tests with UTF — https://unity.com/how-to/automated-tests-unity-test-framework
23. [how-to-testing-and-quality-assurance-tips-unity-projects.md](../reference/testing-tooling/how-to-testing-and-quality-assurance-tips-unity-projects.md) — Testing and QA tips for Unity projects — https://unity.com/how-to/testing-and-quality-assurance-tips-unity-projects
24. [inputsystem-1-20-testing.md](../reference/testing-tooling/inputsystem-1-20-testing.md) — Input System — Testing — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/Testing.html
25. [ui-test-framework-6-3-install-and-set-up.md](../reference/testing-tooling/ui-test-framework-6-3-install-and-set-up.md) — UI Test Framework: install and set up — https://docs.unity3d.com/Packages/com.unity.ui.test-framework@6.3/manual/install-and-set-up.html
26. [scriptref-assertions-assert.md](../reference/testing-tooling/scriptref-assertions-assert.md) — Scripting API: Assertions.Assert — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Assertions.Assert.html
27. [manual-workflow-run-test.md](../reference/testing-tooling/manual-workflow-run-test.md) — Run tests in the Test Runner window — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-run-test.html
28. [manual-workflow-run-playmode-test-standalone.md](../reference/testing-tooling/manual-workflow-run-playmode-test-standalone.md) — Run Play mode tests in a Player — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/workflow-run-playmode-test-standalone.html
29. [manual-run-tests-from-command-line.md](../reference/testing-tooling/manual-run-tests-from-command-line.md) — Run tests from the command line — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/run-tests-from-command-line.html
30. [manual-reference-command-line.md](../reference/testing-tooling/manual-reference-command-line.md) — UTF command-line reference — https://docs.unity3d.com/6000.3/Documentation/Manual/test-framework/reference-command-line.html
31. [manual-editorcommandlinearguments.md](../reference/testing-tooling/manual-editorcommandlinearguments.md) — Unity Editor command line arguments reference — https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html
32. [manual-command-line-run-unity.md](../reference/testing-tooling/manual-command-line-run-unity.md) — Run Unity from a command-line interface — https://docs.unity3d.com/6000.3/Documentation/Manual/command-line-run-unity.html
33. [test-framework-1-6-changelog-changelog.md](../reference/testing-tooling/test-framework-1-6-changelog-changelog.md) — Test Framework changelog (1.6) — https://docs.unity3d.com/Packages/com.unity.test-framework@1.6/changelog/CHANGELOG.html
34. [manual-log-files.md](../reference/testing-tooling/manual-log-files.md) — Log files reference — https://docs.unity3d.com/6000.3/Documentation/Manual/log-files.html
35. [manual-safemode.md](../reference/testing-tooling/manual-safemode.md) — Safe Mode — https://docs.unity3d.com/6000.3/Documentation/Manual/SafeMode.html
36. [testtools-codecoverage-1-3-index.md](../reference/testing-tooling/testtools-codecoverage-1-3-index.md) — About Code Coverage (1.3) — https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/index.html
37. [testtools-codecoverage-1-3-installingcodecoverage.md](../reference/testing-tooling/testtools-codecoverage-1-3-installingcodecoverage.md) — Installing Code Coverage — https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/InstallingCodeCoverage.html
38. [testtools-codecoverage-1-3-coveragetestrunner.md](../reference/testing-tooling/testtools-codecoverage-1-3-coveragetestrunner.md) — Using Code Coverage with Test Runner — https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/CoverageTestRunner.html
39. [testtools-codecoverage-1-3-usingcodecoverage.md](../reference/testing-tooling/testtools-codecoverage-1-3-usingcodecoverage.md) — Using Code Coverage — https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/UsingCodeCoverage.html
40. [testtools-codecoverage-1-3-coveragebatchmode.md](../reference/testing-tooling/testtools-codecoverage-1-3-coveragebatchmode.md) — Using Code Coverage in batchmode — https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/CoverageBatchmode.html
41. [testtools-codecoverage-1-3-technicaldetails.md](../reference/testing-tooling/testtools-codecoverage-1-3-technicaldetails.md) — Code Coverage technical details — https://docs.unity3d.com/Packages/com.unity.testtools.codecoverage@1.3/manual/TechnicalDetails.html
42. [manual-build-profiles.md](../reference/testing-tooling/manual-build-profiles.md) — Introduction to build profiles — https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles.html
43. [manual-create-build-profile.md](../reference/testing-tooling/manual-create-build-profile.md) — Create and manage build profiles — https://docs.unity3d.com/6000.3/Documentation/Manual/create-build-profile.html
44. [manual-build-profile-scene-list.md](../reference/testing-tooling/manual-build-profile-scene-list.md) — Manage scenes in a build — https://docs.unity3d.com/6000.3/Documentation/Manual/build-profile-scene-list.html
45. [manual-build-profiles-reference.md](../reference/testing-tooling/manual-build-profiles-reference.md) — Build Profiles window reference — https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-reference.html
46. [manual-build-profiles-override-settings.md](../reference/testing-tooling/manual-build-profiles-override-settings.md) — Customize settings with build profiles — https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles-override-settings.html
47. [manual-building-introduction.md](../reference/testing-tooling/manual-building-introduction.md) — Introduction to building — https://docs.unity3d.com/6000.3/Documentation/Manual/building-introduction.html
48. [manual-build-command-line.md](../reference/testing-tooling/manual-build-command-line.md) — Build a player from the command line — https://docs.unity3d.com/6000.3/Documentation/Manual/build-command-line.html
49. [manual-build-script-build.md](../reference/testing-tooling/manual-build-script-build.md) — Create a custom build script — https://docs.unity3d.com/6000.3/Documentation/Manual/build-script-build.html
50. [scriptref-buildpipeline-buildplayer.md](../reference/testing-tooling/scriptref-buildpipeline-buildplayer.md) — BuildPipeline.BuildPlayer — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.BuildPlayer.html
51. [scriptref-buildoptions.md](../reference/testing-tooling/scriptref-buildoptions.md) — BuildOptions — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.html
52. [scriptref-editorapplication-exit.md](../reference/testing-tooling/scriptref-editorapplication-exit.md) — EditorApplication.Exit — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorApplication.Exit.html
53. [manual-scripting-ide-support.md](../reference/testing-tooling/manual-scripting-ide-support.md) — Integrated development environment (IDE) support — https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-ide-support.html
54. [code-visualstudio-com-unity.md](../reference/testing-tooling/code-visualstudio-com-unity.md) — Unity Development with VS Code (Microsoft) — https://code.visualstudio.com/docs/other/unity
55. [learn-microsoft-com-using-visual-studio-tools-for-unity.md](../reference/testing-tooling/learn-microsoft-com-using-visual-studio-tools-for-unity.md) — Using Visual Studio Tools for Unity (Microsoft) — https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/get-started/using-visual-studio-tools-for-unity
56. [ide-visualstudio-2-0-using-visual-studio-editor.md](../reference/testing-tooling/ide-visualstudio-2-0-using-visual-studio-editor.md) — Using the Visual Studio Editor package — https://docs.unity3d.com/Packages/com.unity.ide.visualstudio@2.0/manual/using-visual-studio-editor.html
57. [ide-rider-3-0-using-the-jetbrains-rider-editor-package.md](../reference/testing-tooling/ide-rider-3-0-using-the-jetbrains-rider-editor-package.md) — Using the JetBrains Rider Editor package — https://docs.unity3d.com/Packages/com.unity.ide.rider@3.0/manual/using-the-jetbrains-rider-editor-package.html
58. [manual-preferences-external-tools.md](../reference/testing-tooling/manual-preferences-external-tools.md) — External Tools preferences reference — https://docs.unity3d.com/6000.3/Documentation/Manual/preferences-external-tools.html
59. [manual-managed-code-debugging.md](../reference/testing-tooling/manual-managed-code-debugging.md) — Debug C# code in Unity — https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-debugging.html
60. [manual-analyzer-scope-and-diagnostics.md](../reference/csharp-style/manual-analyzer-scope-and-diagnostics.md) — Analyzer scope and rule set files — https://docs.unity3d.com/6000.3/Documentation/Manual/analyzer-scope-and-diagnostics.html
61. [manual-install-existing-analyzer.md](../reference/csharp-style/manual-install-existing-analyzer.md) — Install and use an existing analyzer or source generator — https://docs.unity3d.com/6000.3/Documentation/Manual/install-existing-analyzer.html
62. [how-to-debugging-with-rosyln-analyzers.md](../reference/csharp-style/how-to-debugging-with-rosyln-analyzers.md) — How to debug game code with Roslyn analyzers — https://unity.com/how-to/debugging-with-rosyln-analyzers
63. [learn-microsoft-com-code-style-rule-options.md](../reference/csharp-style/learn-microsoft-com-code-style-rule-options.md) — Microsoft: Code-style rule options (.editorconfig) — https://learn.microsoft.com/en-us/dotnet/fundamentals/code-analysis/code-style-rule-options
64. [ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md](../reference/csharp-style/ebook-use-a-c-style-guide-for-clean-and-scalable-game-code-unity-6-edition-e.md) — Use a C# style guide for clean and scalable game code (Unity 6 edition) e-book, EditorConfig section — https://cdn.bfldr.com/S5BC9Y64/at/f5vqx76rkt57bw9rjptcbcpv/Use_a_C__style_guide_for_clean_and_scalable_game_code_Unity_6_edition_e-book.pdf
65. [project-auditor-3-0-index.md](../reference/packages/project-auditor-3-0-index.md) — Project Auditor package 3.0 manual — https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/index.html
66. [project-auditor-3-0-analyze-project.md](../reference/packages/project-auditor-3-0-analyze-project.md) — Project Auditor: Analyze your project — https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/analyze-project.html
67. [manual-com-unity-project-auditor.md](../reference/packages/manual-com-unity-project-auditor.md) — Project Auditor package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.project-auditor.html
68. [project-auditor-3-0-domain-reloading-issues.md](../reference/testing-tooling/project-auditor-3-0-domain-reloading-issues.md) — Project Auditor: Domain reloading issues — https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/domain-reloading-issues.html
69. [project-auditor-3-0-run-from-command-line.md](../reference/testing-tooling/project-auditor-3-0-run-from-command-line.md) — Project Auditor: run from command line — https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/run-from-command-line.html
70. [manual-console.md](../reference/testing-tooling/manual-console.md) — Console window reference — https://docs.unity3d.com/6000.3/Documentation/Manual/Console.html
71. [manual-class-debug.md](../reference/testing-tooling/manual-class-debug.md) — The Debug class — https://docs.unity3d.com/6000.3/Documentation/Manual/class-Debug.html
72. [manual-stack-trace.md](../reference/testing-tooling/manual-stack-trace.md) — Stack trace logging — https://docs.unity3d.com/6000.3/Documentation/Manual/stack-trace.html
73. [manual-scripting-symbol-reference.md](../reference/scripting/manual-scripting-symbol-reference.md) — Scripting symbol reference (`DEVELOPMENT_BUILD`, `UNITY_EDITOR`) — https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-symbol-reference.html
74. [ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md](../reference/performance/ebook-optimize-your-game-performance-for-consoles-and-pcs-in-unity-unity-6-e.md) — Optimize your game performance for consoles and PCs in Unity (Unity 6 edition) e-book — Remove Debug Log statements — https://cdn.bfldr.com/S5BC9Y64/at/xbhk7z8kvttn35t3nx45mm98/Optimize_your_game_performance_for_consoles_and_PCs_in_Unity_Unity_6_edition_e-book.pdf
75. [how-to-advanced-programming-and-code-architecture.md](../reference/design-patterns/how-to-advanced-programming-and-code-architecture.md) — Advanced programming and code architecture (conditional logging) — https://unity.com/how-to/advanced-programming-and-code-architecture
76. [how-to-debugging-with-microsoft-visual-studio-2022.md](../reference/testing-tooling/how-to-debugging-with-microsoft-visual-studio-2022.md) — How to debug code with Microsoft Visual Studio 2022 — https://unity.com/how-to/debugging-with-microsoft-visual-studio-2022
77. Unity CLI (live, not downloaded) — https://docs.unity.com/en-us/unity-cli/unity-cli — consulted 2026-08-25 for install, `unity auth login`, `unity test` / `unity build` / `unity command`.
78. Use Unity CLI (live, not downloaded) — https://docs.unity.com/en-us/unity-cli/use-unity-cli
79. Unity CLI reference (live, not downloaded) — https://docs.unity.com/en-us/unity-cli/unity-cli-reference
80. Unity Pipeline package — Unity Production Pipeline, local tools / CLI (live, not downloaded) — https://docs.unity.com/en-us/unity-production-pipeline/local-tools-cli/unity-pipeline-package
81. `com.unity.pipeline` 0.5 package manual (live, not downloaded) — https://docs.unity3d.com/Packages/com.unity.pipeline@0.5/manual/index.html
