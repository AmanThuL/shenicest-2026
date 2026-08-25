# 09. Packages and game systems

> **Scope:** Which Unity packages this project uses (and which it does not), how each is set up, and the conventions for using them from scenes and code: Package Manager, Input System, Cinemachine, UI Toolkit (+ uGUI/TextMeshPro), Physics, AI Navigation, Animation, Audio, Addressables, ProBuilder/Timeline/Visual Scripting.
> **Applies to:** `Packages/manifest.json`, all assets under `Assets/RootsDance/`, and all C# under `Assets/RootsDance/Scripts`.
> **Status:** Unity 6000.3 LTS · last reviewed 2026-08-23

Rendering and URP are owned by [07-rendering-urp.md](./07-rendering-urp.md); generic scripting rules (lifecycle, Update vs FixedUpdate, null checks, Awaitable) by [04-unity-scripting-rules.md](./04-unity-scripting-rules.md); the 6.3 API renames by [10-unity6-facts.md](./10-unity6-facts.md). This document only adds the package-specific rules on top of those.

## TL;DR — rules at a glance

1. **MUST** use only packages from the 6000.3 *Released* / *Core* lists, at the versions in the table below; adding, removing or bumping a package is a team decision and its own `chore(packages):` commit of `Packages/manifest.json` + `Packages/packages-lock.json`.
2. **NEVER** add pre-release or experimental packages; **NEVER** add Git-URL, local-path or embedded (`Packages/<name>/`) packages without explicit team agreement (pin Git URLs to a tag or full commit hash).
3. **MUST** read input through the single project-wide action asset `Assets/RootsDance/Input/RootsDance.inputactions` via `InputSystem.actions.FindAction("<Map>/<Action>")` (map-qualified); cache the result once, poll continuous values in `Update`, never call `FindAction` per frame.
4. **NEVER** use `UnityEngine.Input`, the `PlayerInput` component, the generated C# wrapper class, or direct device reads (`Keyboard.current`) in shipping code.
5. **MUST** keep Input System **Update Mode** at *Process Events in Dynamic Update* and call `WasPressedThisFrame()` / `WasReleasedThisFrame()` only from `Update`.
6. **MUST** drive the camera with Cinemachine 3.1: exactly one Unity `Camera` with one `CinemachineBrain`, in `Bootstrap.unity`; every shot is a `CinemachineCamera` GameObject; switch shots by activating/deactivating GameObjects, not by moving the Unity Camera.
7. **MUST** build runtime UI with UI Toolkit (`UIDocument` + one shared `PanelSettings`), UXML under `Assets/RootsDance/UI/Documents/`, USS under `Assets/RootsDance/UI/Styles/`, BEM class names, no inline styles.
8. **MUST** wire UI in a presenter `MonoBehaviour` (MVP, see [03](./03-architecture-patterns.md)): query elements in `OnEnable`, unregister callbacks in `OnDisable`, cache every `Q<>()` result.
9. **MUST** use `CharacterController` for the player and `Rigidbody` only for things that should be pushed, thrown or fall; never both on one object; move a Rigidbody only from `FixedUpdate` via Rigidbody APIs.
10. **MUST** give every physics query an explicit `LayerMask` serialized field and an explicit `QueryTriggerInteraction`; project layers are the ones listed in the Physics section.
11. **MUST** put NPC movement on `NavMeshAgent` + `NavMeshSurface`; if an agent needs physics, its Rigidbody is kinematic; never combine `NavMeshAgent` and `NavMeshObstacle` on the same active object.
12. **MUST** hash Animator parameter names once (`Animator.StringToHash`) into `static readonly int` fields named `k_<Name>Hash` (see [01](./01-csharp-style.md)); Root Motion is off unless a feature owner documents why.
13. **MUST** route every `AudioSource` to a group of the single `AudioMixer` asset; control volume through exposed parameters from `Start` or later, never from `Awake`/`OnEnable`.
14. **NEVER** add Addressables or a `Resources/` folder by default; direct serialized references and prefabs are the asset-loading model.
15. **MAY** use ProBuilder for greyboxing and Timeline for cutscenes; **NEVER** use Visual Scripting or Netcode; Unity Behavior only with team agreement.

## Package inventory for 6000.3

| Package | Version for 6000.3 | Status in this project | Source |
|---|---|---|---|
| Input System `com.unity.inputsystem` | 1.20.0 (released) | **Required** | [ref](../reference/packages/manual-com-unity-inputsystem.md) |
| Cinemachine `com.unity.cinemachine` | 3.1.7 (released) | **Required** | [ref](../reference/packages/manual-com-unity-cinemachine.md) |
| UniTask (Cysharp) `com.cysharp.unitask` | 2.5.11 (OpenUPM) | **Installed** for heterogeneous concurrent async (e.g. a DOTween tween awaited alongside a scene load / `AsyncOperation`, via `.ToUniTask()`) — `Awaitable` has no native `WhenAll`/`WhenAny`. Pure tween-only composition still goes through DOTween `Sequence`. Usage rules for guidelines [04](./04-unity-scripting-rules.md)/[10](./10-unity6-facts.md) (still say `Awaitable`-only) are **not yet rewritten** — team decision pending, don't take the old "no UniTask" wording as settled either way. | [github.com/Cysharp/UniTask](https://github.com/Cysharp/UniTask) |
| Odin Inspector (Sirenix, Asset Store `.unitypackage`, **not** UPM) | 4.0.2.3 at `Assets/Plugins/Sirenix/` | **Required** — Editor-UX only, Odin serializer unused; rules in [12](./12-odin-inspector.md) | [ref](../reference/third-party/odin-inspector/README.md) |
| AI Navigation `com.unity.ai.navigation` | 2.0.14 (released) | **Required** when there are NPCs | [ref](../reference/packages/manual-com-unity-ai-navigation.md) |
| UI Toolkit | part of the core Editor, no package | **Required** (runtime UI) | [ref](../reference/packages/manual-install-ui-toolkit-and-sample-projects.md) |
| uGUI + TextMeshPro `com.unity.ugui` | 2.0 (core, fixed to Editor) | Present; use only per the UI section | [ref](../reference/packages/manual-com-unity-ugui.md), [ref](../reference/packages/ugui-2-0-textmeshpro-index.md) |
| URP / Shader Graph | 17.3 (core) | Required — see [07](./07-rendering-urp.md) | [ref](../reference/packages/manual-pack-core.md) |
| Test Framework `com.unity.test-framework` | 1.6 (core) | Required — see [08](./08-testing-tooling.md) | [ref](../reference/packages/manual-com-unity-test-framework.md) |
| ProBuilder `com.unity.probuilder` | 6.1 (released) | **Optional** (greyboxing) | [ref](../reference/packages/manual-pack-safe.md) |
| Timeline `com.unity.timeline` | 1.8 (released) | **Not installed** (add when cutscenes are needed) | [ref](../reference/packages/manual-pack-safe.md) |
| Addressables `com.unity.addressables` | 2.9.1 released for 6000.3; 3.x/4.0 also available | **Not installed** | [ref](../reference/packages/manual-com-unity-addressables.md) |
| Behavior `com.unity.behavior` | 1.0.16 (released) | **Not installed** (needs agreement) | [ref](../reference/packages/manual-com-unity-behavior.md) |
| Visual Scripting `com.unity.visualscripting` | 1.9 (released) | **Not installed** | [ref](../reference/packages/manual-pack-safe.md) |
| Netcode for GameObjects | 2.13 (released) | **Not used** (single-player) | [ref](../reference/packages/manual-pack-safe.md) |

Removed from the Universal 3D template manifest at import (2026-08-24), all with zero dependents in the lock file: `com.unity.collab-proxy` (Unity Version Control plugin — this project is Git-only, [06](./06-version-control.md) rule 15), `com.unity.multiplayer.center` (single-player game), `com.unity.pipeline` 0.5.0-exp.1 (experimental — forbidden below), `com.unity.timeline` and `com.unity.visualscripting` (per this table). `com.unity.cinemachine` 3.1.7 was added at the same time. **[project decision]**

*Why:* "Released" packages are the ones Unity has tested against this Editor version; core packages ship with the Editor and cannot be switched to another version. Everything else is a risk the hackathon cannot absorb.
*Source:* [Released packages](../reference/packages/manual-pack-safe.md), [Core packages](../reference/packages/manual-pack-core.md), [Package states and lifecycle](../reference/packages/manual-upm-lifecycle.md).

## Package Manager rules

**MUST** commit `Packages/manifest.json` and `Packages/packages-lock.json`; never hand-edit the lock file.
- *Why:* The manifest is the list of direct dependencies the Package Manager resolves on load; the lock file (enabled by default) makes that resolution deterministic for every teammate.
- *Source:* [Project manifest file](../reference/packages/manual-upm-manifestprj.md) (`dependencies`, `enableLockFile`).

**MUST** add packages through **Window > Package Manager > Unity Registry > Install** and commit the resulting manifest/lock change alone, with a `chore(packages):` message naming the package and version. Announce it in team chat first. **[project decision]**
- *Why:* The Package Manager resolves version conflicts for you when it installs; a separate commit keeps package churn out of feature diffs and lets `develop` and `main` stay openable.
- *Source:* [Install a UPM package from a registry](../reference/packages/manual-upm-ui-install.md); branching rules in [06-version-control.md](./06-version-control.md).

**SHOULD** keep the version the Package Manager picks as "released for 6000.3"; versions are locked by `packages-lock.json`. **MAY** add `pinnedPackages` (or `resolutionStrategy`) only to hold back a package that auto-updates undesirably, and then document why in the `chore(packages):` commit message. **[project decision]**
- *Why:* `dependencies` entries are minimum versions; `pinnedPackages` forces the exact version even when another is more compatible with the Editor.
- *Source:* [Project manifest file](../reference/packages/manual-upm-manifestprj.md), [Switch to another version of a UPM package](../reference/packages/manual-upm-ui-update.md).

