---
title: "Scripting API: Build.IPreprocessBuildWithReport"
page_title: "Unity - Scripting API: IPreprocessBuildWithReport"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPreprocessBuildWithReport.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPreprocessBuildWithReport.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# IPreprocessBuildWithReport

interface in UnityEditor.Build

<span id="scrollToFeedback">Leave feedback</span>

  

Implements interfaces:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IOrderedCallback.html" class="cl">IOrderedCallback</a>

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

Implement this interface to execute code at the start of the Player build process.

This interface is replaced by [IPreprocessBuildWithContext](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPreprocessBuildWithContext.html), which works for AssetBundle builds as well.  
  
At the start of a Player build, Unity uses the [IOrderedCallback.callbackOrder](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IOrderedCallback-callbackOrder.html) property on each implementation to determine the order in which to invoke the callbacks.  
  
This callback can be useful for automated tasks and ensuring your build environment is correctly configured.  
  
Example usages include:

-   For validation checks, e.g. confirming required build settings, environmental variables, content or other project-specific conditions. When possible you can automatically fix problems by changing settings. Or you can fail the build, by throwing a BuildFailedException along with a clear error message.
-   To make sure required Assets are included in the build. See [PlayerSettings.SetPreloadedAssets](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerSettings.SetPreloadedAssets.html).
-   To generate version numbers, change logs, link.xml files or other content that should be regenerated prior to each Player build.
-   For logging, reporting or sending analytics.

Note: Build callbacks are a powerful feature, but it is strongly recommended that their implementations maintain deterministic build outputs. The result of a build should be predictable and reproducible, based on the project’s content, the Unity version, and installed packages. Introducing environment-specific behavior, external dependencies, randomness, or other non-deterministic elements can lead to outcomes that are challenging to debug or reproduce. This unpredictability may also compromise the efficiency and accuracy of incremental builds or incremental upgrades.  
  
Additional resources: [BuildPlayerProcessor.PrepareForBuild](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.BuildPlayerProcessor.PrepareForBuild.html), [IPostprocessBuildWithReport](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPostprocessBuildWithReport.html), [BuildPlayerProcessor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.BuildPlayerProcessor.html), [BuildPipeline.BuildPlayer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.BuildPlayer.html).

``` codeExampleCS
using System;
using UnityEditor.Build;
using UnityEditor.Build.Reporting;

class BuildScheduleEnforcer : IPreprocessBuildWithReport
{
    public int callbackOrder { get { return 100; } }
    public void OnPreprocessBuild(BuildReport report)
    
}
```

### Public Methods

| Method                                                                                                                                     | Description                                                              |
|--------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------|
| [OnPreprocessBuild](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPreprocessBuildWithReport.OnPreprocessBuild.html) | Implement this method to receive a callback before the build is started. |
