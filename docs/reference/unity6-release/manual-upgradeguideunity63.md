---
title: "Upgrade to Unity 6.3"
page_title: "Unity - Manual: Upgrade to Unity 6.3"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html"
topic: "unity6-release"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Upgrade to Unity 6.3

This page lists changes in Unity 6.3 (6000.3) that can affect existing projects when you upgrade them from Unity 6.2 (6000.2) to Unity 6.3 (6000.3).

Review changes for Unity 6.3 in these areas:

-   [Accessibility](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#accessibility)
-   [Advertisement Legacy](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#advertisement-legacy)
-   [Editor and workflow](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#editor-and-workflow)
-   [Entities](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#entities)
-   [Graphics](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#graphics)
-   [Multiplayer](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#multiplayer)
-   [Optimization](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#optimization)
-   [Package Manager](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#packman)
-   [Platforms](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#platforms)
-   [Programming](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#programming)
-   [UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#ui-toolkit)
-   [XR](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuideUnity63.html#xr)

## Accessibility <span id="accessibility"></span>

This section outlines recent updates to accessibility APIs that can affect your upgrade experience.

### AccessibilityRole enum conversion

[`AccessibilityRole`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AccessibilityRole.html) has converted from a flags enum to a standard enum. This conversion creates consistent and predictable API behavior across the platforms supported by the screen reader API: Android, iOS, Windows, and macOS. Existing code that combines roles or performs bitwise operations on values in this enum can result in compiler warnings, and cause incorrect screen reader announcements or behaviors.

To resolve these warnings and ensure intended screen reader behavior in your upgraded project, make sure to set only one [`AccessibilityRole`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AccessibilityRole.html) for [`AccessibilityNode.role`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AccessibilityNode-role.html) and remove any bitwise operations on values in this enum.

### AccessibilityRole and AccessibilityState type change

The underlying type of the [`AccessibilityRole`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AccessibilityRole.html) and [`AccessibilityState`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AccessibilityState.html) enumerations has changed from `int` to `byte` to reduce the memory footprint of [`AccessibilityNode`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Accessibility.AccessibilityNode.html) objects. Any code that depends on the size of these enums or the size of types with fields of these enums (for example, serialization systems), or any precompiled code built against the old `int`-based enum definitions will throw exceptions or result in unexpected behaviors.

To resolve these issues in your upgraded Unity project, recompile any code built against the old `int`-based enum definitions, and make sure that any code that depends on the size of these enums handles their new size correctly.

### AccessibilityNode.selected deprecation

`AccessibilityNode.selected` was renamed to `AccessibilityNode.invoked`. `AccessibilityNode.selected` is now deprecated. If you don’t automatically update deprecated APIs when you upgrade your project, it can still compile. However, `AccessibilityNode.selected` will be obsolete in a future release.

## Advertisement Legacy <span id="advertisement-legacy"></span>

To ensure effective monetization performance and avoid potential upgrade blockers, migrate to the Ads Mediation (Unity LevelPlay) package, the supported and default solution for integrating ads in Unity. Refer to the [Unity LevelPlay integration guides](https://docs.unity.com/en-us/grow/levelplay/sdk) for more information.

Advertisers are recommended to upgrade directly to Unity Ads SDK version 4.16.4.

## Editor and workflow <span id="editor-and-workflow"></span>

This section outlines recent updates to the Unity Editor and its general workflows that can affect your upgrade experience.

### Search Index Manager removal

The Search Index Manager (**Windows** \> **Search** \> **Index Manager**) is now removed. If you want to customize Search indexing, go to **Preferences** \> **Search** \> **Indexing** instead.

In the Indexing preferences window, there are now two options for indexing:

-   **Index on Editor startup**: When enabled, indexing starts automatically in background `AssetWorker` processes as soon as the Editor launches. When disabled, indexing only occurs the first time any Search API or tool is used. This option is enabled by default.
-   **Deep scene and prefab indexing**: Indexes the full content of scenes and prefabs. This process is longer than normal indexing. This option is disabled by default.

## Entities <span id="entities"></span>

This section outlines recent updates to Entities that can affect your upgrade experience.

### UnityEngine.Experimental.GlobalIllumination namespace type changes

The type of the following fields has changed from `int` to `EntityId`:

-   `UnityEngine.Experimental.GlobalIllumination.Cookie.instanceID`
-   `UnityEngine.Experimental.GlobalIllumination.DirectionalLight.instanceID`
-   `UnityEngine.Experimental.GlobalIllumination.DiscLight.instanceID`
-   `UnityEngine.Experimental.GlobalIllumination.LightDataGI.cookieID`
-   `UnityEngine.Experimental.GlobalIllumination.LightDataGI.instanceID`
-   `UnityEngine.Experimental.GlobalIllumination.PointLight.instanceID`
-   `UnityEngine.Experimental.GlobalIllumination.RectangleLight.instanceID`
-   `UnityEngine.Experimental.GlobalIllumination.SpotLightBoxShape.instanceID`
-   `UnityEngine.Experimental.GlobalIllumination.SpotLightPyramidShape.instanceID`

Except for `cookieID`, the fields have also been renamed to `entityID`. The original `instanceID` is kept as a forwarding property for backward compatibility.

The `EntityId` type is implicitly convertible to and from `int`, so C# scripts will continue to work without modification.

However, if you have a precompiled assembly (a .dll) in your project that is using any of these fields, you might encounter `MissingFieldException` errors from that assembly. To resolve these errors, recompile the assembly against the latest `UnityEngine.dll`. Source code changes aren’t required. If the assembly is from a third party and you don’t have access to its source code, contact the vendor for an updated build that targets the latest Unity version.

### Scene.handle type change

The type of `UnityEngine.SceneManagement.Scene.handle` has changed from `int` to `SceneHandle`.

If you’re using `Scene.handle` in your code, the `SceneHandle` type is implicitly convertible to and from `int`, so C# scripts will continue to work without modification.

However, if you have a precompiled assembly (a .dll) in your project that is using any of these fields, you might encounter `MissingFieldException` errors from that assembly. To resolve these errors, recompile the assembly against the latest `UnityEngine.dll`. Source code changes aren’t required. If the assembly is from a third party and you don’t have access to its source code, contact the vendor for an updated build that targets the latest Unity version.

## Graphics <span id="graphics"></span>

This section outlines recent updates to Unity’s graphics systems that can affect your upgrade experience.

### URP Compatibility Mode removal

Universal Render Pipeline [Compatibility Mode](https://docs.unity3d.com/6000.0/Documentation/Manual/urp/compatibility-mode.html) was deprecated in Unity 6.0 and is now removed. The code is stripped by default to improve compilation time and reduce the build size.

The [RenderGraphSettings.enableRenderCompatibilityMode](https://docs.unity3d.com/Packages/com.unity.render-pipelines.universal@17.3/api/UnityEngine.Rendering.Universal.RenderGraphSettings.html#UnityEngine_Rendering_Universal_RenderGraphSettings_enableRenderCompatibilityMode) property is now read-only (returning `false`). If you’re still using Compatibility Mode, first convert your project to URP Render Graph and use Unity 6.0, 6.1, or 6.2. Shipping a project with Compatibility Mode is not recommended and not supported.

You can use the `URP_COMPATIBILITY_MODE` scripting define symbol in Player settings to add Compatibility Mode back to the code. Use this only to convert the project. This scripting define will no longer work in Unity 6.4.

### Legacy ETC compressor removal

The Legacy ETC compression mode is now removed. Projects that use Legacy ETC compression will be automatically updated to use the default ETC compressor configuration.

The compressors used by this configuration generally have a higher quality encoding. This means that compressed textures might not be pixel-identical to their previous versions due to differences in coding artifacts. However, these changes don’t impact their size on disk or memory usage.

If you want the closest match to the Legacy ETC compression behavior, go to **Project Settings** \> **Editor**. In **Texture Compressors**, set **ETC Compressor** to **Custom** and do the following:

-   Set **Fast** to **ETCPACK Fast**.
-   Set **Normal** to **ETCPACK Normal**.
-   Set **Best** to **ETCPACK Best**.

### Experimental lightmapping API removal

The experimental `AdditionalBakedProbes` API is now removed and the experimental `CustomBake` API is obsolete. If you need to compute data for custom light probe positions, use the [`LightTransport.IProbeIntegrator`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/LightTransport.IProbeIntegrator.html) API instead.

**Note**: The experimental sky occlusion system in `CustomBake` applied only to probes and didn’t affect lightmaps.

## Multiplayer <span id="multiplayer"></span>

This section outlines recent updates to multiplayer packages and services that can affect your upgrade experience.

### Netcode for GameObjects 1.X deprecation

Netcode for GameObjects 1.X is now deprecated and replaced by the 2.X version. When you update your project, consider the following:

-   The method `NetworkTransform.Update` can no longer be overridden for performance reasons. `NetworkTransform.Update` is now replaced by a new `NetworkTransform.OnUpdate` method, which is only invoked on non-authority instances.
-   If you previously overrode `NetworkTransform.Update` to gain more control over non-authority `NetworkTransform` instances (for example, to customize the way `NetworkTransform` instance positions interpolate between updates), you must override `NetworkTransform.OnUpdate` instead.
-   If you previously overrode `NetworkTransform.Update` to add logic for authority instances, it’s recommended to make a new class (such as a `NetworkBehaviour`) implementing `INetworkUpdateSystem` and then register or unregister it with the `NetworkUpdateLoop` when gaining and losing authority.

### Multiplay Hosting removal

[Multiplay Hosting](https://docs.unity.com/ugs/en-us/manual/game-server-hosting/manual/welcome-to-multiplay) is no longer supported in the Unity Editor and runtime. The service will continue to run through March 31, 2026, after which it will shut down.

#### Multiplayer Play Mode

The default version of the [Multiplayer Play Mode package](https://docs.unity3d.com/Packages/com.unity.multiplayer.playmode@2.0/manual/index.html) is now 2.0.1. This version removes the remote instances previously used as part of [Play Mode scenarios](https://docs.unity3d.com/Packages/com.unity.multiplayer.playmode@2.0/manual/play-mode-scenario/play-mode-scenario-create.html).

If you have Play Mode scenarios containing remote instances, you will encounter errors. To resolve these, do one of the following:

-   Remove any remote instances from the scenario before you upgrade to Unity 6.3.
-   Create new scenarios after you upgrade to Unity 6.3.

#### Multiplayer Services

The default version of the [Multiplayer Services package](https://docs.unity.com/ugs/en-us/manual/mps-sdk/manual) is now 2.0.0. This version removes all the functionalities related to Multiplay Hosting.

If you need to continue using Multiplay Hosting in your project until the shutdown date of March 31, 2026, do the following:

1.  Downgrade to Unity 6.0.
2.  Downgrade the Multiplayer Services package to 1.2.0.

If you’re no longer using Multiplay Hosting in your project, note the following:

-   If you use `UNITY_SERVER` or `ENABLE_UCS_SERVER` in scripting defines or through the Dedicated Server platform and attempt to call Multiplay Hosting-related functions, your project will not compile. To resolve this, remove all Multiplay Hosting-related references from your project.
-   You can still initially deploy Matchmaking Queue files (.mmq) created in v1.2.0. However, modifying an existing .mmq file will remove the Multiplay type, and subsequent deployment won’t update Multiplay Hosting-related features.
-   If you call the `Multiplayer Service Matchmake async` function with a Multiplay Queue, this will result in a **Not supported** error. To resolve this, use a non-Multiplay queue configuration.

## Optimization <span id="optimization"></span>

This section outlines recent updates to optimization in Unity that can affect your upgrade experience.

### Adaptive Performance moved to a core module

The core functionality of Adaptive Performance is now a module in the Unity Editor rather than a package. Refer to [What’s New in Unity 6.3](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html#optimization) for more information about the changes.

The upgrade action required depends on your project’s configuration:

-   Standard projects: If you used the default Adaptive Performance package without modifications, no action is required. Unity uses the new module automatically.
-   Modified packages: If you created a custom package by modifying the original, you must delete all code from the following folders to avoid compilation errors:
    -   `Editor`
    -   `Runtime` (except the `Visual Scripting` folder)
    -   `Tests`
-   Custom providers: No action is required unless you want to adopt the new [`ProviderSettingsEditor`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/AdaptivePerformance.Editor.ProviderSettingsEditor.html) APIs for your build profile settings or your provider’s UI uses `targetSelectionGrouping`.
    -   If you use `EditorGUILayout.BeginBuildTargetSelectionGrouping()` in combination with `DisplayBaseSettingsEnd()`, you now need to specify `EditorGUILayout.EndBuildTargetSelectionGrouping` separately because it’s no longer bundled with `DisplayBaseSettingsEnd()`.

## Package Manager <span id="packman"></span>

This section outlines recent updates to Package Manager tools and settings.

### UPM_NPM_CACHE_PATH environment variable is no longer supported

Previous versions of the Unity Editor supported use of the `UPM_NPM_CACHE_PATH` environment variable to specify the absolute path for Package Manager’s registry data cache.

You need to act only if you have automation scripts or pipelines that set path values in the `UPM_NPM_CACHE_PATH` environment variable. There’s no replacement for `UPM_NPM_CACHE_PATH`. However, you can use the `UPM_CACHE_ROOT` environment variable, which is the parent directory for `UPM_NPM_CACHE_PATH`. Use `UPM_CACHE_ROOT` instead of `UPM_NPM_CACHE_PATH` and adjust the values in your scripts or pipelines.

For more information, refer to [Customize the global cache](https://docs.unity3d.com/6000.3/Documentation/Manual/upm-config-cache.html).

## Platforms <span id="platforms"></span>

This section outlines recent updates to platform-specific tools and settings.

### Android

This section outlines recent updates to Android-specific tools and settings.

#### Icon deprecation

Deprecated support for the round and legacy icons. The recommended best practice is to use the adaptive icons. For more information, refer to [Icon in Android Player settings](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsAndroid.html#Icon).

#### Android 16 large screen behavior changes

Starting with Android 16, the Android operating system no longer enforces fixed orientation, resizability, and aspect ratio settings for applications running on large screen devices. This can change the way your app behaves on tablets, foldables, and other large displays.

Unity now provides a new [App Category](https://docs.unity3d.com/6000.3/Documentation/Manual/class-PlayerSettingsAndroid.html#Configuration) Player setting to help you keep the previous behavior for game applications. To make sure your project is exempt from these Android 16 changes and retains its configured orientation, resizability, and aspect ratio, set **App Category** to **Game**. The App Category Player setting replaces the obsolete [PlayerSettings.Android.androidIsGame](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PlayerSettings.Android-androidIsGame.html) API.

For more information, refer to [Android 16 behavior changes for large screen devices](https://docs.unity3d.com/6000.3/Documentation/Manual/android-large-screen-and-foldable-support.html#Android16).

#### Updated Android build tools

Android build tooling versions for Gradle and Android Gradle Plugin (AGP) are updated to ensure compatibility with the latest Android development tools. The updated versions are as follows:

| **Tool**   | **Previous version** | **Updated version** |
|:-----------|:---------------------|:--------------------|
| **Gradle** | 8.13                 | 9.1.0               |
| **AGP**    | 8.10.0               | 9.0.0               |

For an overview of the changes these updates introduce, refer to the [What’s new in Unity 6.3](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNewUnity63.html#platforms).

Unity automatically applies this update in most projects. You might need to make manual changes if any of the following apply:

-   Custom Gradle templates are enabled in **Player Settings** > **Publishing Settings** or your project includes `mainTemplate.gradle` or `launcherTemplate.gradle`.
-   Your project uses older third-party plug-ins that are not updated for Gradle and AGP updates.

To ensure a smooth transition, take the following actions, where applicable:

-   If you have **Custom Gradle Template** enabled, review your `.gradle` files for deprecated attributes. Unity displays a dialog on build when any deprecated attributes are detected and automatically renames them to use their newer versions.

-   Check for updates from third-party SDK providers, such as Ads and Analytics providers to ensure they support AGP 9.0.0.

-   For projects with custom logic in `.gradle` templates, make sure to review the deprecated APIs listed in the official [AGP release notes](https://developer.android.com/build/releases/agp-9-0-0-release-notes#:~:text=Deprecated%20API%20in%20the%20android%20block).

-   Configure unique namespaces for any custom Android plug-ins or libraries in your project. Set the namespace in either:

    -   `AndroidManifest.xml`: package=“com.example.library.unique”
    -   `build.gradle`: namespace “com.example.library.unique”

### Web

This section outlines recent updates to Unity Web that can affect your upgrade experience.

#### Facebook Instant Games platform deprecated

The [Facebook Instant Games platform](https://docs.unity3d.com/6000.3/Documentation/Manual/instant-games.html) has been deprecated and will be removed in a future release. The platform is no longer recommended for production. For more information, refer to [Deprecation Notice: Unity Support for Facebook Instant Games](https://discussions.unity.com/t/deprecation-notice-unity-support-for-facebook-instant-games).

To create Instant Games, use the [Web platform](https://docs.unity3d.com/6000.3/Documentation/Manual/webgl.html) instead.

## Programming <span id="programming"></span>

This section outlines recent updates to programming in Unity that can affect your upgrade experience.

### SerializeField attribute restriction to fields

The `[SerializeField]` attribute has been updated so that you can only apply it to fields. Applying it to properties, methods, types, or other code elements will now result in a compile-time error. This change helps ensure you use the attribute correctly, as it has no effect on non-field members.

Projects already using the attribute correctly will not be affected. Only projects which have misapplied the attribute will have compiler errors.

If you encounter a compile error, you can usually resolve it by removing the attribute from the affected member. If you encounter a compile error because you applied the attribute to an auto-implemented property when you intended to apply `[SerializeField]` to the backing field of an auto-implemented property, use the `[field: SerializeField]` syntax to apply it correctly.

For more information, refer to [`SerializeField`](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeField.html) and [Serialization rules](https://docs.unity3d.com/6000.3/Documentation/Manual/script-serialization-rules.html).

## UI Toolkit <span id="ui-toolkit"></span>

This section outlines recent updates to Unity’s UI Toolkit that can affect your upgrade experience.

### USS parser library upgrade

The UI Toolkit USS parser has been upgraded to improve error detection and validation. While these improvements increase accuracy, they might introduce minor breaking changes by flagging invalid USS that was previously overlooked or incorrectly processed. These behaviors aren’t new, but the upgraded parser is now better at identifying these issues.

You might encounter the following changes in behavior:

-   The upgraded parser is now better at detecting invalid or missing selectors that were previously ignored or incorrectly transformed. For example, single dots (`.`) in selectors were mistakenly converted into wildcards (`*`).

-   Syntax validation is now significantly improved. Errors such as missing or extra brackets, excessive semicolons, or other malformed USS syntax are now detected and reported.

-   Unsupported CSS features are now better detected, such as pseudo-element selectors or advanced CSS functionality not supported by UI Toolkit. Additionally, you can now configure error handling for unsupported CSS features through the **Unsupported Selector Action** field in the importer Inspector. You can adjust the behavior from the default error to a warning or choose to ignore the issue entirely.

If your USS file contains syntax errors, it will block the file from importing. To inspect the errors and warnings, you can review the file in the Inspector or go to the Console window. After you have resolved the errors, the file will import as normal.

## XR <span id="xr"></span>

This section outlines recent updates to XR that can affect your upgrade experience.

### Magic Leap deprecation

Support for the [Unity Magic Leap XR Plugin](https://docs.unity3d.com/Packages/com.unity.xr.magicleap@7.1/manual/index.html) is now deprecated, and support for the Magic Leap (`x86_64`) build target for new projects is now removed. In Unity 6.3 and later, support for Magic Leap is limited to existing projects. For more information about Magic Leap deprecation, refer to [Magic Leap support](https://docs.unity3d.com/6000.3/Documentation/Manual/xr-support-packages.html#magic-leap-support).

## Additional resources

-   [New in Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/WhatsNew.html)
-   [Upgrade Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/UpgradeGuides.html)
-   [System requirements](https://docs.unity3d.com/6000.3/Documentation/Manual/system-requirements.html)
-   [Install Unity](https://docs.unity3d.com/6000.3/Documentation/Manual/GettingStartedInstallingUnity.html)
-   [Upgrade your Unity project](https://docs.unity3d.com/6000.3/Documentation/Manual/upgrade-project.html)
