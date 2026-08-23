---
title: "Unity Learn: Working with YAMLMerge"
page_title: "Working with YAMLMerge"
source_url: "https://learn.unity.com/tutorial/working-with-yamlmerge"
final_url: "https://learn.unity.com/tutorial/working-with-yamlmerge"
topic: "version-control"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Working with YAMLMerge

![](https://learn.unity.com/_next/static/media/tutorial-coverImage-bg.8fcd34a7.jpeg)

# Working with YAMLMerge

Tutorial

advanced

+10XP

5m

71

\(132\)

Unity Technologies

![Working with YAMLMerge](https://connect-mediagw.unity.com/h1/20191205/learn/images/a53a81bd-9b13-42ea-82f2-b90bf07776d3_yaml.png)

Summary

YAMLMerge (*unityyamlmerge.exe*) is a tool that is included with the Unity Editor and works with version control software to merge Scene and Prefab files. In this workflow, we’ll configure Git to use YAMLMerge.

Languages available:

EnglishEnglish

<span id="react-aria-«R1ahmpmH7»">English</span><span class="pl-2"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 1. Working with YAMLMerge

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

This tutorial has been verified using Unity 2019.4.12f1 LTS

YAMLMerge (unityyamlmerge.exe) is a tool that is included with the Unity Editor and works with version control software to merge Scene and Prefab files. In this workflow, we’ll configure Git to use YAMLMerge. If you’d like to configure a different tool for use with YAMLMerge, please see <a href="https://docs.unity3d.com/Manual/SmartMerge.html" class="link-primary text-inherit"><span style="text-decoration:underline">the Unity Manual</span></a>. YAMLMerge can also be run directly from the command line.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 2. Configuring Git to use YAMLMerge

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

1\. Open your .gitconfig file. This is typically in your user/home directory.

2\. At the end, type:

```
[merge]
    tool = unityyamlmerge

[mergetool "unityyamlmerge"]
    trustExitCode = false
    cmd = 'C:\\Program Files\\Unity\\Hub\\Editor\\2019.2.11f1\\Editor\\Data\\Tools\\UnityYAMLMerge.exe' merge -p "$BASE" "$REMOTE" "$LOCAL" "$MERGED"
```

3\. The path to Unity will vary depending on your platform, version number, and whether you’ve installed Unity directly or through the hub.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 3. Configuring your Unity project

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

1\. From the Edit drop-down in the Unity Editor, select **Project Settings**.

2\. Click on **Editor**.

3\. Under Version Control, set Mode to **Visible Meta Files** if it’s not set already (**Figure 01**).

4\. Set Asset Serialization to **Force Text** if it’s not set already (**Figure 01**).

![](https://connect-mediagw.unity.com/h1/20201229/learn/images/01f6dff4-c236-41f3-9e88-89358b3a4fc4_image1.png)

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 4. Usage and advanced options

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

When there’s a merge conflict, open Git Bash and type: git mergetool.

When invoking YAMLMerge directly from the command line, you can specify which version of a file to keep by using -l or -r. You can also premerge by using the -p switch, and enable headless mode (suppress all error dialogs) by using -h. For more information on these options, invoke unityyamlmerge from the command line with no additional parameters.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

svg]:w-6 [&>svg]:h-6 lg:[&>svg]:w-10 lg:[&>svg]:h-10 !h-12 !w-12 lg:!h-20 lg:!w-20 -right-4 -top-6 lg:-right-10 lg:-top-10" aria-label="Incomplete" aria-live="polite" role="status">

## 5. Conclusion

<span class="flex items-center justify-center w-6 h-6"></span><span class="buttons text-left flex items-center">Q&A (0)</span>

This has been a brief introduction to YAMLMerge, a tool that is included with Unity to resolve merge conflicts when using version control with your projects.

Mark step complete

<span class="absolute bottom-0 right-1/2 h-20 border-r-2 border-gray-300"></span>

## Complete this Tutorial

Mark all steps complete