**NEVER** install pre-release or experimental packages (version `0.x`, `-exp`, `-pre`), and leave **Show Pre-release Package Versions** off.
- *Why:* Experimental packages are unsupported; pre-release packages are supported but not yet verified for this Editor version; deprecated ones may be nonfunctional. Only *Released* packages have passed validation for 6000.3.
- *Source:* [Package states and lifecycle](../reference/packages/manual-upm-lifecycle.md), [Install a UPM package from a registry](../reference/packages/manual-upm-ui-install.md).

**NEVER** add a Git-URL dependency without team agreement. If agreed: pin it with `#<tag>` or a **full** commit hash, note that every machine needs Git ≥ 2.14 on `PATH`, and that LFS-tracked package content can silently import as pointer files.
- *Why:* Unpinned Git dependencies resolve to "latest default branch", and the Package Manager's shallow clones do not reliably fetch LFS files.
- *Source:* [Introduction to Git dependencies](../reference/packages/manual-upm-git.md).

**NEVER** embed or "Customize" a package without team agreement; if agreed, the whole folder under `Packages/<name>/` is committed and the reason recorded in `docs/third-party.md` (per [02](./02-project-structure.md)). **[project decision]**
- *Why:* An embedded copy silently overrides the registry version for everyone and must then be tracked and merged like source; we have no capacity to maintain a fork.
- *Source:* [Embedded dependencies](../reference/packages/manual-upm-embed.md).

Asset Store `.unitypackage` content is not a UPM package: it goes under `Assets/ThirdParty/` per [02-project-structure.md](./02-project-structure.md) — except Odin Inspector, which stays at its vendor-required path `Assets/Plugins/Sirenix/` ([12](./12-odin-inspector.md), [`docs/third-party.md`](../third-party.md)). Adding any further Asset Store package is the same team decision and its own `chore:` commit as a UPM package.

## Input System 1.20

### Setup

**MUST** set **Edit > Project Settings > Player > Other Settings > Active Input Handling** to **Input System Package (New)**. **[project decision; Unity recommends the package for new projects]**
- *Why:* Having the package installed does not by itself switch runtime input; `Both` keeps the legacy backend alive and invites `UnityEngine.Input` calls.
- *Source:* [Runtime UI event system and input handling](../reference/packages/manual-uie-runtime-event-system.md), [Enable the correct input system](../reference/packages/inputsystem-1-20-enable-correct-input-system.md).

**MUST** have exactly one action asset, `Assets/RootsDance/Input/RootsDance.inputactions`, assigned as project-wide in **Edit > Project Settings > Input System Package**. It is the template's `InputSystem_Actions` asset moved and renamed inside the Editor (see [02](./02-project-structure.md)).
- *Why:* Unity's recommended workflow is a single project-wide asset: it is preloaded, enabled automatically at startup, and reachable as `InputSystem.actions` without references.
- *Source:* [About project-wide actions](../reference/packages/inputsystem-1-20-about-project-wide-actions.md), [Create and assign a default project-wide actions asset](../reference/packages/inputsystem-1-20-create-project-wide-actions.md), [Workflows](../reference/packages/inputsystem-1-20-workflows.md).

**MUST** edit actions only in the Actions Editor (**Edit > Project Settings > Input System Package > Input Actions**) and treat the `.inputactions` file as a single-owner asset: announce before editing, commit immediately after. **[project decision]**
- *Why:* The asset is one JSON file; concurrent edits produce merge conflicts in generated GUIDs that nobody wants to resolve by hand.
- *Source:* [About action assets](../reference/packages/inputsystem-1-20-about-action-assets.md); ownership rules in [11-scenes-prefabs-workflow.md](./11-scenes-prefabs-workflow.md).

### Action maps and naming

**MUST** keep the default `Player` and `UI` maps and add one map per distinct control context (e.g. `Vehicle`, `Dialogue`). Map names cannot contain `/`.
- *Why:* A map is the unit you enable/disable; grouping by context is what lets you switch gameplay off while a menu is open.
- *Source:* [Concepts](../reference/packages/inputsystem-1-20-understanding-input.md), [Create action maps](../reference/packages/inputsystem-1-20-create-edit-delete-action-maps.md), [Default actions](../reference/packages/inputsystem-1-20-default-actions.md).

**MUST** name actions as PascalCase verbs (`Move`, `Look`, `Jump`, `Interact`, `Pause`); **SHOULD** keep action names unique across the whole asset. **[project decision on naming]**
- *Why:* Unity only requires uniqueness within a map; unique names keep the Actions Editor readable, while map-qualified lookups (below) stay unambiguous either way.
- *Source:* [Concepts](../reference/packages/inputsystem-1-20-understanding-input.md), [Scripting with actions API overview](../reference/packages/inputsystem-1-20-api-overview.md).

### Reading input in code

**MUST** cache `InputAction` references once (in `Awake` or `Start`) with `InputSystem.actions.FindAction("<Map>/<Action>")` (map-qualified, e.g. `"Player/Jump"`) and poll them in `Update`; **NEVER** call `FindAction` in `Update`.
- *Why:* `FindAction` is a string lookup; Unity's recommended workflow is "find in Start, read in Update", and the `Map/Action` form is the one Unity documents for disambiguating same-named actions (it matches [04](./04-unity-scripting-rules.md)).
- *Source:* [Using the Actions workflow](../reference/packages/inputsystem-1-20-using-actions-workflow.md), [About responding to input](../reference/packages/inputsystem-1-20-about-responding-to-input.md), [Quick start guide](../reference/packages/inputsystem-1-20-quick-start-guide.md).

```csharp
using UnityEngine;
using UnityEngine.InputSystem;

namespace RootsDance.Player
{
    [RequireComponent(typeof(CharacterController))]
    public sealed class PlayerMotor : MonoBehaviour
    {
        [SerializeField] private float m_moveSpeed = 5f;

        private CharacterController m_controller;
        private InputAction m_moveAction;
        private InputAction m_jumpAction;

        private void Awake()
        {
            m_controller = GetComponent<CharacterController>();
            m_moveAction = InputSystem.actions.FindAction("Player/Move");   // once, never per frame
            m_jumpAction = InputSystem.actions.FindAction("Player/Jump");
        }

        private void Update()
        {
            Vector2 input = m_moveAction.ReadValue<Vector2>();
            Vector3 move = new Vector3(input.x, 0f, input.y);
            m_controller.Move(move * (m_moveSpeed * Time.deltaTime));

            if (m_jumpAction.WasPressedThisFrame())
            {
                // start jump
            }
        }
    }
}
```

**SHOULD** poll (`ReadValue<T>()`, `IsPressed()`, `WasPressedThisFrame()`, `WasPerformedThisFrame()`) for continuous character control, and use `performed`/`canceled` callbacks only for discrete, infrequent actions (pause, interact). Callbacks subscribed in `OnEnable` are unsubscribed in `OnDisable`; never store a `CallbackContext`. **[project decision on where to subscribe]**
- *Why:* Unity states polling is simpler for action games with a centralized character; a `CallbackContext` is only valid during the callback.
- *Source:* [About responding to input](../reference/packages/inputsystem-1-20-about-responding-to-input.md), [InputAction API](../reference/packages/inputsystem-1-20-unityengine-inputsystem-inputaction.md), [Set callbacks on actions](../reference/packages/inputsystem-1-20-set-callbacks-on-actions.md).

**MAY** expose an `InputActionReference` serialized field when a component must be reusable with different actions (e.g. a generic "hold to confirm" UI widget); read it through `.action`.
- *Why:* A reference serializes without serializing the action and survives renames.
- *Source:* [InputActionReference API](../reference/packages/inputsystem-1-20-unityengine-inputsystem-inputactionreference.md).

**NEVER** use the `PlayerInput` component for the single-player game; it is permitted only if local multiplayer is added, and then all input is read from that component's own `actions` copy, not `InputSystem.actions`. **[project decision]**
- *Why:* `PlayerInput` hides action–code connections in the Inspector (harder to debug) and exists for device assignment in local multiplayer.
- *Source:* [Using the PlayerInput workflow](../reference/packages/inputsystem-1-20-using-playerinput-workflow.md).

