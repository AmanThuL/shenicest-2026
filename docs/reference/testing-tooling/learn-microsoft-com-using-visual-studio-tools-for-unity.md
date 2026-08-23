---
title: "Using Visual Studio Tools for Unity (Microsoft)"
page_title: "Using Visual Studio Tools for Unity | Microsoft Learn"
source_url: "https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/get-started/using-visual-studio-tools-for-unity"
final_url: "https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/get-started/using-visual-studio-tools-for-unity"
topic: "testing-tooling"
publisher: "third-party"
fetched: "2026-08-23"
kind: "html"
---

# Using Visual Studio Tools for Unity | Microsoft Learn

<span class="icon" aria-hidden="true"><span class="docon docon-menu"></span></span> <span class="contents-expand-title"> Table of contents </span>

<span class="icon" aria-hidden="true"><span class="docon docon-exit-mode"></span></span> Exit editor mode

<span class="icon" aria-hidden="true"> <span class="docon docon-more"></span> </span>

<span class="icon" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span>

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon" aria-hidden="true"> <span class="docon docon-more-vertical"></span> </span>

<span class="icon" aria-hidden="true"> <span class="docon docon-glasses"></span> </span> Reading mode

<span class="icon" aria-hidden="true"><span class="docon docon-editor-list-bullet"></span></span> <span class="contents-expand-title">Table of contents</span>

<a href="https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/get-started/using-visual-studio-tools-for-unity#" id="lang-link-overflow" class="button-sm inner-focus button button-clear button-block justify-content-flex-start text-align-left"><span class="icon" aria-hidden="true" data-read-in-link-icon=""> <span class="docon docon-locale-globe"></span> </span> <span data-read-in-link-text="">Read in English</span></a>

<span class="icon" aria-hidden="true"> <span class="docon docon-circle-addition"></span> </span> <span class="collection-status">Add</span>

<span class="icon" aria-hidden="true"> <span class="docon docon-circle-addition"></span> </span> <span class="plan-status">Add to Plans</span>

<a href="https://github.com/MicrosoftDocs/visualstudio-docs/blob/main/gamedev/unity/get-started/using-visual-studio-tools-for-unity.md" class="button button-clear button-block button-sm inner-focus justify-content-flex-start text-align-left text-decoration-none"><span class="icon" aria-hidden="true"> <span class="docon docon-edit-outline"></span> </span> <span>Edit</span></a>

------------------------------------------------------------------------

<span class="icon color-primary" aria-hidden="true"> <span class="docon docon-code-lang" show-when="idle"></span> <span class="loader" show-when="loading" hidden=""></span> <span class="docon docon-check-mark" show-when="success" hidden=""></span> </span> Copy Markdown

<span class="icon color-primary" aria-hidden="true"> <span class="docon docon-print"></span> </span> Print

------------------------------------------------------------------------

<span class="icon" aria-hidden="true"><span class="docon docon-exclamation-circle-solid"></span></span> Note

Access to this page requires authorization. You can try <a href="https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/get-started/using-visual-studio-tools-for-unity#" class="docs-sign-in">signing in</a> or <span class="docs-change-directory">changing directories</span>.

Access to this page requires authorization. You can try <span class="docs-change-directory">changing directories</span>.

# Use Visual Studio Tools for Unity

<span class="icon" aria-hidden="true"> <span class="docon docon-like"></span> </span> Feedback

<span class="icon" aria-hidden="true"> <span class="docon docon-sparkle-fill gradient-text-vivid"></span> </span>

<span class="ai-summary-cta-text"> Summarize this article for me </span>

In this section, you'll learn how to use Visual Studio Tools for Unity's integration and productivity features, and how to use the Visual Studio debugger for Unity development.

## Open Unity scripts in Visual Studio

