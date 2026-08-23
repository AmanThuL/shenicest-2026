---
title: "Unity 6.3 Manual: Creating scripts"
page_title: "Unity - Manual: Creating scripts"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/creating-scripts.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/creating-scripts.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Creating scripts

Scripts allow you to customize and extend the capabilities of your applicaton with C# code. With scripts that derive from Unity’s built-in [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html) class you can create your own custom Components to control the behavior of GameObjects. With scripts that derive from [ScriptableObject](https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html) you can store large amounts of data efficiently in your application. Alternatively, you can start with an empty C# script to develop your own non-Unity classes.

Unlike most other assets, scripts are usually created within Unity directly. To create a new script:

-   From the main menu: go to **Assets > Create > Scripting** and select the type of script you want to create.

Or:

-   From the Create menu (plus sign) in the [Project window toolbar](https://docs.unity3d.com/6000.3/Documentation/Manual/ProjectView.html): go to **Scripting** and select the type of script you want to create.

This creates a new script in whichever folder you have selected in the Project panel. It also selects the script’s file name for editing, prompting you to change the name. For things you should take into account when naming your scripts, refer to [Naming considerations for scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/naming-scripts.html).

## Additional resources

-   [Naming scripts](https://docs.unity3d.com/6000.3/Documentation/Manual/naming-scripts.html)
-   [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html)
-   [ScriptableObject](https://docs.unity3d.com/6000.3/Documentation/Manual/class-ScriptableObject.html)