**NEVER** enable **Generate C# Class** on the action asset. **[project decision]**
- *Why:* It is an alternative to project-wide actions, and the generated file churns in Git on every asset edit.
- *Source:* [Generate C# API from actions](../reference/packages/inputsystem-1-20-generate-cs-api-from-actions.md).

**NEVER** read devices directly (`Keyboard.current`, `Gamepad.current`) or call `UnityEngine.Input` outside `Assets/_Sandbox/`.
- *Why:* Direct reads bypass maps, bindings and rebinding; Unity lists them as "fast prototyping" only. The legacy backend is disabled in this project.
- *Source:* [Workflows](../reference/packages/inputsystem-1-20-workflows.md), [About responding to input](../reference/packages/inputsystem-1-20-about-responding-to-input.md).

### Timing (Update vs FixedUpdate)

**MUST** keep **Project Settings > Input System Package > Input Settings > Update Mode** at *Process Events in Dynamic Update*, and call `WasPressedThisFrame()` / `WasReleasedThisFrame()` only from `Update`. For Rigidbody movement, read continuous values (`ReadValue<Vector2>()`) in `FixedUpdate`, or cache a press detected in `Update` into a field that `FixedUpdate` consumes. **[project decision among Unity's documented options]**
- *Why:* Dynamic-update processing gives the lowest latency; mixing `WasPressedThisFrame` with the wrong loop misses or duplicates presses.
- *Source:* [Select an input processing mode](../reference/packages/inputsystem-1-20-timing-select-mode.md), [Avoid missed or duplicate events](../reference/packages/inputsystem-1-20-timing-missed-duplicate-events.md), [Optimize for fixed update](../reference/packages/inputsystem-1-20-timing-optimize-fixed-update.md).

### UI vs gameplay input

**MUST** disable the `Player` map while a blocking menu is open and re-enable it on close (`InputSystem.actions.FindActionMap("Player").Disable()` / `.Enable()`); the `UI` map stays enabled. Lock the cursor (`Cursor.lockState`) while the gameplay camera is in control. **[project decision; Unity's "explicit mode switch" strategy]**
- *Why:* Nothing stops UI and gameplay from consuming the same click or stick; an explicit mode switch is the strategy Unity documents for this.
- *Source:* [Handling input target ambiguity](../reference/packages/inputsystem-1-20-handling-input-target-ambiguity.md), [Enabling actions](../reference/packages/inputsystem-1-20-enable-actions.md).

UI Toolkit-only scenes need no `EventSystem` GameObject: the default runtime event system derives UI events from the project-wide `UI` map. Only add an `EventSystem` + **Input System UI Input Module** if uGUI is mixed in.
- *Source:* [Runtime UI event system and input handling](../reference/packages/manual-uie-runtime-event-system.md).

## Cinemachine 3.1

**MUST** write against the 3.x API: namespace `Unity.Cinemachine`, component `CinemachineCamera` (not `CinemachineVirtualCamera`/`CinemachineFreeLook`), pipeline components as ordinary components (`GetComponent<CinemachineFollow>()`), no `m_` field prefixes, no `CinemachineCore.Instance`.
- *Why:* Most online tutorials are 2.x; the 3.x types are new components, not renames, and 2.x names are deprecated.
- *Source:* [What's new in Cinemachine 3](../reference/packages/cinemachine-3-1-whats-new.md).

**MUST** have exactly one Unity `Camera` (tagged `MainCamera`, holding the `CinemachineBrain` and the `AudioListener`) per loaded scene set; it lives in `Bootstrap.unity` (scene contents in [11](./11-scenes-prefabs-workflow.md)). Content scenes contain only `CinemachineCamera` GameObjects. **[project decision on placement]**
- *Why:* A Cinemachine setup must include only one Unity Camera, and that Camera carries the single Brain (several Brains exist only for split-screen, which we do not use); once the Brain is present, the Camera's transform and lens are driven by the live `CinemachineCamera`.
- *Source:* [Cinemachine essential elements](../reference/packages/cinemachine-3-1-concept-essential-elements.md), [Set up a basic Cinemachine environment](../reference/packages/cinemachine-3-1-setup-cinemachine-environment.md).

**MUST** name camera GameObjects `CM_<Context>_<Purpose>` (e.g. `CM_Explore_Follow`, `CM_Dialogue_Closeup`), never nest one `CinemachineCamera` under another, and keep **Standby Update** at the default unless profiling says otherwise. **[project decision on naming]**
- *Why:* Unity asks you to name cameras so they can be identified later; nesting is explicitly disallowed.
- *Source:* [Set up multiple Cinemachine Cameras](../reference/packages/cinemachine-3-1-setup-multiple-cameras.md), [Cinemachine essential elements](../reference/packages/cinemachine-3-1-concept-essential-elements.md), [Cinemachine Camera reference](../reference/packages/cinemachine-3-1-cinemachinecamera.md).

**MUST** select the live shot by activating/deactivating `CinemachineCamera` GameObjects; use **Priority** only for the stable layering below; call `Prioritize()` when two active cameras share a priority and you need a specific one live. **NEVER** move or parent the Unity Camera from gameplay code. **[project decision on the scheme]**
- Priority 0 — default gameplay camera(s); 10 — contextual gameplay (aim, vehicle); 20 — dialogue/cutscene; 30 — debug.
- *Why:* The Brain picks the highest-priority active camera (most recently activated wins ties); a disabled camera costs nothing and can still blend out. Timeline overrides all of this during a Cinemachine track.
- *Source:* [Camera control and transitions](../reference/packages/cinemachine-3-1-concept-camera-control-transitions.md), [CinemachineCamera API](../reference/packages/cinemachine-3-1-unity-cinemachine-cinemachinecamera.md), [CinemachineVirtualCameraBase API (live docs)](https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html).

```csharp
using Unity.Cinemachine;
using UnityEngine;

namespace RootsDance.Cameras   // not "Camera": it would shadow UnityEngine.Camera
{
    public sealed class DialogueCameraSwitch : MonoBehaviour
    {
        [SerializeField] private CinemachineCamera m_exploreCamera;
        [SerializeField] private CinemachineCamera m_dialogueCamera;

        public void EnterDialogue()
        {
            m_dialogueCamera.gameObject.SetActive(true);   // higher priority -> goes live, Brain blends
            m_exploreCamera.gameObject.SetActive(false);
        }

        public void ExitDialogue()
        {
            m_exploreCamera.gameObject.SetActive(true);
            m_dialogueCamera.gameObject.SetActive(false);
        }
    }
}
```

**SHOULD** configure transitions on the Brain only: **Default Blend** *Ease In Out* ~1 s for gameplay, plus a **Custom Blends** asset at `Assets/RootsDance/Settings/Cinemachine/CustomBlends.asset` for pairs that need a cut. Keep **Update Method** at *Smart Update* and **Blend Update Method** at *Late Update*. **[project decision on values and path]**
- *Why:* The Brain owns transition rules; *Smart Update* and *Late Update* are Unity's recommended settings.
- *Source:* [Cinemachine Brain reference](../reference/packages/cinemachine-3-1-cinemachinebrain.md), [Set up multiple Cinemachine Cameras](../reference/packages/cinemachine-3-1-setup-multiple-cameras.md).

**SHOULD** build the player camera from the menu recipes: **GameObject > Cinemachine > Targeted Cameras > Follow Camera** (third-person follow) or **FreeLook Camera** (orbit, uses `CinemachineOrbitalFollow` + `CinemachineRotationComposer` + `CinemachineInputAxisController`). Follow and FreeLook cameras track the player root; for a **Third Person Follow** camera (over-the-shoulder / aiming) set **Tracking Target** to an invisible child pivot of the player so aim decouples from model rotation. **[project decision]**
- *Why:* The recipes assemble the correct procedural components; Third Person Follow is rigidly attached to its target and aims by rotating it, so Unity documents the invisible-child pattern for that behaviour only.
- *Source:* [Follow and frame a character](../reference/packages/cinemachine-3-1-setup-follow-camera.md), [Create a FreeLook Camera](../reference/packages/cinemachine-3-1-freelookcameras.md), [Create a Third Person Camera](../reference/packages/cinemachine-3-1-thirdpersoncameras.md).

**MUST** feed look/orbit input through `CinemachineInputAxisController` with its **Input Action** fields set to the project-wide `Look` action (enable **Cancel Delta Time** for mouse-delta bindings). Never write a custom reader that polls devices.
- *Why:* Cinemachine 3 cameras do not read input; the controller is the supported bridge to the Input System and handles gain/accel/decel.
- *Source:* [Input Axis Controller](../reference/packages/cinemachine-3-1-cinemachineinputaxiscontroller.md), [What's new in Cinemachine 3](../reference/packages/cinemachine-3-1-whats-new.md).

**SHOULD** add `CinemachineDeoccluder` to cameras that follow a character through geometry, with **Collide Against** = `Environment` and **Ignore Tag** = the target's tag; use **Cinemachine Impulse** (source + listener extension) for camera shake instead of hand-written shake code.
- *Why:* The Deoccluder raycasts against colliders on the chosen layers; Impulse is the built-in shake pipeline.
- *Source:* [Cinemachine Deoccluder](../reference/packages/cinemachine-3-1-cinemachinedeoccluder.md), [Cinemachine Impulse](../reference/packages/cinemachine-3-1-cinemachineimpulse.md).

If the camera follows a Rigidbody-driven object and jitters, set that Rigidbody's **Interpolate** to *Interpolate*; see Physics below.

## UI Toolkit runtime UI

### Decision and file layout

**MUST** build menus and HUD with UI Toolkit; uGUI is allowed only for a feature UI Toolkit cannot do in 6.3 (keyframed Animation Clip / Timeline-driven UI, serialized `UnityEvent` hookups) and must be agreed first. The 6.3 manual's general runtime recommendation is uGUI with UI Toolkit as the alternative; its use-case table lists UI Toolkit as "often used for" multi-resolution menus and HUD, which is our case. **[project decision]**
- *Why:* Our reasons **[project decision]**: UXML/USS are text files that diff and merge cleanly and are easy for AI agents to author; UI lives in assets, not scenes/prefabs, so no scene-merge conflicts; UI Toolkit is Unity's active development direction. Its gaps per the comparison page (Animation Clips/Timeline integration, serialized events) are exactly the uGUI escape hatch.
- *Source:* [Comparison of UI systems in Unity](../reference/packages/manual-ui-system-compare.md).

**MUST** keep UI assets as: `Assets/RootsDance/UI/Documents/<Screen>.uxml`, `Assets/RootsDance/UI/Styles/<Screen>.uss` + `Styles/Common.uss` (variables, shared classes), one `Assets/RootsDance/UI/PanelSettings.asset` referenced by every `UIDocument`, and UI sprites/fonts in `UI/Sprites/`, `UI/Fonts/`. Presenters live in `Scripts/Runtime/UI/` (`RootsDance.UI`). **[project decision]**
- *Why:* One `PanelSettings` asset = one panel, one theme, one scale mode; splitting documents per screen keeps UXML diffs small.
- *Source:* [Get started with runtime UI](../reference/packages/manual-uie-get-started-with-runtime-ui.md), [Configure runtime UI](../reference/packages/manual-uie-render-runtime-ui.md); folder layout in [02](./02-project-structure.md).

**MUST** reference UXML/USS from code only through serialized `VisualTreeAsset` / `StyleSheet` fields, never `Resources.Load`.
- *Why:* Serialized references are checked by the Editor and stripped correctly; `Resources` bloats the build and bypasses references (asset-loading rule below).
- *Source:* [Load UXML and USS in C# scripts](../reference/packages/manual-uie-manage-asset-reference.md).

### USS and naming

**MUST** name classes in BEM kebab-case — block `pause-menu`, element `pause-menu__resume`, modifier `pause-menu__resume--disabled` — and style with single-class selectors. Element `name` attributes use the same BEM string so `Q<>("pause-menu__resume")` and `.pause-menu__resume` agree. **[project decision on reusing the BEM string as `name`]**
- *Why:* BEM removes hierarchical selectors, which are the main styling cost; type and `#name` selectors in BEM rules are discouraged.
- *Source:* [Best practices for USS](../reference/packages/manual-uie-uss-writingstylesheets.md), [UI Toolkit BPG — Styling](../reference/packages/manual-styling.md).

**NEVER** leave inline styles in UXML or set `style.*` from C# for things a class could express; extract them to a selector in UI Builder. **NEVER** use `:hover` on elements with many descendants or selectors ending in `*`.
- *Why:* Inline styles cost memory per element; hover and universal selectors invalidate large parts of the tree.
- *Source:* [Best practices for USS](../reference/packages/manual-uie-uss-writingstylesheets.md).

**SHOULD** put colours, spacing and font sizes in USS variables (`--color-accent`) inside `Common.uss`, and swap state with `AddToClassList` / `RemoveFromClassList` plus USS transitions rather than animating from C#.
- *Why:* Updating a variable updates every property that uses it; a class swap plus a USS transition animates without per-frame C# and keeps look and behaviour in the stylesheet.
- *Source:* [UI Toolkit BPG — Styling](../reference/packages/manual-styling.md).

**SHOULD** hide screens with `display: none` (a `--hidden` modifier class) rather than removing them from the hierarchy; use `visibility: hidden` only when layout must be preserved.
- *Why:* Recreating elements is the slow path; `display: none` keeps them ready at near-zero per-frame cost.
- *Source:* [Best practices for managing elements](../reference/packages/manual-uie-best-practices-for-managing-elements.md).

### Presenters

**MUST** pair each UXML document with one presenter `MonoBehaviour` (pattern and responsibilities in [03 — UI: MVP](./03-architecture-patterns.md#ui-mvp-by-default-mvvm-data-binding-where-it-removes-code)) that holds a serialized `UIDocument` reference, normally on the same GameObject: query in `OnEnable`, cache every `Q<>()` result in a field, register callbacks there, unregister in `OnDisable`.
- *Why:* `rootVisualElement` is only valid after the document loads in `OnEnable`; disabling the GameObject rebuilds the hierarchy, so cached elements and callbacks must be redone on re-enable.
- *Source:* [Get started with runtime UI](../reference/packages/manual-uie-get-started-with-runtime-ui.md), [FAQ for input and event systems](../reference/packages/manual-uie-faq-event-and-input-system.md), [Find visual elements with UQuery](../reference/packages/manual-uie-uquery.md), [Handle event callbacks and value changes](../reference/packages/manual-uie-events-handling.md).

```csharp
using UnityEngine;
using UnityEngine.UIElements;

namespace RootsDance.UI
{
    [RequireComponent(typeof(UIDocument))]
    public sealed class PauseMenuPresenter : MonoBehaviour
    {
        [SerializeField] private UIDocument m_document;

        private Button m_resumeButton;

        private void OnEnable()
        {
            VisualElement root = m_document.rootVisualElement;
            m_resumeButton = root.Q<Button>("pause-menu__resume");   // cached once per enable
            m_resumeButton.clicked += OnResumeClicked;
        }

        private void OnDisable()
        {
            if (m_resumeButton != null)
            {
                m_resumeButton.clicked -= OnResumeClicked;
            }
        }

        private void OnResumeClicked()
        {
            // raise the game's Resume event (see 03-architecture-patterns.md)
        }
    }
}
```

**SHOULD** build reusable widgets (health bar, item slot) as `[UxmlElement] partial class X : VisualElement` with a template UXML, not as copies of markup.
- *Why:* Visual elements are not GameObjects, so prefabs do not apply; a custom control is Unity's reusable unit and one fix applies to every instance.
- *Source:* [Encapsulate UXML documents with logic](../reference/packages/manual-uie-encapsulate-uxml-with-logic.md).

**SHOULD** capture only the element you need in closures and never keep `VisualElement` references in objects that outlive the `UIDocument`.
- *Why:* Elements are garbage-collected, not destroyed; a closure over `this` or a long-lived reference keeps the whole tree alive (a leak).
- *Source:* [Find visual elements with UQuery](../reference/packages/manual-uie-uquery.md).

### Data binding basics

**SHOULD** bind HUD values with runtime data binding instead of per-frame label updates: the data source is a `ScriptableObject` or plain class whose bindable members are `[CreateProperty]` properties (backing fields `[SerializeField, DontCreateProperty]`); set `root.dataSource` in the presenter; author paths in UXML with an unresolved data source type, binding mode **ToTarget** for read-only UI.
- *Why:* `CreateProperty` generates the property bag at compile time (no reflection); unresolved bindings let one `dataSource =` line rewire a whole screen.
- *Source:* [UI Toolkit BPG — Data binding](../reference/packages/manual-data-binding.md), [Get started with runtime binding](../reference/packages/manual-uie-get-started-runtime-binding.md).

```csharp
using Unity.Properties;
using UnityEngine;

namespace RootsDance.Player
{
    [CreateAssetMenu(menuName = "RootsDance/Player Stats")]   // asset files carry no SO suffix
    public sealed class PlayerStatsSO : ScriptableObject
    {
        [SerializeField, DontCreateProperty] private int m_health = 100;

        [CreateProperty]
        public int Health
        {
            get { return m_health; }
            set { m_health = value; }
        }
    }
}
```

### When uGUI / TextMeshPro instead

- World-space labels attached to 3D objects (name tags, damage numbers): **TextMesh Pro 3D Text** (`GameObject > 3D GameObject > TextMesh Pro - Text`). Import **Window > TextMeshPro > Import TMP Essential Resources** once and commit the `TextMesh Pro` folder. **[project decision]**
- UI that must be keyframed in an Animation Clip or driven by Timeline: uGUI Canvas + TextMeshProUGUI, with an `EventSystem` + **Input System UI Input Module** in the scene.
- *Source:* [TextMesh Pro](../reference/packages/ugui-2-0-textmeshpro-index.md), [Creating text](../reference/packages/ugui-2-0-textmeshpro-tmpobjects.md), [Comparison of UI systems](../reference/packages/manual-ui-system-compare.md), [Runtime UI event system](../reference/packages/manual-uie-runtime-event-system.md).

## Physics (built-in 3D)

### CharacterController vs Rigidbody

**MUST** move the player with `CharacterController.Move(delta)` once per frame from `Update` (including gravity you integrate yourself); **MUST** use a `Rigidbody` for anything that is pushed, thrown, falls or reacts to forces; **NEVER** put both on one object. **[project decision]**
- *Why:* The controller is a capsule that slides, steps and slopes but ignores forces and needs no Rigidbody; `Move` applies an absolute delta and does not apply gravity. A Rigidbody driven through its transform breaks the simulation.
- *Source:* [Introduction to character control](../reference/scripting/manual-charactercontrollers.md), [Character Controller reference](../reference/scripting/manual-class-charactercontroller.md), [CharacterController.Move](../reference/scripting/scriptref-charactercontroller-move.md), [Introduction to rigid body physics](../reference/scripting/manual-rigidbodiesoverview.md).

**SHOULD** tune the controller as Unity recommends: height ~2 m for humans, **Skin Width** > 0.01 and ≥ 10 % of radius, **Step Offset** 0.1–0.4, **Min Move Distance** 0.
- *Why:* A too-small Skin Width is the usual reason a character gets stuck or jitters; the other values are the manual's recommendations for a 2 m human.
- *Source:* [Character Controller reference](../reference/scripting/manual-class-charactercontroller.md).

**MUST** drive Rigidbodies per [04 — Physics API](./04-unity-scripting-rules.md#physics-api-unity-6-names) (`AddForce` / `MovePosition` / `linearVelocity` in `FixedUpdate`); a collider you move from script (platforms, doors) gets a **kinematic** Rigidbody. Start with **Collision Detection** *Discrete*; escalate to *Continuous Speculative* only for fast objects that tunnel. Turn on **Interpolate** only for bodies the camera follows.
- *Why:* Physics steps in `FixedUpdate`; transform writes bypass the simulation; speculative CCD costs more per body than discrete, and interpolation is only worth it where jitter is visible (a camera-tracked body).
- *Source:* [Introduction to rigid body physics](../reference/scripting/manual-rigidbodiesoverview.md), [Choose a collision detection mode](../reference/scripting/manual-choose-collision-detection-mode.md), [Apply interpolation to a Rigidbody](../reference/scripting/manual-rigidbody-interpolation.md); renames in [10](./10-unity6-facts.md).

### Layers and the collision matrix

**MUST** use these user layers and nothing else without agreement (**Edit > Project Settings > Tags and Layers**): `Environment` (static level geometry), `Player`, `Enemy`, `Interactable`, `Trigger` (invisible volumes), `Projectile`. Built-in `Default` is for props that need no special treatment. **[project decision]**
- *Why:* A small, named set keeps the collision matrix and every `LayerMask` field readable; Unity gives 24 user layers and Cinemachine 3 no longer consumes any.
- *Source:* [LayerMask](../reference/scripting/scriptref-layermask.md), [What's new in Cinemachine 3](../reference/packages/cinemachine-3-1-whats-new.md) (Cinemachine Channels replace layers).

**MUST** configure **Edit > Project Settings > Physics > Layer Collision Matrix** so that `Trigger` collides only with `Player`/`Enemy`/`Projectile`, `Projectile` does not collide with `Projectile`, and `Enemy`–`Enemy` is off when enemies use NavMesh avoidance. Commit `ProjectSettings/DynamicsManager.asset` with a message naming the change. **[project decision]**
- *Why:* Pairs that never need to interact cost simulation time and produce accidental trigger events.
- *Source:* [Layer-based collision detection](../reference/scripting/manual-layerbasedcollision.md).

### Triggers

**MUST** make trigger volumes static (no Rigidbody) on the `Trigger` layer, and rely on the moving object carrying the physics body (a moving `CharacterController` also raises trigger messages; note they stop until it moves again if its properties are edited). **MUST** filter in `OnTriggerEnter` with `CompareTag` or a component check, never by name.
- *Why:* Trigger messages fire only when at least one side has a physics body; static trigger + dynamic mover is the documented normal case.
- *Source:* [Create and configure a trigger collider](../reference/scripting/manual-collider-interactions-create-trigger.md), [Interaction between collider types](../reference/scripting/manual-collider-types-interaction.md), [OnTrigger events](../reference/scripting/manual-collider-interactions-ontrigger.md), [Character Controller reference](../reference/scripting/manual-class-charactercontroller.md); `CompareTag` rule in [04](./04-unity-scripting-rules.md).

### Raycasts and queries

**MUST** pass an explicit `[SerializeField] LayerMask` and an explicit `QueryTriggerInteraction` (normally `Ignore`) to every `Physics.Raycast` / `SphereCast` / `Overlap*` call, and run queries whose result drives Rigidbody movement from `FixedUpdate` (loop rules in [04](./04-unity-scripting-rules.md)) **[project decision]**.
- *Why:* Without a mask the ray hits everything (including your own collider); `UseGlobal` defers to the project-wide *Queries Hit Triggers* setting, which must not decide gameplay behaviour implicitly — `Ignore` never reports trigger hits, `Collide` always does.
- *Source:* [Physics.Raycast](../reference/scripting/scriptref-physics-raycast.md), [LayerMask](../reference/scripting/scriptref-layermask.md), [QueryTriggerInteraction (live docs)](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QueryTriggerInteraction.html).

```csharp
[SerializeField] private LayerMask m_interactableMask;   // set to "Interactable" in the Inspector
[SerializeField] private float m_reach = 3f;

private bool TryFindInteractable(Transform eye, out RaycastHit hit)
{
    Ray ray = new Ray(eye.position, eye.forward);
    return Physics.Raycast(ray, out hit, m_reach, m_interactableMask, QueryTriggerInteraction.Ignore);
}
```

## AI Navigation 2.0

**MUST** bake navigation with a `NavMeshSurface` component (**Add Component > Navigation > NavMesh Surface**) on the `_NavMesh` root group of `<Level>_Environment.unity` (never in the `_Gameplay` part), with **Collect Objects** = *All Game Objects* and **Include Layers** = `Environment` (+ `Default` only if props must block agents); the generated NavMesh data asset is committed next to the scene — ownership and bake/commit rules in [11](./11-scenes-prefabs-workflow.md). **[project decision on placement]**
- *Why:* The surface stores its NavMesh in an asset file; a missing or stale asset means agents stand still for everyone else. *Current Object Hierarchy* would collect only the empty `_NavMesh` group, so the layer filter is what scopes the bake.
- *Source:* [Create a NavMesh](../reference/packages/ai-navigation-2-0-createnavmesh.md), [NavMesh Surface component](../reference/packages/ai-navigation-2-0-navmeshsurface.md).

**MUST** move NPCs with `NavMeshAgent` (`SetDestination` / `destination`) and nothing else writing their transform. If the NPC must push or trigger physics, add a collider and a **kinematic** Rigidbody; **NEVER** a non-kinematic one. **NEVER** keep `NavMeshAgent` and `NavMeshObstacle` enabled on the same object at the same time.
- *Why:* Agent + dynamic Rigidbody is a race on the transform; agent + obstacle makes the agent avoid itself.
- *Source:* [Use NavMesh Agents with other components](../reference/packages/ai-navigation-2-0-mixingcomponents.md), [Create a NavMesh agent](../reference/packages/ai-navigation-2-0-createnavmeshagent.md), [NavMeshAgent.SetDestination](../reference/scripting/scriptref-ai-navmeshagent-setdestination.md).

**SHOULD** couple animation as "animation follows agent": feed `agent.velocity` magnitude into the Animator's `Speed` parameter; keep Root Motion off on agents.
- *Why:* It is the robust, simple direction of data flow Unity documents; agent-follows-animation needs `updatePosition = false` and is a day of work.
- *Source:* [Use NavMesh Agents with other components](../reference/packages/ai-navigation-2-0-mixingcomponents.md).

Unity Behavior 1.0.16 (behavior graphs) is a released package and **MAY** be added for NPC logic if the team agrees; until then NPC logic is plain C# state machines per [03](./03-architecture-patterns.md).
- *Source:* [About Unity Behavior](../reference/packages/behavior-1-0-index.md), [Behavior package page](../reference/packages/manual-com-unity-behavior.md).

## Animation

**MUST** give each character type one Animator Controller asset `Assets/RootsDance/Animations/Controllers/<Character>.controller` (override controllers `<Character>_<Variant>.overrideController` next to it; clips in `Animations/Clips/`, per [02](./02-project-structure.md)), with a locomotion **Blend Tree** driven by a `Speed` float, a hub-and-spoke layout around `Idle`, and layers only when a body region must be overridden. Variants of the same rig reuse the controller through an **Animator Override Controller**. **[project decision on layout]**
- *Why:* Blend trees hide complexity without callbacks; hub-and-spoke keeps transitions debuggable.
- *Source:* [Tips for building animator controllers](../reference/scripting/how-to-build-animator-controllers.md), [Introduction to Mecanim](../reference/scripting/manual-animationoverview.md).

**MUST** hash parameter names once into `private static readonly int` fields named `k_<Name>Hash` (naming per [01](./01-csharp-style.md)) and set them through the `int` overloads; parameter names are PascalCase and match the constant.
- *Why:* `StringToHash` is CRC32 of the name and is stable across sessions; hashing per call is wasted work.
- *Source:* [Animator.StringToHash](../reference/scripting/scriptref-animator-stringtohash.md), [Animation Parameters](../reference/scripting/manual-animationparameters.md).

```csharp
private static readonly int k_SpeedHash = Animator.StringToHash("Speed");
private static readonly int k_JumpHash = Animator.StringToHash("Jump");

private void Update()
{
    m_animator.SetFloat(k_SpeedHash, m_currentSpeed);
}

public void Jump()
{
    m_animator.SetTrigger(k_JumpHash);
}
```

**MUST** leave **Apply Root Motion** off (movement comes from `CharacterController`/`NavMeshAgent`); a feature owner who turns it on documents it in the prefab's README note and bakes Y/XZ into pose per the clip inspector rules. Use **Update Mode** *Animate Physics* only when the animated object pushes Rigidbodies; keep **Culling Mode** at the default. **[project decision on root motion]**
- *Why:* Two systems writing the transform (animation + controller/agent) produce sliding and fights; *Animate Physics* is the mode Unity names for animated objects that push Rigidbodies, and costs nothing to leave off otherwise.
- *Source:* [Animator component](../reference/scripting/manual-class-animator.md), [How Root Motion works](../reference/scripting/manual-rootmotion.md).

**NEVER** put gameplay logic in `StateMachineBehaviour`s; they may only raise an event or set a parameter. Prefer `Animator.CrossFade`/`Play` from code over webs of *Any State* transitions.
- *Why:* Logic hidden inside controller states is invisible to reviewers and tests; *Any State* webs make transition order impossible to reason about.
- *Source:* [Tips for building animator controllers](../reference/scripting/how-to-build-animator-controllers.md).

## Audio

**MUST** keep exactly one `AudioListener` (on the Unity Camera in `Bootstrap.unity`) and one `AudioMixer` asset `Assets/RootsDance/Audio/Mixers/Main.mixer` with groups `Master > Music`, `Master > SFX`, `Master > UI`, and exposed parameters `MusicVolume`, `SfxVolume`, `UiVolume`. Every `AudioSource` sets **Output** to one of these groups. **[project decision on names]**
- *Why:* Sources bypass the mixer when **Output** is *None*; category groups are what make global volume, ducking and snapshots possible.
- *Source:* [Audio overview](../reference/scripting/manual-audiooverview.md), [Introduction to the Audio Source component](../reference/scripting/manual-audiosource-overview.md), [Introduction to the Audio Mixer](../reference/scripting/manual-audiomixeroverview.md).

**MUST** change volumes with `AudioMixer.SetFloat("<ExposedName>", dB)` from `Start` or later — never in `Awake`, `OnEnable` or `RuntimeInitializeLoadType.AfterSceneLoad`; keep the exposed names as `const string k_` fields.
- *Why:* Unity documents unexpected behaviour when `SetFloat` runs in those callbacks; after the first `SetFloat` snapshots stop controlling that parameter.
- *Source:* [AudioMixer.SetFloat](../reference/scripting/scriptref-audio-audiomixer-setfloat.md).

**SHOULD** play overlapping one-shot effects with `PlayOneShot(clip, volumeScale)` on a shared SFX source, and use `Play()` on a dedicated source for loops/music. World sounds use **Spatial Blend** 1, UI and music 0.
- *Why:* `PlayOneShot` does not cancel clips already playing on the source, so many effects share one GameObject; Spatial Blend 1 makes a sound 3D (distance attenuation), 0 keeps it flat 2D.
- *Source:* [AudioSource.PlayOneShot](../reference/scripting/scriptref-audiosource-playoneshot.md), [Introduction to the Audio Source component](../reference/scripting/manual-audiosource-overview.md).

## Addressables — why not by default

**NEVER** install Addressables or create a `Resources/` folder for this hackathon. Load content through serialized references on prefabs/ScriptableObjects and additive scenes (see [11](./11-scenes-prefabs-workflow.md)). **[project decision]**
- *Why:* Addressables adds a content build per platform, a catalog, reference counting and mandatory `Release` calls — real work that buys nothing for a desktop build of a small game. `Resources` bloats the build and load time.
- *Source:* [Addressables introduction](../reference/packages/addressables-2-9-addressableassetsoverview.md), [Unload Addressable assets](../reference/packages/addressables-2-9-unloadingaddressableassets.md), [Load UXML and USS in C# scripts](../reference/packages/manual-uie-manage-asset-reference.md) (Resources note).

If a real need appears (remote content, memory pressure from optional content), install **2.9.1** — the version released for 6000.3 — not 4.0, reference assets with typed `AssetReferenceT<T>` fields, and pair every load with `Addressables.Release`.
- *Source:* [Addressables package page (6000.3)](../reference/packages/manual-com-unity-addressables.md), [Introduction to asset references](../reference/packages/addressables-2-9-asset-reference-intro.md), [Introduction to loading Addressable assets](../reference/packages/addressables-2-9-load-addressable-assets.md).

## ProBuilder, Timeline, Visual Scripting and multiplayer policy

- **ProBuilder 6.1 — MAY.** Greybox levels with it; keep ProBuilder meshes in the scene or, if exported, in `Assets/RootsDance/Meshes/Environment/` with a `Greybox_` prefix (folder rules in [02](./02-project-structure.md)); final art replaces them. *Source:* [About ProBuilder](../reference/packages/probuilder-6-1-index.md).
- **Timeline 1.8 — MAY** for cutscenes. A Timeline with a Cinemachine track overrides Brain priorities while a clip is active, so cutscene cameras never need priorities. Timeline assets live in `Assets/RootsDance/Animations/Timelines/`. *Source:* [Unity's Timeline](../reference/packages/timeline-1-8-index.md), [Camera control and transitions](../reference/packages/cinemachine-3-1-concept-camera-control-transitions.md).
- **Visual Scripting 1.9 — NEVER.** All logic is C# so it can be reviewed, tested and merged. **[project decision]**
- **Netcode / Multiplayer Center — out of scope.** The game is single-player; do not click **Install Packages** in the Multiplayer Center (**Window > Multiplayer > Multiplayer Center**) — it adds Netcode and service packages to the manifest. **[project decision]** *Source:* [Get started with the Multiplayer Center](../reference/packages/en-us-multiplayer-center.md).

## Anti-patterns

- ❌ `Input.GetAxis("Horizontal")` / `Input.GetKeyDown` → ✅ cached `InputAction` from `InputSystem.actions`, `ReadValue<Vector2>()` / `WasPressedThisFrame()`.
- ❌ `InputSystem.actions.FindAction("Player/Jump").WasPressedThisFrame()` inside `Update` → ✅ find once in `Awake`, poll the field.
- ❌ `WasPressedThisFrame()` in `FixedUpdate` → ✅ detect in `Update`, consume the cached flag in `FixedUpdate`.
- ❌ A second action asset per feature, or **Generate C# Class** → ✅ one project-wide asset, new action map per context.
- ❌ `CinemachineVirtualCamera`, `using Cinemachine;`, `vcam.m_Priority` → ✅ `CinemachineCamera`, `using Unity.Cinemachine;`, `SetActive`/`Prioritize()`.
- ❌ Moving `Camera.main.transform` from a script → ✅ switch `CinemachineCamera`s; the Brain owns the Unity Camera.
- ❌ `label.style.color = Color.red` per frame, `#title` selectors, `VisualElement > * > Button` → ✅ BEM classes, `AddToClassList("hud__health--critical")`, variables in `Common.uss`.
- ❌ Querying `rootVisualElement` in `Awake` / `Start` → ✅ query in `OnEnable`, unregister in `OnDisable`.
- ❌ `Resources.Load<VisualTreeAsset>("Hud")` → ✅ `[SerializeField] private VisualTreeAsset m_hudDocument;`.
- ❌ `transform.position += velocity` on a non-kinematic Rigidbody → ✅ `rb.linearVelocity` / `MovePosition` in `FixedUpdate`, or a `CharacterController`.
- ❌ `Physics.Raycast(origin, dir, out hit)` with no mask → ✅ explicit `LayerMask` field + `QueryTriggerInteraction.Ignore`.
- ❌ `NavMeshAgent` + dynamic `Rigidbody`, or agent + `NavMeshObstacle` both enabled → ✅ kinematic Rigidbody; toggle agent/obstacle exclusively.
- ❌ `animator.SetFloat("Speed", v)` every frame → ✅ `private static readonly int k_SpeedHash`.
- ❌ `mixer.SetFloat("MusicVolume", -80f)` in `Awake` → ✅ in `Start` or later.
- ❌ Adding `com.unity.addressables` or a `Resources/` folder "just in case" → ✅ serialized references, prefabs, additive scenes.
- ❌ Pasting a Git URL into Package Manager on your own branch → ✅ propose in chat; if agreed, pin to a tag/commit and commit manifest + lock separately.

## Review checklist

- [ ] `Packages/manifest.json` / `packages-lock.json` changed only in a dedicated `chore(packages):` commit; no Git/local/embedded/pre-release entries.
- [ ] No new Asset Store package outside `Assets/ThirdParty/` (Odin at `Assets/Plugins/Sirenix/` is the recorded exception); Odin usage follows the checklist in [12](./12-odin-inspector.md).
- [ ] No legacy `UnityEngine.Input` calls, `PlayerInput`, generated input class, or `Keyboard.current` outside `_Sandbox/`.
- [ ] `FindAction` only in `Awake`/`Start`; `WasPressedThisFrame` only in `Update`; Player map disabled while menus are open.
- [ ] New camera shots are `CinemachineCamera` GameObjects named `CM_*`, switched by `SetActive`; nobody touches the Unity Camera transform; Brain settings unchanged.
- [ ] UXML in `UI/Documents/`, USS in `UI/Styles/`, BEM classes, no inline styles, shared `PanelSettings`.
- [ ] UI presenter holds a serialized `UIDocument`, queries in `OnEnable`, unregisters in `OnDisable`, caches `Q<>()` results; UXML/USS referenced by serialized fields.
- [ ] Physics: no CharacterController + Rigidbody combos; Rigidbody moved only in `FixedUpdate`; every query has a `LayerMask` field and explicit `QueryTriggerInteraction`; only project layers used; collision-matrix changes committed deliberately.
- [ ] `NavMeshSurface` only in `<Level>_Environment` with **Include Layers** = `Environment`; NavMesh data committed per [11](./11-scenes-prefabs-workflow.md); agents have kinematic Rigidbodies at most; no agent+obstacle overlap.
- [ ] Animator parameters hashed into `static readonly int k_<Name>Hash`; Root Motion off unless documented; no gameplay in `StateMachineBehaviour`.
- [ ] Every `AudioSource` has a mixer group; `SetFloat` never in `Awake`/`OnEnable`; one `AudioListener`.
- [ ] No Addressables, `Resources/`, Visual Scripting, Netcode or Behavior added without a recorded team decision.

## Sources

1. [manual-pack-safe.md](../reference/packages/manual-pack-safe.md) — Released packages (Unity 6.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/pack-safe.html
2. [manual-pack-core.md](../reference/packages/manual-pack-core.md) — Core packages — https://docs.unity3d.com/6000.3/Documentation/Manual/pack-core.html
3. [manual-upm-lifecycle.md](../reference/packages/manual-upm-lifecycle.md) — Package states and lifecycle — https://docs.unity3d.com/6000.3/Documentation/Manual/upm-lifecycle.html
4. [manual-upm-manifestprj.md](../reference/packages/manual-upm-manifestprj.md) — Project manifest file — https://docs.unity3d.com/6000.3/Documentation/Manual/upm-manifestPrj.html
5. [manual-upm-ui-install.md](../reference/packages/manual-upm-ui-install.md) — Install a UPM package from a registry — https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-install.html
6. [manual-upm-ui-update.md](../reference/packages/manual-upm-ui-update.md) — Switch to another version of a UPM package — https://docs.unity3d.com/6000.3/Documentation/Manual/upm-ui-update.html
7. [manual-upm-git.md](../reference/packages/manual-upm-git.md) — Introduction to Git dependencies — https://docs.unity3d.com/6000.3/Documentation/Manual/upm-git.html
8. [manual-upm-embed.md](../reference/packages/manual-upm-embed.md) — Embedded dependencies — https://docs.unity3d.com/6000.3/Documentation/Manual/upm-embed.html
9. [manual-com-unity-inputsystem.md](../reference/packages/manual-com-unity-inputsystem.md) — Input System package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.inputsystem.html
10. [inputsystem-1-20-workflows.md](../reference/packages/inputsystem-1-20-workflows.md) — Input System Workflows — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/Workflows.html
11. [inputsystem-1-20-about-project-wide-actions.md](../reference/packages/inputsystem-1-20-about-project-wide-actions.md) — About project-wide actions — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/about-project-wide-actions.html
12. [inputsystem-1-20-create-project-wide-actions.md](../reference/packages/inputsystem-1-20-create-project-wide-actions.md) — Create and assign a default project-wide actions asset — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/create-project-wide-actions.html
13. [inputsystem-1-20-about-action-assets.md](../reference/packages/inputsystem-1-20-about-action-assets.md) — About action assets — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/about-action-assets.html
14. [inputsystem-1-20-understanding-input.md](../reference/packages/inputsystem-1-20-understanding-input.md) — Concepts — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/understanding-input.html
15. [inputsystem-1-20-create-edit-delete-action-maps.md](../reference/packages/inputsystem-1-20-create-edit-delete-action-maps.md) — Create action maps — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/create-edit-delete-action-maps.html
16. [inputsystem-1-20-default-actions.md](../reference/packages/inputsystem-1-20-default-actions.md) — The default project-wide actions — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/default-actions.html
17. [inputsystem-1-20-api-overview.md](../reference/packages/inputsystem-1-20-api-overview.md) — Scripting with actions API overview — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/api-overview.html
18. [inputsystem-1-20-using-actions-workflow.md](../reference/packages/inputsystem-1-20-using-actions-workflow.md) — Workflow Overview – Actions — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/using-actions-workflow.html
19. [inputsystem-1-20-about-responding-to-input.md](../reference/packages/inputsystem-1-20-about-responding-to-input.md) — About responding to input — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/about-responding-to-input.html
20. [inputsystem-1-20-unityengine-inputsystem-inputaction.md](../reference/packages/inputsystem-1-20-unityengine-inputsystem-inputaction.md) — Class InputAction — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputAction.html
21. [inputsystem-1-20-set-callbacks-on-actions.md](../reference/packages/inputsystem-1-20-set-callbacks-on-actions.md) — Set callbacks on actions — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/set-callbacks-on-actions.html
22. [inputsystem-1-20-unityengine-inputsystem-inputactionreference.md](../reference/packages/inputsystem-1-20-unityengine-inputsystem-inputactionreference.md) — Class InputActionReference — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/api/UnityEngine.InputSystem.InputActionReference.html
23. [inputsystem-1-20-using-playerinput-workflow.md](../reference/packages/inputsystem-1-20-using-playerinput-workflow.md) — Workflow Overview – Actions and the PlayerInput Component — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/using-playerinput-workflow.html
24. [inputsystem-1-20-generate-cs-api-from-actions.md](../reference/packages/inputsystem-1-20-generate-cs-api-from-actions.md) — Generate C# API from actions — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/generate-cs-api-from-actions.html
25. [inputsystem-1-20-enable-correct-input-system.md](../reference/packages/inputsystem-1-20-enable-correct-input-system.md) — Enable the correct input system — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/enable-correct-input-system.html
26. [inputsystem-1-20-enable-actions.md](../reference/packages/inputsystem-1-20-enable-actions.md) — Enabling actions — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/enable-actions.html
27. [inputsystem-1-20-timing-select-mode.md](../reference/packages/inputsystem-1-20-timing-select-mode.md) — Select an appropriate input processing mode — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/timing-select-mode.html
28. [inputsystem-1-20-timing-missed-duplicate-events.md](../reference/packages/inputsystem-1-20-timing-missed-duplicate-events.md) — Avoid missed or duplicate discrete events — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/timing-missed-duplicate-events.html
29. [inputsystem-1-20-timing-optimize-fixed-update.md](../reference/packages/inputsystem-1-20-timing-optimize-fixed-update.md) — Optimize for fixed-timestep or physics-based scenarios — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/timing-optimize-fixed-update.html
30. [inputsystem-1-20-handling-input-target-ambiguity.md](../reference/packages/inputsystem-1-20-handling-input-target-ambiguity.md) — Handling input target ambiguity — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/handling-input-target-ambiguity.html
31. [manual-com-unity-cinemachine.md](../reference/packages/manual-com-unity-cinemachine.md) — Cinemachine package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.cinemachine.html
32. [cinemachine-3-1-whats-new.md](../reference/packages/cinemachine-3-1-whats-new.md) — What's new in Cinemachine 3 — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/whats-new.html
33. [cinemachine-3-1-concept-essential-elements.md](../reference/packages/cinemachine-3-1-concept-essential-elements.md) — Cinemachine essential elements — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/concept-essential-elements.html
34. [cinemachine-3-1-concept-camera-control-transitions.md](../reference/packages/cinemachine-3-1-concept-camera-control-transitions.md) — Camera control and transitions — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/concept-camera-control-transitions.html
35. [cinemachine-3-1-setup-cinemachine-environment.md](../reference/packages/cinemachine-3-1-setup-cinemachine-environment.md) — Set up a basic Cinemachine environment — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/setup-cinemachine-environment.html
36. [cinemachine-3-1-setup-multiple-cameras.md](../reference/packages/cinemachine-3-1-setup-multiple-cameras.md) — Set up multiple Cinemachine Cameras and transitions — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/setup-multiple-cameras.html
37. [cinemachine-3-1-cinemachinebrain.md](../reference/packages/cinemachine-3-1-cinemachinebrain.md) — Cinemachine Brain component — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineBrain.html
38. [cinemachine-3-1-cinemachinecamera.md](../reference/packages/cinemachine-3-1-cinemachinecamera.md) — Cinemachine Camera component — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineCamera.html
39. [cinemachine-3-1-unity-cinemachine-cinemachinecamera.md](../reference/packages/cinemachine-3-1-unity-cinemachine-cinemachinecamera.md) — Class CinemachineCamera — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineCamera.html
40. [cinemachine-3-1-setup-follow-camera.md](../reference/packages/cinemachine-3-1-setup-follow-camera.md) — Follow and frame a character — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/setup-follow-camera.html
41. [cinemachine-3-1-freelookcameras.md](../reference/packages/cinemachine-3-1-freelookcameras.md) — Create a FreeLook Camera — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/FreeLookCameras.html
42. [cinemachine-3-1-thirdpersoncameras.md](../reference/packages/cinemachine-3-1-thirdpersoncameras.md) — Create a Third Person Camera — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/ThirdPersonCameras.html
43. [cinemachine-3-1-cinemachineinputaxiscontroller.md](../reference/packages/cinemachine-3-1-cinemachineinputaxiscontroller.md) — Cinemachine Input Axis Controller — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineInputAxisController.html
44. [cinemachine-3-1-cinemachinedeoccluder.md](../reference/packages/cinemachine-3-1-cinemachinedeoccluder.md) — Cinemachine Deoccluder — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineDeoccluder.html
45. [cinemachine-3-1-cinemachineimpulse.md](../reference/packages/cinemachine-3-1-cinemachineimpulse.md) — Cinemachine Impulse — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/manual/CinemachineImpulse.html
46. [manual-ui-system-compare.md](../reference/packages/manual-ui-system-compare.md) — Comparison of UI systems in Unity — https://docs.unity3d.com/6000.3/Documentation/Manual/UI-system-compare.html
47. [manual-install-ui-toolkit-and-sample-projects.md](../reference/packages/manual-install-ui-toolkit-and-sample-projects.md) — UI Toolkit BPG: Install UI Toolkit and sample projects — https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/install-ui-toolkit-and-sample-projects.html
48. [manual-uie-get-started-with-runtime-ui.md](../reference/packages/manual-uie-get-started-with-runtime-ui.md) — Get started with runtime UI — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-with-runtime-ui.html
49. [manual-uie-render-runtime-ui.md](../reference/packages/manual-uie-render-runtime-ui.md) — Render UI in the Game view — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-render-runtime-ui.html
50. [manual-uie-manage-asset-reference.md](../reference/packages/manual-uie-manage-asset-reference.md) — Load UXML and USS in C# scripts — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-manage-asset-reference.html
51. [manual-uie-uss-writingstylesheets.md](../reference/packages/manual-uie-uss-writingstylesheets.md) — Best practices for USS — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-USS-WritingStyleSheets.html
52. [manual-styling.md](../reference/packages/manual-styling.md) — UI Toolkit BPG: Styling — https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/styling.html
53. [manual-uie-best-practices-for-managing-elements.md](../reference/packages/manual-uie-best-practices-for-managing-elements.md) — Best practices for managing elements — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-best-practices-for-managing-elements.html
54. [manual-uie-faq-event-and-input-system.md](../reference/packages/manual-uie-faq-event-and-input-system.md) — FAQ for input and event systems with UI Toolkit — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-faq-event-and-input-system.html
55. [manual-uie-uquery.md](../reference/packages/manual-uie-uquery.md) — Find visual elements with UQuery — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-UQuery.html
56. [manual-uie-events-handling.md](../reference/packages/manual-uie-events-handling.md) — Handle event callbacks and value changes — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Events-Handling.html
57. [manual-uie-encapsulate-uxml-with-logic.md](../reference/packages/manual-uie-encapsulate-uxml-with-logic.md) — Encapsulate UXML documents with logic — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-encapsulate-uxml-with-logic.html
58. [manual-data-binding.md](../reference/packages/manual-data-binding.md) — UI Toolkit BPG: Data binding — https://docs.unity3d.com/6000.3/Documentation/Manual/best-practice-guides/ui-toolkit-for-advanced-unity-developers/data-binding.html
59. [manual-uie-get-started-runtime-binding.md](../reference/packages/manual-uie-get-started-runtime-binding.md) — Get started with runtime binding — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-get-started-runtime-binding.html
60. [manual-uie-runtime-event-system.md](../reference/packages/manual-uie-runtime-event-system.md) — Runtime UI event system and input handling — https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Event-System.html
61. [manual-com-unity-ugui.md](../reference/packages/manual-com-unity-ugui.md) — uGUI package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.ugui.html
62. [ugui-2-0-textmeshpro-index.md](../reference/packages/ugui-2-0-textmeshpro-index.md) — TextMesh Pro Documentation — https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/index.html
63. [ugui-2-0-textmeshpro-tmpobjects.md](../reference/packages/ugui-2-0-textmeshpro-tmpobjects.md) — TextMesh Pro: Creating text — https://docs.unity3d.com/Packages/com.unity.ugui@2.0/manual/TextMeshPro/TMPObjects.html
64. [manual-charactercontrollers.md](../reference/scripting/manual-charactercontrollers.md) — Introduction to character control — https://docs.unity3d.com/6000.3/Documentation/Manual/CharacterControllers.html
65. [manual-class-charactercontroller.md](../reference/scripting/manual-class-charactercontroller.md) — Character Controller component reference — https://docs.unity3d.com/6000.3/Documentation/Manual/class-CharacterController.html
66. [scriptref-charactercontroller-move.md](../reference/scripting/scriptref-charactercontroller-move.md) — CharacterController.Move — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CharacterController.Move.html
67. [manual-rigidbodiesoverview.md](../reference/scripting/manual-rigidbodiesoverview.md) — Introduction to rigid body physics — https://docs.unity3d.com/6000.3/Documentation/Manual/RigidbodiesOverview.html
68. [manual-choose-collision-detection-mode.md](../reference/scripting/manual-choose-collision-detection-mode.md) — Choose a collision detection mode — https://docs.unity3d.com/6000.3/Documentation/Manual/choose-collision-detection-mode.html
69. [manual-rigidbody-interpolation.md](../reference/scripting/manual-rigidbody-interpolation.md) — Apply interpolation to a Rigidbody — https://docs.unity3d.com/6000.3/Documentation/Manual/rigidbody-interpolation.html
70. [manual-layerbasedcollision.md](../reference/scripting/manual-layerbasedcollision.md) — Layer-based collision detection — https://docs.unity3d.com/6000.3/Documentation/Manual/LayerBasedCollision.html
71. [scriptref-layermask.md](../reference/scripting/scriptref-layermask.md) — LayerMask — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LayerMask.html
72. [scriptref-physics-raycast.md](../reference/scripting/scriptref-physics-raycast.md) — Physics.Raycast — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Physics.Raycast.html
73. [manual-collider-interactions-create-trigger.md](../reference/scripting/manual-collider-interactions-create-trigger.md) — Create and configure a trigger collider — https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions-create-trigger.html
74. [manual-collider-types-interaction.md](../reference/scripting/manual-collider-types-interaction.md) — Interaction between collider types — https://docs.unity3d.com/6000.3/Documentation/Manual/collider-types-interaction.html
75. [manual-collider-interactions-ontrigger.md](../reference/scripting/manual-collider-interactions-ontrigger.md) — OnTrigger events — https://docs.unity3d.com/6000.3/Documentation/Manual/collider-interactions-ontrigger.html
76. [manual-com-unity-ai-navigation.md](../reference/packages/manual-com-unity-ai-navigation.md) — AI Navigation package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.ai.navigation.html
77. [ai-navigation-2-0-createnavmesh.md](../reference/packages/ai-navigation-2-0-createnavmesh.md) — Create a NavMesh — https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/CreateNavMesh.html
78. [ai-navigation-2-0-navmeshsurface.md](../reference/packages/ai-navigation-2-0-navmeshsurface.md) — NavMesh Surface component — https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/NavMeshSurface.html
79. [ai-navigation-2-0-createnavmeshagent.md](../reference/packages/ai-navigation-2-0-createnavmeshagent.md) — Create a NavMesh Agent — https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/CreateNavMeshAgent.html
80. [ai-navigation-2-0-mixingcomponents.md](../reference/packages/ai-navigation-2-0-mixingcomponents.md) — Use NavMesh Agent with Other Components — https://docs.unity3d.com/Packages/com.unity.ai.navigation@2.0/manual/MixingComponents.html
81. [scriptref-ai-navmeshagent-setdestination.md](../reference/scripting/scriptref-ai-navmeshagent-setdestination.md) — NavMeshAgent.SetDestination — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AI.NavMeshAgent.SetDestination.html
82. [behavior-1-0-index.md](../reference/packages/behavior-1-0-index.md) — About Unity Behavior — https://docs.unity3d.com/Packages/com.unity.behavior@1.0/manual/index.html
83. [manual-com-unity-behavior.md](../reference/packages/manual-com-unity-behavior.md) — Behavior package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.behavior.html
84. [how-to-build-animator-controllers.md](../reference/scripting/how-to-build-animator-controllers.md) — Tips for building animator controllers in Unity — https://unity.com/how-to/build-animator-controllers
85. [manual-animationoverview.md](../reference/scripting/manual-animationoverview.md) — Introduction to Mecanim Animation system — https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationOverview.html
86. [scriptref-animator-stringtohash.md](../reference/scripting/scriptref-animator-stringtohash.md) — Animator.StringToHash — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Animator.StringToHash.html
87. [manual-animationparameters.md](../reference/scripting/manual-animationparameters.md) — Animation Parameters — https://docs.unity3d.com/6000.3/Documentation/Manual/AnimationParameters.html
88. [manual-class-animator.md](../reference/scripting/manual-class-animator.md) — Animator component — https://docs.unity3d.com/6000.3/Documentation/Manual/class-Animator.html
89. [manual-rootmotion.md](../reference/scripting/manual-rootmotion.md) — How Root Motion works — https://docs.unity3d.com/6000.3/Documentation/Manual/RootMotion.html
90. [manual-audiooverview.md](../reference/scripting/manual-audiooverview.md) — Audio overview — https://docs.unity3d.com/6000.3/Documentation/Manual/AudioOverview.html
91. [manual-audiosource-overview.md](../reference/scripting/manual-audiosource-overview.md) — Introduction to the Audio Source component — https://docs.unity3d.com/6000.3/Documentation/Manual/AudioSource-overview.html
92. [manual-audiomixeroverview.md](../reference/scripting/manual-audiomixeroverview.md) — Introduction to the Audio Mixer — https://docs.unity3d.com/6000.3/Documentation/Manual/AudioMixerOverview.html
93. [scriptref-audio-audiomixer-setfloat.md](../reference/scripting/scriptref-audio-audiomixer-setfloat.md) — AudioMixer.SetFloat — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.AudioMixer.SetFloat.html
94. [scriptref-audiosource-playoneshot.md](../reference/scripting/scriptref-audiosource-playoneshot.md) — AudioSource.PlayOneShot — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AudioSource.PlayOneShot.html
95. [manual-com-unity-addressables.md](../reference/packages/manual-com-unity-addressables.md) — Addressables package page (6000.3) — https://docs.unity3d.com/6000.3/Documentation/Manual/com.unity.addressables.html
96. [addressables-2-9-addressableassetsoverview.md](../reference/packages/addressables-2-9-addressableassetsoverview.md) — Addressables introduction — https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/AddressableAssetsOverview.html
97. [addressables-2-9-asset-reference-intro.md](../reference/packages/addressables-2-9-asset-reference-intro.md) — Introduction to asset references — https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/asset-reference-intro.html
98. [addressables-2-9-load-addressable-assets.md](../reference/packages/addressables-2-9-load-addressable-assets.md) — Introduction to loading Addressable assets — https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/load-addressable-assets.html
99. [addressables-2-9-unloadingaddressableassets.md](../reference/packages/addressables-2-9-unloadingaddressableassets.md) — Unload Addressable assets — https://docs.unity3d.com/Packages/com.unity.addressables@2.9/manual/UnloadingAddressableAssets.html
100. [probuilder-6-1-index.md](../reference/packages/probuilder-6-1-index.md) — About ProBuilder — https://docs.unity3d.com/Packages/com.unity.probuilder@6.1/manual/index.html
101. [timeline-1-8-index.md](../reference/packages/timeline-1-8-index.md) — Unity's Timeline — https://docs.unity3d.com/Packages/com.unity.timeline@1.8/manual/index.html
102. [en-us-multiplayer-center.md](../reference/packages/en-us-multiplayer-center.md) — Get started with the Multiplayer Center — https://docs.unity.com/en-us/multiplayer/multiplayer-center
103. CinemachineVirtualCameraBase API (live, not downloaded) — https://docs.unity3d.com/Packages/com.unity.cinemachine@3.1/api/Unity.Cinemachine.CinemachineVirtualCameraBase.html — verified 2026-08-23 for `Priority` (type `PrioritySettings`) and `Prioritize()`.
104. QueryTriggerInteraction enum (live, not downloaded) — https://docs.unity3d.com/6000.3/Documentation/ScriptReference/QueryTriggerInteraction.html — verified 2026-08-23 for members `UseGlobal`, `Ignore`, `Collide`.
105. [inputsystem-1-20-quick-start-guide.md](../reference/packages/inputsystem-1-20-quick-start-guide.md) — Input System - Quick start guide — https://docs.unity3d.com/Packages/com.unity.inputsystem@1.20/manual/quick-start-guide.html
