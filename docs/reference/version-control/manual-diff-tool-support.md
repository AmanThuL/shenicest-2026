---
title: "Unity Manual 6.3 LTS: Diff tool support"
page_title: "Unity - Manual: Diff tool support"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/diff-tool-support.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/diff-tool-support.html"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Diff tool support

You can use the [**Revision Control Diff/Merge** setting](https://docs.unity3d.com/6000.3/Documentation/Manual/preferences-external-tools.html) to set an installed diff tool as the default revision tool. You can also use this setting to define a custom revision tool with specific layouts.

If you want to change the diff tool that Unity uses, open the [Preferences](https://docs.unity3d.com/6000.3/Documentation/Manual/Preferences.html) window, and navigate to the **External Tools** section. Select your preferred tool from the **Revision Control Diff/Merge** dropdown list.

## Set up a custom revision tool

To set up a custom revision tool, follow these steps:

1.  Open the [Preferences](https://docs.unity3d.com/6000.3/Documentation/Manual/Preferences.html) window, and navigate to the **External Tools** section.
2.  In the **Revision Control Diff/Merge** dropdown list, select **Custom Tool**.
3.  Enter the path to the custom tool’s installation folder. On macOS, this should point to the *Contents / MacOS* folder in the tool’s installation folder.
4.  Enter the arguments for two-way diffs, three-way diffs, and merges.

To specify file layout in the revision tool, use these arguments:

| **Property**   | **Function**                       |
|:---------------|:-----------------------------------|
| `#LTITLE`      | Left title                         |
| `#RTITLE`      | Right title                        |
| `#ATITLE`      | Ancestor title                     |
| `#LEFT`        | Left file                          |
| `#RIGHT`       | Right file                         |
| `#ANCESTOR`    | Ancestor file                      |
| `#OUTPUT`      | Output file                        |
| `#ABSLEFT`     | Absolute path to the left file     |
| `#ABSRIGHT`    | Absolute path to the right file    |
| `#ABSANCESTOR` | Absolute path to the ancestor file |
| `#ABSOUTPUT`   | Absolute path to the output file   |

Examples:

![SourceGear DiffMerge](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/SourceGearDiffMerge.png)

![P4Merge](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/P4DiffMerge.png)

## Additional resources

-   [Preferences reference](https://docs.unity3d.com/6000.3/Documentation/Manual/Preferences.html)
-   [Version control integrations](https://docs.unity3d.com/6000.3/Documentation/Manual/Versioncontrolintegration.html)
