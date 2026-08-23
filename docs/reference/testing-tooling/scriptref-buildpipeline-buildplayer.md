---
title: "BuildPipeline.BuildPlayer (Scripting API)"
page_title: "Unity - Scripting API: BuildPipeline.BuildPlayer"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.BuildPlayer.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.BuildPlayer.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# [BuildPipeline](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.html).BuildPlayer

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

public static [Build.Reporting.BuildReport](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Reporting.BuildReport.html) <span class="sig-kw">BuildPlayer</span>([BuildPlayerOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions.html) <span class="sig-kw">buildPlayerOptions</span>);

### Parameters

| Parameter          | Description                                                                                                                                                                   |
|--------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| buildPlayerOptions | Provide various options to control the behavior of [BuildPipeline.BuildPlayer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.BuildPlayer.html). |

### Returns

**BuildReport** A [BuildReport](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Reporting.BuildReport.html) object containing build process information.

### Description

Builds a player.

Use this function to programatically create a build of your project.  
  
Calling this method will invalidate any variables in the editor script that reference GameObjects, so they will need to be reacquired after the call.  
  
Scripts can run at strategic points during the build by implementing one of the supported callback interfaces, for example [BuildPlayerProcessor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.BuildPlayerProcessor.html), [IPreprocessBuildWithContext](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPreprocessBuildWithContext.html), [IProcessSceneWithReport](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IProcessSceneWithReport.html) and [IPostprocessBuildWithContext](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IPostprocessBuildWithContext.html).  
  
Note: Be aware that changes to [scripting symbols](https://docs.unity3d.com/6000.3/Documentation/Manual/platform-dependent-compilation.html) only take effect at the next domain reload, when scripts are recompiled.  
  
This means if you make changes to the defined scripting symbols via code using PlayerSettings.SetDefineSymbolsForGroup without a domain reload before calling this function, those changes won't take effect.  
  
It also means that the built-in scripting symbols defined for the current active target platform (such as UNITY_STANDALONE_WIN, or UNITY_ANDROID) remain in place even if you try to build for a different target platform, which can result in the wrong code being compiled into your build.  
  
Additional resources: [BuildPlayerWindow.DefaultBuildMethods.BuildPlayer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerWindow.DefaultBuildMethods.BuildPlayer.html).

``` codeExampleCS
using UnityEditor;
using UnityEngine;
using UnityEditor.Build.Reporting;

// Output the build size or a failure depending on BuildPlayer.

public class BuildPlayerExample
{
    [MenuItem("Build/Build iOS")]
    public static void MyBuild()
    {
        BuildPlayerOptions buildPlayerOptions = new BuildPlayerOptions();
        buildPlayerOptions.scenes = new[] { "Assets/Scene1.unity", "Assets/Scene2.unity" };
        buildPlayerOptions.locationPathName = "iOSBuild";
        buildPlayerOptions.target = BuildTarget.iOS;
        buildPlayerOptions.options = BuildOptions.None;

        BuildReport report = BuildPipeline.BuildPlayer(buildPlayerOptions);
        BuildSummary summary = report.summary;

        if (summary.result == BuildResult.Succeeded)
        
        if (summary.result == BuildResult.Failed)
        
    }
}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static [Build.Reporting.BuildReport](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Reporting.BuildReport.html) <span class="sig-kw">BuildPlayer</span>([BuildPlayerWithProfileOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerWithProfileOptions.html) <span class="sig-kw">buildPlayerWithProfileOptions</span>);

### Parameters

| Parameter                     | Description                                                                                                                                                                                                                                                                                               |
|-------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| buildPlayerWithProfileOptions | Provide various options to control the behavior of [BuildPipeline.BuildPlayer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPipeline.BuildPlayer.html) when using a [build profile](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Profile.BuildProfile.html). |

### Returns

**BuildReport** A [BuildReport](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Reporting.BuildReport.html) object containing build process information.

### Description

Builds a player from a specific build profile.

``` codeExampleCS
using UnityEditor;
using UnityEditor.Build.Reporting;
using UnityEditor.Build.Profile;
using UnityEngine;

public class BuildPlayerWithBuildProfileExample
{
    [MenuItem("Build/Build iOS Demo")]
    public static void MyBuild()
    {
        BuildProfile buildProfile = AssetDatabase.LoadAssetAtPath<BuildProfile>("Assets/Settings/Build Profiles/iOSDemo.asset");
        BuildPlayerWithProfileOptions options = new BuildPlayerWithProfileOptions()
        {
            buildProfile = buildProfile,
            locationPathName = "iOSDemoBuild",
            options = BuildOptions.None,
        };

        BuildReport report = BuildPipeline.BuildPlayer(options);
        BuildSummary summary = report.summary;

        // Output the build size or a failure depending on BuildPlayer.
        if (summary.result == BuildResult.Succeeded)
        
        if (summary.result == BuildResult.Failed)
        
    }
}
```

------------------------------------------------------------------------

<span style="color:red;"> </span>

## Declaration

public static [Build.Reporting.BuildReport](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Reporting.BuildReport.html) <span class="sig-kw">BuildPlayer</span>(string\[\] <span class="sig-kw">levels</span>, string <span class="sig-kw">locationPathName</span>, [BuildTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildTarget.html) <span class="sig-kw">target</span>, [BuildOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.html) <span class="sig-kw">options</span>);

<span style="color:red;"> </span>

## Declaration

public static [Build.Reporting.BuildReport](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Reporting.BuildReport.html) <span class="sig-kw">BuildPlayer</span>(EditorBuildSettingsScene\[\] <span class="sig-kw">levels</span>, string <span class="sig-kw">locationPathName</span>, [BuildTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildTarget.html) <span class="sig-kw">target</span>, [BuildOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.html) <span class="sig-kw">options</span>);

### Parameters

| Parameter        | Description                                                                                                                                                                                                                                                  |
|------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| levels           | The scenes to include in the build. If empty, the build includes only the current open scene. Paths are relative to the project folder, for example `Assets/MyLevels/MyScene.unity`.                                                                         |
| locationPathName | The path where the application will be built. For information on the platform extensions to include in the path, refer to [Build path requirements for target platforms](https://docs.unity3d.com/6000.3/Documentation/Manual/build-path-requirements.html). |
| target           | The [BuildTarget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildTarget.html) to build.                                                                                                                                                  |
| options          | Additional [BuildOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildOptions.html), like whether to run the built player.                                                                                                            |

### Returns

**BuildReport** A [BuildReport](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.Reporting.BuildReport.html) object containing build process information.

### Description

Builds a Player. These overloads are still supported, but will be replaced. Please use BuildPlayer([BuildPlayerOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerOptions.html) buildPlayerOptions) and BuildPlayer([BuildPlayerWithProfileOptions](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/BuildPlayerWithProfileOptions.html) buildPlayerWithProfileOptions) instead.
