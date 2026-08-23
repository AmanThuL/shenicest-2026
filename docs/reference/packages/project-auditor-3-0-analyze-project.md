---
title: "Project Auditor: Analyze your project"
page_title: "Analyze your project | Project Auditor | 3.0.1"
source_url: "https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/analyze-project.html"
final_url: "https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/analyze-project.html"
topic: "packages"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

##### Note

This documentation is for the Project Auditor package, compatible with Unity 6.3 and earlier. Unity versions 6.4 and later include Project Auditor built-in by default. You can open it from **Window** \> **Analysis** \> **Project Auditor**. For the documentation on the built-in Project Auditor included in Unity 6.4 and later, refer to the Unity User Manual documentation [Analyze your project with Project Auditor](https://docs.unity3d.com/6000.4/Documentation/Manual/project-auditor/analyze-project.html).

# Analyze your project

Use the Project Auditor window to run an analysis on your project. You can customize how Project Auditor runs in the [Preferences window](https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/project-auditor-settings-reference.html), or you can use the [scripting APIs](https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/project-auditor-programming.html).

## Create a new report

To analyze your project and get a report, perform the following steps:

1.  Open the Project Auditor window (**Window** > **Analysis** > **Project Auditor**).
2.  Select **Start Analysis**. If the window is already populated with data, select **New Analysis** to reset the window.

Project Auditor then analyzes your project. The analysis might take a few minutes to complete, depending on the chosen configuration and how large the project is. Once the analysis completes, Project Auditor displays a [Summary View](https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/summary-view-reference.html) of the report.

##### Note

By default, Project Auditor runs all [Project Areas](https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/project-auditor-window-reference.html#project-area-views). To customize this default behavior, you can enable and disable specific Project Areas in the Preferences window.

## Load a report

To load a previously saved report:

1.  Open the Project Auditor window (**Window** > **Analysis** > **Project Auditor**).
2.  Select the Load icon (square with arrow), and choose the .projectauditor file to load.

## Additional resources

-   [Project Auditor window reference](https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/project-auditor-window.html)
-   [Project Auditor settings reference](https://docs.unity3d.com/Packages/com.unity.project-auditor@3.0/manual/project-auditor-settings-reference.html)
