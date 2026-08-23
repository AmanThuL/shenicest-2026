---
title: "Unity Manual 6.3 LTS: Smart merge (UnityYAMLMerge)"
page_title: "Unity - Manual: Smart merge"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/SmartMerge.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/SmartMerge.html"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Smart merge

Use the **UnityYAMLMerge** tool to merge scene and prefab files in a semantically correct way. The tool can be accessed from the command line and is also available to third-party version control software.

## Setting up smart merging in Unity

In the Version Control project settings (menu: **Edit** \> **Project Settings** \> **Version Control**), when you select a third-party version control tool in the **Mode** field, for example Perforce or Unity Version Control (UVCS), the **Smart Merge** is displayed. The menu has the following options:

-   **Off**: use only the default merge tool set in the preferences with no smart merging.
-   **Premerge**: enable smart merging, accept clean merges. Unclean merges will create premerged versions of base, theirs and mine versions of the file. Then, use these with the default merge tool.
-   **Ask**: enable smart merging but when a conflict occurs, show a dialog to let the user resolve it (this is the default setting).

## Setting up UnityYAMLMerge for use with third-party tools

The UnityYAMLMerge tool is included with the Unity Editor. Assuming Unity is installed in the standard location, the path to UnityYAMLMerge is as follows:

On Windows:

``` lang-shell
C:\Program Files\Unity\Editor\Data\Tools\UnityYAMLMerge.exe
```

Or

``` lang-shell
C:\Program Files (x86)\Unity\Editor\Data\Tools\UnityYAMLMerge.exe
```

On macOS:

``` lang-shell
/Applications/Unity/Unity.app/Contents/Helpers/UnityYAMLMerge
```

To access this folder from the Finder, right-click the `Unity.app` and select the `Show Package Contents` option.

UnityYAMLMerge is shipped with a default fallback file (called mergespecfile.txt, also in the Tools folder) that specifies how it should proceed with unresolved conflicts or unknown files. This also allows you to use it as the main merge tool for version control systems (such as git) that don’t automatically select merge tools based on file extensions. The most common tools are already listed by default in mergespecfile.txt but you can edit this file to add new tools or change options.

You can run UnityYAMLMerge as a standalone tool from the command line (you can see full usage instructions by running it without any arguments). Setup instructions for common version control systems are as follows:

### P4V

1.  Go to Preferences > Merge.
2.  Select *Other application*.
3.  Click the *Add* button.
4.  In the extension field, type `.unity`.
5.  In the Application field, type the path to the UnityYAMLMerge tool (see above).
6.  In the Arguments field, type `merge -p %b %1 %2 %r`
7.  Click Save.

Then, follow the same procedure to add the `.prefab` extension.

### Git

Add the following text to your `.git` or `.gitconfig` file:

``` lang-git
    [merge]
    tool = unityyamlmerge

    [mergetool "unityyamlmerge"]
    trustExitCode = false
    cmd = '<path to UnityYAMLMerge>' merge -p "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
```

### Mercurial

Add the following text to your `.hgrc` file:

``` lang-git
    [merge-patterns]
    **.unity = unityyamlmerge
    **.prefab = unityyamlmerge

    [merge-tools]
    unityyamlmerge.executable = <path to UnityYAMLMerge>
    unityyamlmerge.args = merge -p --force $base $other $local $output
    unityyamlmerge.checkprompt = True
    unityyamlmerge.premerge = False
    unityyamlmerge.binary = False
```

### SVN

Add the following to your `~/.subversion/config` file:

``` lang-git
    [helpers]
    merge-tool-cmd = <path to UnityYAMLMerge>
```

### TortoiseGit

1.  Go to Preferences > Diff Viewer > Merge Tool and click the **Advanced** button.
2.  In the popup, type `.unity` in the extension field.
3.  In the **External Program** field type:

``` lang-git
    <path to UnityYAMLMerge> merge -p %base %theirs %mine %merged
```

Then, follow the same procedure to add the `.prefab` extension.

### Unity Version Control (UVCS)

1.  Go to Preferences > Merge Tools and click the **Add** button.
2.  Select **External** merge tool.
3.  Select **Use with files that match the following pattern**.
4.  Add the `.unity` extension.
5.  Enter the command:

``` lang-git
    <path to UnityYAMLMerge> merge -p "@basefile" "@sourcefile"  "@destinationfile" "@output"
```

Then, follow the same procedure to add the `.prefab` extension.

### SourceTree

1.  Go to Tools > Options > Diff.
2.  Select **Custom** in the Merge Tool dropdown.
3.  Type the path to UnityYAMLMerge in the **Merge Command** field.
4.  Type `merge -p $BASE $REMOTE $LOCAL $MERGED` in the **Arguments** field.

## Configuring mergerules.txt

To customize how UnityYAMLMerge merges files, configure the mergerules.txt file. This is available in the `Editor/Data/Tools` folder of your Unity installation. The various configuration options are as follows.

### Arrays

The arrays configuration section tells UnityYAMLMerge to treat the specified path as an array; either as a “set” with a key value, or as a “plain” array without key values. The default for all arrays is to do a hybrid mode and try to match with some known heuristics.

-   \<mode> is one of “set” or “plain”

#### Example (as per default mergerules file)

``` lang-git
[arrays]
set *.GameObject.m_Component *.fileID
set *.Prefab.m_Modification.m_Modifications target.fileID target.guid propertyPath
plain *.MeshRenderer.m_Materials
plain *.Renderer.m_Materials
```

### Exclusions

The exclusions configuration section indicates which paths to exclude from merging. If both sides have been modified, they are then treated as a conflict and will show up for user input.

-   \<mode> is one of “include”, “exclude”, “includeIfContains”, “excludeIfContains”

#### Example (as per default mergerules file)

``` lang-git
[exclusions]
exclude *.MeshRenderer.m_Materials.*
exclude *.SpriteRenderer.m_Materials
exclude *.SpriteRenderer.m_Color
include *.ParticleSystem.InitialModule
exclude *.ParticleSystem.*
exclude *.ParticleSystem.InitialModule.*
#excludeDepend *.MonoBehaviour m_Script ^m_
excludeIfContains *.MonoBehaviour.* x y z
excludeIfContains *.MonoBehaviour.* r g b
```

### Arguments

The `--nomappinginoneline` argument is similar to the `EditorSettings.serializeInlineMappingsOnOneLine` API in Unity.

To disable single-line format, include this argument when you run the merge tool. When the `--nomappinginoneline` option is active, the tool attempts to split YAML data across multiple lines whenever a line exceeds 80 characters.

This argument helps to maintain consistency between the Unity generated file and the mergetool generated file.

### Comparisons

The comparisons section takes into account negligible differences between float values to ignore per user settings. When enabled, floating point comparison is done relatively to account for relative error. You can configure comparison in the following ways:

-   “float” \<float value to compare> (This sets epsilon to a default value close to machine epsilon)
-   “float” \<float value to compare> \<relative comparison value and absolute cutoff>
-   “float” \<float value to compare> \<relative comparison value> \<absolute comparison cutoff>

The relative comparison value determines epsilon and how comparison will scale with the size of the floats’ relative error. The absolute comparison cutoff determines at which point float comparison switches from absolute to relative from zero (on a graph).

**Note**: Comparison values should be between float epsilon (\~0.00000011921) and 1.0

#### Example

``` lang-git
[comparisons]
float *.Transform.m_LocalPosition.x 0.0000005
float *.Transform.m_LocalPosition.y 0.0000005
float *.Transform.m_LocalPosition.z 0.0000005
float *.Transform.m_LocalRotation.x 0.00005 0.001
float *.Transform.m_LocalRotation.y
float *.Transform.m_LocalRotation.z 0.00005 0.001
float *.Transform.m_LocalRotation.w
```

## Additional resources

-   [YAML serialization of prefabs](https://docs.unity3d.com/6000.3/Documentation/Manual/yaml-prefab-serialization.html)
-   [Format of text serialized files](https://docs.unity3d.com/6000.3/Documentation/Manual/FormatDescription.html)
-   [An example of a YAML scene file](https://docs.unity3d.com/6000.3/Documentation/Manual/YAMLSceneExample.html)
-   [Version control](https://docs.unity3d.com/6000.3/Documentation/Manual/VersionControl.html)
