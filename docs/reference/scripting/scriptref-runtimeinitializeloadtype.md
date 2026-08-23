---
title: "Scripting API: RuntimeInitializeLoadType"
page_title: "Unity - Scripting API: RuntimeInitializeLoadType"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# RuntimeInitializeLoadType

enumeration

<span id="scrollToFeedback">Leave feedback</span>

<span class="blue-btn sbtn">Suggest a change</span>

## Success!

Thank you for helping us improve the quality of Unity Documentation. Although we cannot accept all submissions, we do read each suggested change from our users and will make updates where applicable.

<span class="gray-btn sbtn close">Close</span>

## Submission failed

For some reason your suggested change could not be submitted. Please \<a>try again\</a> in a few minutes. And thank you for taking the time to help us improve the quality of Unity Documentation.

<span class="gray-btn sbtn close">Close</span>

Your name Your email Suggestion<span class="r">\*</span>

Submit suggestion

<span class="cancel left lh42 cn">Cancel</span>

<span style="color:red;"> </span>

### Description

Specifies when to get a callback during the startup of the runtime or when entering play mode in the Editor. Used with [RuntimeInitializeOnLoadMethodAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeOnLoadMethodAttribute.html).

See the [RuntimeInitializeOnLoadMethodAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeOnLoadMethodAttribute.html) documentation for the execution order between the various options.

### Properties

| Property                                                                                                                                    | Description                                                                                                                                                 |
|---------------------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [AfterSceneLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.AfterSceneLoad.html)               | Callback invoked when the first scene's objects are loaded into memory and after Awake has been called.                                                     |
| [BeforeSceneLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.BeforeSceneLoad.html)             | Callback invoked when the first scene's objects are loaded into memory but before Awake has been called.                                                    |
| [AfterAssembliesLoaded](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.AfterAssembliesLoaded.html) | Callback invoked when all assemblies are loaded and preloaded assets are initialized. At this time the objects of the first scene have not been loaded yet. |
| [BeforeSplashScreen](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.BeforeSplashScreen.html)       | Callback invoked before the splash screen is shown. At this time the objects of the first scene have not been loaded yet.                                   |
| [SubsystemRegistration](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RuntimeInitializeLoadType.SubsystemRegistration.html) | Callback invoked when starting up the runtime. Called before the first scene is loaded.                                                                     |
