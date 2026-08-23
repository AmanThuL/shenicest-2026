---
title: "Unity 6.3 Manual: External Tools preferences reference"
page_title: "Unity - Manual: External Tools preferences reference"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/preferences-external-tools.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/preferences-external-tools.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# External Tools preferences reference

Use the **External Tools** preferences to set up external applications for scripting, working with images, and source control.

To open the preferences, go to **Edit \> Preferences \> External Tools** (macOS: **Unity \> Settings \> External Tools**).

<table><thead><tr class="header"><th style="text-align: left;"><strong>Property</strong></th><th style="text-align: left;"><strong>Function</strong></th></tr></thead><tbody><tr class="odd"><td style="text-align: left;"><strong>External Script Editor</strong></td><td style="text-align: left;">Choose the application Unity uses to open script files. Unity automatically passes the correct arguments to script editors it has built-in support for. Unity has built-in support for Visual Studio Community, Visual Studio Code (VSCode) and JetBrains Rider. The <strong>Open by file extension</strong> option uses your device’s default application for the relevant file type when you open a file. If no default application is available, your device opens a window that prompts you to choose an application to use to open the file.</td></tr><tr class="even"><td style="text-align: left;"><strong>Generate .csproj files</strong></td><td style="text-align: left;">Select which items Unity should generate <code>.csproj</code> files for. These files contain descriptive data or metadata in an XML format. This data might include versioning information, platform requirements, build files, or database settings.<br />
<br />
When these files are present, code editors can use the data they contain to provide useful features like highlighting potential compilation errors. You can enable generation for the following items:<ul><li><strong>Embedded packages</strong></li><li><strong>Local packages</strong></li><li><strong>Registry packages</strong></li><li><strong>Git packages</strong></li><li><strong>Built-in packages</strong></li><li><strong>Local tarball</strong></li><li><strong>Packages from unknown sources</strong></li><li><strong>Player projects</strong></li></ul></td></tr><tr class="odd"><td style="text-align: left;"><strong>Image application</strong></td><td style="text-align: left;">Choose which application you want Unity to use to open image files.</td></tr><tr class="even"><td style="text-align: left;"><strong>Revision Control Diff/Merge</strong></td><td style="text-align: left;">Choose which application you want Unity to use to resolve merge conflicts and view file differences in your source control repository. Unity detects these tools in their default installation locations.<br />
<br />
For more information, refer to <a href="https://docs.unity3d.com/6000.3/Documentation/Manual/diff-tool-support.html">Diff tool support</a>.</td></tr></tbody></table>

## Additional resources

-   [Project Settings reference](https://docs.unity3d.com/6000.3/Documentation/Manual/comp-ManagerGroup.html)
-   [Project configuration](https://docs.unity3d.com/6000.3/Documentation/Manual/project-configuration.html)
