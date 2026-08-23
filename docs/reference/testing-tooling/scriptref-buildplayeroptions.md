---
title: "BuildPlayerOptions (Scripting API)"
page_title: "Unity - Scripting API: BuildPlayerOptions"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# BuildPlayerOptions

struct in UnityEditor

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

Provide various options to control the behavior of [BuildPipeline.BuildPlayer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.BuildPlayer.html).

Additional resources: [EditorBuildSettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/EditorBuildSettings.html), [BuildPlayerWindow.DefaultBuildMethods.GetBuildPlayerOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerWindow.DefaultBuildMethods.GetBuildPlayerOptions.html)

``` codeExampleCS
using UnityEditor;
using UnityEngine;

public class BuildPlayerOptionsExample

}
```

### Properties

| Property                                                                                                                                 | Description                                                                                                                                                                                                |
|------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [assetBundleManifestPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions-assetBundleManifestPath.html) | The path to an manifest file describing all of the asset bundles used in the build (optional).                                                                                                             |
| [extraScriptingDefines](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions-extraScriptingDefines.html)     | The additional preprocessor defines you can specify while compiling assemblies for the Player. These defines are appended to the existing Scripting Define Symbols list configured in the Player settings. |
| [locationPathName](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions-locationPathName.html)               | Specifies the path for the application to be built.                                                                                                                                                        |
| [options](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions-options.html)                                 | The BuildOptions flags to apply when building the Player.                                                                                                                                                  |
| [scenes](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions-scenes.html)                                   | The Scenes to be included in the build.                                                                                                                                                                    |
| [subtarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions-subtarget.html)                             | The Subtarget to build.                                                                                                                                                                                    |
| [target](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions-target.html)                                   | The BuildTarget to build.                                                                                                                                                                                  |
| [targetGroup](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions-targetGroup.html)                         | The BuildTargetGroup to build.                                                                                                                                                                             |