Once Visual Studio is [set as the external editor for Unity](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/get-started/getting-started-with-visual-studio-tools-for-unity#configure-unity-to-use-visual-studio), double-clicking a script from the Unity editor will automatically launch or switch to Visual Studio and open the chosen script.

Alternatively, you can open Visual Studio with no script open in the source editor by selecting the **Assets \> Open C# Project** menu in Unity.

![Screenshot of the Open C# project in Visual Studio.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/vstu-open-csharp-project.png)

![Screenshot of the Open C# project in Visual Studio for Mac.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vsm/vstu-open-csharp-project.png)

## Unity documentation access

You can access the Unity scripting documentation quickly from Visual Studio. If Visual Studio Tools for Unity doesn't find the API documentation locally, it will try to find it online.

-   In Visual Studio, highlight or place the cursor over the Unity API you want to learn about, then press **Ctrl**+**Alt**+**M**, **Ctrl**+**H**
-   You can also use the **Help > Unity API Reference** menu instead of the keybinding.

![Screenshot of the Unity API Reference menu in Visual Studio.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/help-unity-documentation.png)

-   In Visual Studio for Mac, highlight or place the cursor over the Unity API you want to learn about, then press **Cmd**+**'**
-   You can also use the **Help > Unity API Reference** menu instead of the keybinding.

![Screenshot of the Unity API Reference menu in Visual Studio for Mac.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vsm/help-unity-documentation.png)

## Intellisense for Unity API Messages

Intellisense code-completion makes it easy to implement Unity API messages in MonoBehaviour scripts, and assists with learning the Unity API. To use IntelliSense for Unity messages:

1.  Place the cursor on a new line inside the body of a class that derives from `MonoBehaviour`.

2.  Begin typing the name of a Unity message, such as `OnTriggerEnter`.

3.  Once the letters "**ontri**" have been typed, a list of IntelliSense suggestions appears.

![Screenshot of using IntelliSense in Visual Studio.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/intellisense-example.png)

4.  The selection on the list can be changed in three ways:

    -   With the **Up** and **Down** arrow keys.

    -   By clicking with the mouse on the desired item.

    -   By continuing to type the name of the desired item.

5.  IntelliSense can insert the selected Unity message, including any necessary parameters:

    -   By pressing **Tab**.

    -   By pressing **Enter**.

    -   By double-clicking the selected item.

![Screenshot of the Insert Unity message from IntelliSense in Visual Studio.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/vstu-intellisense2.png)

## Unity MonoBehavior scripting wizard

You can use the MonoBehavior wizard to view a list of all the Unity API methods and quickly implement an empty definition. This feature, particularly with the **Generate method comments** option enabled, is helpful if you are still learning what's available in the Unity API.

To create empty MonoBehavior method definitions with the MonoBehavior wizard:

1.  In Visual Studio, position the cursor where you want the methods to be inserted, then press **Ctrl**+**Shift**+**M** to launch the MonoBehavior wizard. In Visual Studio for Mac, press **Cmd**+**Shift**+**M**.

2.  In the **Create script methods** window, mark the checkbox next to the name of each method you want to add.

3.  Use the **Framework version** dropdown to select your desired version.

4.  By default, the methods are inserted at the position of the cursor. Alternatively, you can choose to insert them after any method that's already implemented in your class by changing the value of the **Insertion point** dropdown to the location you want.

5.  If you want the wizard to generate comments for the methods you selected, mark the **Generate method comments** checkbox. These comments are meant to help you understand when the method is called and what its general responsibilities are.

6.  Choose the **OK** button to exit the wizard and insert the methods into your code.

![Screenshot of the monobehavior wizard dialog in Visual Studio.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/vstu-monobehavior-wizard.png)

![Screenshot of the monobehavior wizard dialog in Visual Studio for Mac.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vsm/vstu-monobehavior-wizard.png)

## Unity Project Explorer

The Unity Project Explorer shows all of your Unity project files and directories in the same way that the Unity Editor does. This is different than navigating your Unity scripts with the normal Visual Studio Solution Explorer, which organizes them into projects and a solution generated by Visual Studio.

-   On the main Visual Studio menu, choose **View > Unity Project Explorer**. Keyboard shortcut: **Alt**+**Shift**+**E**

![Screenshot of the Unity Project Explorer window.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/unity-project-explorer.png)

-   In Visual Studio for Mac, the Solution Pad automatically behaves like this when a Unity project is opened.

## Unity debugging

Visual Studio Tools for Unity lets you debug both editor and game scripts for your Unity project using Visual Studio's powerful debugger.

### Debug in the Unity editor

#### Start debugging

1.  Connect Visual Studio to Unity by clicking the **Play** button labeled **Attach to Unity**, or use the keyboard shortcut **F5**.

![Screenshot of the Attach to Unity button in Visual Studio.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/vstu-play-button.png)

1.  Connect Visual Studio to Unity by clicking the **Play** button, or type **Command + Return**, or **F5**.

![Screenshot of the Play button in Visual Studio for Mac.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vsm/using-vsmac-tools-unity-image5.png)

2.  Switch to Unity and click the **Play** button to run the game in the editor.

![Screenshot of the Play button in Unity on Windows.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/vstu-unity-play-button.png)

![Screenshot of the Play button in Unity on macOS.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vsm/using-vsmac-tools-unity-image6.png)

3.  When the game is running in the Unity editor while connected to Visual Studio, any breakpoints encountered will pause execution of the game and bring up the line of code where the game hit the breakpoint in Visual Studio.

#### Stop debugging

Click the **Stop** button in Visual Studio, or use the keyboard shortcut **Shift + F5**.

![Screenshot of the Stop button in Visual Studio.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/vstu-stop-debugger.png)

Click the **Stop** button in Visual Studio for Mac, or press **Shift + Command + Return**.

![Screenshot of the Stop button in Visual Studio for Mac.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vsm/using-vsmac-tools-unity-image7.png)

To learn more about debugging in Visual Studio, see [Documentation for First look at the Visual Studio Debugger.](https://learn.microsoft.com/en-us/visualstudio/debugger/debugger-feature-tour).

#### Attach to Unity and Play

For added convenience, you can change the **Attach to Unity** button to **Attach to Unity and Play** mode.

1.  Click the small **down arrow** next to the **Attach to Unity** button.

2.  Select **Attach to Unity and Play** from the dropdown menu.

    ![Screenshot of the Attach and play button in Visual Studio.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/vstu-attach-and-play.png)

The play button becomes labeled **Attach to Unity and Play**. Clicking this button or using the keyboard shortcut **F5** now automatically switches to the Unity editor and runs the game in the editor, in addition to attaching the Visual Studio debugger.

Starting debugging and playing the Unity editor can be completed in a single step directly from Visual Studio for Mac by choosing the **Attach to Unity and Play** configuration.

![Screenshot of the Attach to Unity and Play button in Visual Studio for Mac.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vsm/using-vsmac-tools-unity-image8.png)

Note

If you started debugging using the **Attach to Unity and Play** configuration, the **Stop** button will also stop the Unity Editor.

### Debug Unity player builds

You can debug development builds of Unity players with Visual Studio.

#### Enable script debugging in a Unity player

1.  In Unity, open the Build Settings by selecting **File > Build Settings**.

2.  In the Build Settings window, mark the **Development Build** and **Script Debugging** checkboxes.

    ![Screenshot of the Unity build settings for debugging.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/vstu-debugging-build-settings.png)

#### Select a Unity instance to attach the debugger to

-   In Visual Studio, on the main menu, choose **Debug > Attach Unity Debugger**.

    ![Screenshot of the Attach Unity Debugging Window in Visual Studio.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/vstu-debugging-attach-unity-debugger.png)

    The **Select Unity Instance** dialog displays some information about each Unity instance that you can connect to.

    ![Screenshot of the Choose an instance of Unity to connect to window in Visual Studio.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/vstu-attach-debugger.png)

    **Project** The name of the Unity project that's running in this instance of Unity.

    **Machine** The name of the computer or device that this instance of Unity is running on.

    **Type** Editor if this instance of Unity is running as part of the Unity Editor; Player if this instance of Unity is a stand-alone player.

    **Port** The port number of the UDP socket that this instance of Unity is communicating over.

Important

Because Visual Studio Tools for Unity and the Unity instance are communicating over a UDP network socket, your firewall may need rule to allow it. If needed, you may see a prompt, you'll have to authorize the connection so that VSTU and Unity can communicate.

#### Selecting a Unity instance that doesn't appear in the list

If you have a known Unity Player running that doesn't appear in the list, you can use the **Input IP** button on the Select Unity Instance window. Enter the IP address and port of the running Unity Player to connect the debugger.

To make it easier for you to continue debugging that player without entering the IP and port each time, enable the **Use saved debug targets** setting in the **Tools \> Options \> Tools for Unity \> General** menu.

![Screenshot of the Use saved debug targets setting.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/visual-studio-tools-unity-use-saved-debug-targets.png)

Visual Studio will show saved debug targets as an option in Attach to Unity button.

![Screenshot of the Saved debug target setting.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/visual-studio-tools-unity-saved-target.png)

-   In Visual Studio for Mac, on the top menu, choose **Run > Attach to Process**.
-   In the **Attach to Process** dialog, select **Unity Debugger** option in the Debugger drop-down menu at the bottom.
-   Select a Unity instance from the list and click the **Attach** button.

### Debug a DLL in your Unity project

Many Unity developers are writing code components as external DLLs so that the functionality they develop can be easily shared with other projects. Visual Studio Tools for Unity makes it easy to debug code in these DLLs seamlessly with other code in your Unity project.

Note

At this time, Visual Studio Tools for Unity only supports managed DLLs. It does not support debugging of native code DLLs, such as those written in C++.

Note that the scenario described here assumes that you have the source codeâ€”that is, you are developing or re-using your own first-party code, or you have the source code to a third-party library, and plan to deploy it in your Unity project as a DLL. This scenario does not describe debugging a DLL for which you do not have the source code.

#### To debug a managed DLL project used in your Unity project

1.  Add your existing DLL project to the Visual Studio solution generated by Visual Studio Tools for Unity. Less commonly, you might be starting a new managed DLL project to contain code components in your Unity project; if that's the case, you can add a new managed DLL project to the Visual Studio solution instead.

    ![Screenshot of the Add > Existing Item menu.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/vstu-debugging-dll-add-existing.png)

    In either case, Visual Studio Tools for Unity maintains the project reference, even if it has to regenerate the project and solution files again, so you only need to perform these steps once.

2.  Reference the correct Unity framework profile in the DLL project. In Visual Studio, in the DLL project's properties, set the **Target framework** property to the Unity framework version you're using. This is the Unity Base Class Library that matches the API compatibility that your project targets, such as the Unity full, micro, or web base class libraries. This prevents your DLL from calling framework methods that exist in other frameworks or compatibility levels, but which might not exist in the Unity framework version you're using.

Note

The following is only required if you are using Unity's legacy runtime. If you are using the new Unity runtime, you don't need to use those dedicated 3.5 profiles anymore. Use a .NET 4.x profile compatible with your Unity version.

![Screenshot of the selecting target framework for a project in Visual Studio.](https://learn.microsoft.com/en-us/visualstudio/gamedev/unity/media/vs/vstu-debugging-dll-target-framework.png)

3.  Copy the DLL to your Unity project's Asset folder. In Unity, assets are files that are packaged and deployed together with your Unity app so that they can be loaded at run-time. Since DLLs are linked at run time, DLLs must be deployed as assets. To be deployed as an asset, the Unity Editor requires the DLLs to be put inside the Assets folder in your Unity project. There are two ways you can do this:

    -   Modify the build settings of your DLL project to include a post-built task that copies the output DLL and PDB files from its output folder to the **Assets** folder of your Unity project.

    -   Modify the build settings of your DLL project to set its output folder to be the **Assets** folder of your Unity project. Both DLL and PDB files will be placed in the **Assets** folder.

    The PDB files are needed for debugging because they contain the DLL's debugging symbols, and map the DLL code to its source code form. If you are targeting the legacy runtime, Visual Studio Tools for Unity will use information from the DLL and PDB to create a DLL.MDB file, which is the debug symbol format used by the legacy Unity scripting engine. If you are targeting the new runtime, and using Portable-PDB, Visual Studio Tools for Unity will not try to do any symbol conversion as the new Unity runtime is able to natively consume Portable-PDBs.

    More information about PDB generation can be found [here](https://learn.microsoft.com/en-us/visualstudio/debugger/how-to-set-debug-and-release-configurations). If you are targeting the new runtime, please make sure that "Debugging Information" is set to "Portable", in order to properly generate Portable-PDB. If you are targeting the legacy runtime, you need to use "Full".

4.  Debug your code. You can now debug your DLL source code together with your Unity project's source code, and use all the debugging features you are used to, such as breakpoints and stepping through code.

## Keyboard shortcuts

You can quickly access the Unity Tools for Visual Studio functionality by using their keyboard shortcuts. Here's a summary of the shortcuts that are available.

| Command                                     | Shortcut                           | Shortcut command name                                     |
|---------------------------------------------|------------------------------------|-----------------------------------------------------------|
| Open the MonoBehavior Wizard                | **Ctrl**+**Shift**+**M**           | **EditorContextMenus.CodeWindow.ImplementMonoBehaviours** |
| Open the Unity Project Explorer             | **Alt**+**Shift**+**E**            | **View.UnityProjectExplorer**                             |
| Access Unity documentation                  | **Ctrl**+**Alt**+**M, Ctrl**+**H** | **Help.UnityAPIReference**                                |
| Attach to Unity debugger (player or editor) | ***no default***                   | **Debug.AttachUnityDebugger**                             |

You can change the shortcut key combinations if you don't like the default. For information on how to change it, see [Identify and customize keyboard shortcuts in Visual Studio](https://learn.microsoft.com/en-us/visualstudio/ide/identifying-and-customizing-keyboard-shortcuts-in-visual-studio).

| Command                      | Shortcut                | Shortcut command name                                     |
|------------------------------|-------------------------|-----------------------------------------------------------|
| Open the MonoBehavior Wizard | **Cmd**+**Shift**+**M** | **EditorContextMenus.CodeWindow.ImplementMonoBehaviours** |
| Access Unity documentation   | **Cmd+'**               | **Help.UnityAPIReference**                                |

You can change the shortcut key combinations if you don't like the default. For information on how to change it, see [Customizing the IDE](https://learn.microsoft.com/en-us/visualstudio/mac/customizing-the-ide#key-bingings).

------------------------------------------------------------------------

## Feedback

Was this page helpful?

<span class="icon" aria-hidden="true"> <span class="docon docon-like"></span> </span> Yes

<span class="icon" aria-hidden="true"> <span class="docon docon-dislike"></span> </span> No

<span class="icon" aria-hidden="true"> <span class="docon docon-dislike"></span> </span> No

Need help with this topic?

Want to try using Ask Learn to clarify or guide you through this topic?

<span class="icon" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span>

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon font-size-lg" aria-hidden="true"> <span class="docon docon-chat-sparkle-fill gradient-ask-learn-logo"></span> </span> Ask Learn

<span class="icon" aria-hidden="true"> <span class="docon docon-feedback"></span> </span> Suggest a fix?

------------------------------------------------------------------------

## Additional resources

------------------------------------------------------------------------

-   <span class="badge badge-sm text-wrap-pretty"> Last updated on 2021-12-28 </span>
