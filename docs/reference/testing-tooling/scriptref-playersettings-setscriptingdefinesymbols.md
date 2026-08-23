---
title: "PlayerSettings.SetScriptingDefineSymbols (Scripting API)"
page_title: "Unity - Scripting API: PlayerSettings.SetScriptingDefineSymbols"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerSettings.SetScriptingDefineSymbols.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerSettings.SetScriptingDefineSymbols.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [PlayerSettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerSettings.html).SetScriptingDefineSymbols

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

<a href="https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettings.html" class="switch-link gray-btn sbtn left show" title="Go to PlayerSettings Component in the Manual">Switch to Manual</a>

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">SetScriptingDefineSymbols</span>([Build.NamedBuildTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.NamedBuildTarget.html) <span class="sig-kw">buildTarget</span>, string <span class="sig-kw">defines</span>);

<span style="color:red;"> </span>

## Declaration

public static void <span class="sig-kw">SetScriptingDefineSymbols</span>([Build.NamedBuildTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.NamedBuildTarget.html) <span class="sig-kw">buildTarget</span>, string\[\] <span class="sig-kw">defines</span>);

### Parameters

| Parameter   | Description                                                                                                        |
|-------------|--------------------------------------------------------------------------------------------------------------------|
| buildTarget | The [NamedBuildTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.NamedBuildTarget.html). |
| defines     | Symbols for this build target are passed as an array or as a string separated by semicolons.                       |

### Description

Set user-specified symbols for script compilation for the given build target.

To see defines string values go to Edit \> Project Settings \> Player Settings \> Scripting Compilation \> Scripting Define Symbols.  
  
Additional resources: [Platform Dependent Compilation](https://docs.unity3d.com/6000.3/Documentation/Manual/platform-dependent-compilation.html).
