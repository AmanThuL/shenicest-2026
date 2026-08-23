---
title: "Configure managed code stripping"
page_title: "Unity - Manual: Configure managed code stripping"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-configure.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-configure.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Configure managed code stripping

The **Managed Stripping Level** property determines which [rules](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-marking-rules.html) the Unity linker follows when it analyzes and strips your application’s code. Increasing the managed stripping level expands the scope of the linker’s search for unused code but also increases build time.

To change the **Managed Stripping Level** property:

1.  Go to **Edit** > **Project Settings** > **Player**.
2.  In **Other Settings**, navigate to the Optimization heading.
3.  Set the **Managed Stripping Level** property to the desired value.

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Function</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>Disabled</strong></td><td style="text-align: left;">Unity doesn’t remove any code.<br />
<br />
This setting is only available for the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends-mono.html">Mono scripting backend</a> and is the default setting in that case.</td></tr><tr class="even"><td style="text-align: left;"><strong>Minimal</strong></td><td style="text-align: left;">Unity searches only the <code>UnityEngine</code> and the .NET class libraries for unused code. Unity doesn’t remove any user-written code. This setting is the least likely to cause unexpected runtime behavior.<br />
<br />
This setting is useful for projects where usability is of higher priority than build size. This is the default setting if you use the <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/scripting-backends-il2cpp.html">IL2CPP scripting backend</a>.</td></tr><tr class="odd"><td style="text-align: left;"><strong>Low</strong></td><td style="text-align: left;">Unity searches for unused code in all <code>UnityEngine</code> and .NET class libraries. It also searches user-written assemblies, but only if none of their types are referenced in scenes included in the Player build. This setting applies a set of rules that removes some unused code but minimizes the likelihood of unintended consequences, such as changes in behavior of runtime code that uses reflection.<br />
<br />
<strong>Note</strong>: The <strong>Low</strong> managed stripping level is marked for future deprecation and using it is not recommended. Use <strong>Minimal</strong> or <strong>Medium</strong> instead.</td></tr><tr class="even"><td style="text-align: left;"><strong>Medium</strong></td><td style="text-align: left;">Unity partially searches all assemblies to find unused code. This setting applies a set of rules that strips more types of code patterns to reduce the build size. Although Unity doesn’t strip all possible unused code, this setting does increase the risk of undesirable or unexpected behavior changes.</td></tr><tr class="odd"><td style="text-align: left;"><strong>High</strong></td><td style="text-align: left;">Unity performs an extensive search of all assemblies to find unused code. At this setting, Unity prioritizes size reduction more than code stability and removes as much code as possible.<br />
<br />
This search can take much longer than for lower stripping levels. Use this setting only for projects where a compact build size is extremely important. Test your application thoroughly and make careful use of <code>[Preserve]</code> attributes and <code>link.xml</code> files to ensure that the Unity linker doesn’t strip vital code.</td></tr></tbody></table>

## Additional resources

-   [Managed code stripping and the Unity linker](https://docs.unity3d.com/6000.3/Documentation/Manual/unity-linker.html)
-   [Preserving code using annotations](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-preserving.html)
-   [Link XML formatting reference](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-xml-formatting.html)
-   [Unity linker marking rules reference](https://docs.unity3d.com/6000.3/Documentation/Manual/managed-code-stripping-marking-rules.html)
-   [IUnityLinkerProcessor.GenerateAdditionalLinkXmlFile](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Build.IUnityLinkerProcessor.GenerateAdditionalLinkXmlFile.html)
