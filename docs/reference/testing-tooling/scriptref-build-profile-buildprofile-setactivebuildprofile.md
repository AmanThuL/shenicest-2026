---
title: "BuildProfile.SetActiveBuildProfile (Scripting API)"
page_title: "Unity - Scripting API: Build.Profile.BuildProfile.SetActiveBuildProfile"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.SetActiveBuildProfile.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.SetActiveBuildProfile.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [BuildProfile](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.html).SetActiveBuildProfile

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

## Declaration

public static void <span class="sig-kw">SetActiveBuildProfile</span>([Build.Profile.BuildProfile](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.html) <span class="sig-kw">buildProfile</span>);

### Parameters

| Parameter    | Description                                                                                                                 |
|--------------|-----------------------------------------------------------------------------------------------------------------------------|
| buildProfile | The build profile to be set as the active build profile. When the value is null, Unity sets the platform profile as active. |

### Description

Sets the active build profile.

This method updates the active build profile in Unity. When you switch to a build profile that targets a non-active platform, this function reimports assets affected by the target platform settings and then returns. All script files will be compiled on the next Editor update.  
  
**Note:** This method isn't available to set build profiles that target a non-active platform when running the Editor in [batch mode](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html). Changing the platform requires recompiling script code for the given platform, which can't be done while script code is executing. This isn't a problem in the Editor as the operation is deferred to the next Editor update. However, in batch mode the Editor will stop after executing the designated script code, so deferring the operation isn't possible. To set a build profile that targets a non-active platform in batch mode, use the [activeBuildProfile](https://docs.unity3d.com/6000.3/Documentation/Manual/EditorCommandLineArguments.html) command-line argument.  
  
Additional resources: [Platform profile](https://docs.unity3d.com/6000.3/Documentation/Manual/build-profiles.html), [BuildProfile.GetActiveBuildProfile](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.GetActiveBuildProfile.html), [AssetDatabase.LoadAssetAtPath](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AssetDatabase.LoadAssetAtPath.html).

``` codeExampleCS
using UnityEditor;
using UnityEditor.Build.Profile;

public static class Builder
{
    [MenuItem("Build/Build Active Profile")]
    public static void BuildActiveProfile()
    {
        var options = new BuildPlayerWithProfileOptions
        {
            buildProfile = BuildProfile.GetActiveBuildProfile(),
            locationPathName = "Builds/MyBuild"
        };

        BuildPipeline.BuildPlayer(options);
    }

    [MenuItem("Build/Set macOS Build Profile")]
    public static void SetActiveBuildProfile()
    
}
```
