---
title: "Scripting API: MenuItem"
page_title: "Unity - Scripting API: MenuItem"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MenuItem.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MenuItem.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# MenuItem

class in UnityEditor

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

### Description

The `MenuItem` attribute allows you to add menu items to the main menu and Inspector window context menus.

The `MenuItem` attribute turns any static function into a menu command. Only static functions can use the `MenuItem` attribute.  
  
To create a hotkey, use the following special characters:

-   **%**: Represents **Ctrl** on Windows and Linux. **Cmd** on macOS.
-   **^**: Represents **Ctrl** on Windows, Linux, and macOS.
-   **#**: Represents **Shift**.
-   **&**: Represents **Alt**.

If no special modifier key combinations are required, the key can be given after an underscore. For example, to create a menu with the hotkeys **Shift+Alt+G**, use `"MyMenu/Do Something #&g"`. To create a menu with hotkey **G** with no required key modifiers to press, use `"MyMenu/Do Something _g"`.  
  
A space character must precede hotkey text. For example, `"MyMenu/Do_g"` isn't interpreted as a hotkey, but `"MyMenu/Do _g"` is.  
  
Some special keyboard keys are supported as hotkeys. For example, "#LEFT" would map to Shift-Left. The keys supported like this are: LEFT, RIGHT, UP, DOWN, F1 .. F12, HOME, END, PGUP, PGDN, INS, DEL, BACKSPACE, TAB, and SPACE.  
  
When adding menu items to the "GameObject/" menu to create custom GameObjects, be sure to call [GameObjectUtility.SetParentAndAlign](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GameObjectUtility.SetParentAndAlign.html) to ensure that the new GameObject is reparented correctly in the case of a context click (see example below). Your function should also call [Undo.RegisterCreatedObjectUndo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Undo.RegisterCreatedObjectUndo.html) to make the creation undoable and set [Selection.activeObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Selection-activeObject.html) to the newly created object. Also note that in order for a menu item in "GameObject/" to be propagated to the hierarchy Create dropdown and hierarchy context menu, it must be grouped with the other GameObject creation menu items. This can be achieved by setting its priority to 10 (see example below). Note that for legacy purposes MenuItems in "GameObject/Create Other" with no explicit priority set will receive a priority of 10 instead of the default 1000 - we encourage using a more descriptive category name than "Create Other" and explicitly setting the priority to 10.  
  
You can use `MenuItem` to add menu items to the right-click context menu in the Project window. The context menu in the Project window uses the same menu items as the Assets menu. When you add a menu item to the Assets menu, that menu item is also added to the context menu in the Project window. For example, `"Assets/Do something"` adds the `Do something` menu item to the context menu in the Project window.  
  
**Important:** Only initialize public fields of `[MenuItem]` via the corresponding constructor parameters. Modifying these fields later can lead to unexpected behavior. Any undocumented public fields are for internal use only.

``` codeExampleCS
using UnityEditor;
using UnityEngine;

public class MenuTest : MonoBehaviour

    // Add a menu item named "Log Selected Transform Name" to MyMenu in the menu bar.
    // We want this to be validated menu item: an item that is only enabled if specific conditions are met.
    // To achieve this, we use a second function below to validate the menu item.
    // so it will only be enabled if we have a transform selected.
    [MenuItem("MyMenu/Log Selected Transform Name")]
    static void LogSelectedTransformName()
    
    // Validate the menu item defined by the function above.
    // The "Log Selected Transform Name" menu item is disabled if this function returns false.
    // We tell the Editor that this is a validation function by decorating it with a MenuItem attribute
    // and passing true as the second parameter.
    // This invokes the MenuItem(string itemName, bool isValidateFunction) attribute constructor
    // resulting in the function being treated as the validator for "Log Selected Transform Name" menu item.
    [MenuItem("MyMenu/Log Selected Transform Name", true)]
    static bool ValidateLogSelectedTransformName()
    
    // Add a menu item named "Do Something with a Shortcut Key" to MyMenu in the menu bar
    // and give it a shortcut (ctrl-g on Windows, cmd-g on macOS).
    [MenuItem("MyMenu/Do Something with a Shortcut Key %g")]
    static void DoSomethingWithAShortcutKey()
    
    // Add a menu item called "Double Mass" to a Rigidbody's context menu.
    [MenuItem("CONTEXT/Rigidbody/Double Mass")]
    static void DoubleMass(MenuCommand command)
    
    // Add a menu item to create custom GameObjects.
    // Priority 10 ensures it is grouped with the other menu items of the same kind
    // and propagated to the hierarchy dropdown and hierarchy context menus.
    [MenuItem("GameObject/MyCategory/Custom Game Object", false, 10)]
    static void CreateCustomGameObject(MenuCommand menuCommand)
    
    // Add a menu item called "Test" to the Scene view context menu when the
    // EditorToolContext "TestToolContext" is engaged.
    [MenuItem("CONTEXT/TestToolContext/Test")]
    static void TestToolContextItem()
    
    // Add a menu item called "Test" to the Scene view context menu when the
    // EditorTool "TestTool" is engaged.
    [MenuItem("CONTEXT/TestTool/Test")]
    static void TestToolItem()
    
}
```

### Properties

| Property                                                                                         | Description                                                                                      |
|--------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| [menuItem](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MenuItem-menuItem.html) | Holds a sanitized reference to the name of the menu item as a path.                              |
| [priority](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MenuItem-priority.html) | The order to display the menu item in a menu.                                                    |
| [validate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MenuItem-validate.html) | Whether the method decorated by this instance of the menu item attribute is a validate function. |

### Constructors

| Constructor                                                                                  | Description                                                                                         |
|----------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------|
| [MenuItem](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/MenuItem-ctor.html) | Creates a menu item and invokes the static function that follows it when the menu item is selected. |
