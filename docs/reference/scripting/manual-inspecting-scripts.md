---
title: "Inspecting scripts"
page_title: "Unity - Manual: Inspecting scripts"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/inspecting-scripts.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/inspecting-scripts.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Inspecting scripts

When you select a script asset in the Project window, the Inspector displays some basic information about it, including the name of the [assembly](https://docs.unity3d.com/6000.3/Documentation/Manual/script-compile-order-folders.html) it belongs to, and a preview of the contents.

**Note:** Although the Inspector displays the contents of the script, you can’t edit the contents in the Inspector window.

![The script Inspector displaying an example script.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/ScriptInspector.png)

The script Inspector also displays two buttons, **Open** and **Execution Order**.

**Open** performs the same function as double-clicking the script in the Project window, opening the script in the currently configured External Script Editor. You can configure which external editor Unity uses to open your scripts in the [External Tools section of the Preferences window](https://docs.unity3d.com/6000.3/Documentation/Manual/preferences-external-tools.html).

The **Execution Order** button opens the [Script Execution Order section of the Project Settings window](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoManager.html) where you can configure the order in which Unity executes your scripts.

## Script components in the Inspector window

Any [MonoBehaviour](https://docs.unity3d.com/6000.3/Documentation/Manual/class-MonoBehaviour.html) script can be used as a [component](https://docs.unity3d.com/6000.3/Documentation/Manual/Components.html), which means:

-   You can attach the script to [GameObjects](https://docs.unity3d.com/6000.3/Documentation/Manual/GameObjects.html)
-   You can edit the script’s properties and values in the [Inspector window](https://docs.unity3d.com/6000.3/Documentation/Manual/UsingTheInspector.html)

The example code below declares a public field called `myName`. When you add this script to a GameObject in your scene, the field becomes visible in the **Inspector** window as a field labelled **My Name**. The default value of `none` declared in the script becomes the default value in the **Inspector** window, which you can then change by typing into the field.

``` lang-cs
using UnityEngine;
using System.Collections;

public class MainPlayer : MonoBehaviour 

}
```

Each GameObject you attach your script component to can have its own unique value for the field.

![A public string field editable in the Inspector window.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/EditingVarInspector.png)

Field names are converted to **Inspector** window labels according to the rules described in [Field name to label conversion](https://docs.unity3d.com/6000.3/Documentation/Manual/inspecting-scripts.html#field-name-label-conversion). However, these changes are purely for display purposes. You should always use the field name in your code.

In the **Inspector** window, if you edit the **My Name** value and press Play, the console message should now include the text that you entered.

![A debug message appears in the Unity console, which reads “I am alive and my name is Earl”.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/DebugLogMessage.png)

## Public and private fields

All `public` fields are editable in the **Inspector** window by default. To prevent a public variable from being displayed in the **Inspector** window, add the [HideInInspector](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/HideInInspector.html) attribute to it. To make a `private` field editable in the **Inspector** window, add the [SerializeField](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeField.html) attribute to it.

**Note**: You can change the value of a script’s fields in the Editor while running in [Play mode](https://docs.unity3d.com/6000.3/Documentation/Manual/configurable-enter-play-mode.html). This allows you to see the effects of changes directly without having to stop and restart. However, when you exit Play mode, the values of the fields reset to whatever they were before you entered Play mode.

<span id="object-reference-fields"></span>

## Object reference fields

As well as simple [built-in C# types](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/value-types#built-in-value-types) such as `bool`, `string`, and `int`, you can also make any field whose type inherits from [`UnityEngine.Object`](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Object.html) editable in the **Inspector** window. This includes all built-in component types (such as [Transform](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Transform.html), [AudioSource](https://docs.unity3d.com/6000.3/Documentation/Manual/class-AudioSource.html), [Camera](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Camera.html), [Light](https://docs.unity3d.com/6000.3/Documentation/Manual/class-Light.html)), your own MonoBehaviour script types, and many asset types.

This allows you to make use of the Unity Editor’s drag-and-drop system in your own scripted components. For example, if you create a public `Transform` field in your script and add it to one GameObject, you can then drag another GameObject into that field in the **Inspector** window to set up a reference to that GameObject’s Transform component, which you can then access at runtime in your script.

For example, this `Follow` script makes one GameObject follow another:

``` lang-cs
using UnityEngine;

public class Follow : MonoBehaviour

}
```

The script has a public field of type `Transform` which appears in the Editor as an assignable field. You can drag and drop a different GameObject from your Hierarchy window into this field, and the Editor assigns a reference to the Transform component attached to that dropped GameObject.

In the screenshot below, the script is placed on the Sphere GameObject, and the Cube has been dragged and dropped from the Hierarchy into the **Object To Follow** field.

![A public Transform field with a GameObject assigned. Here the script is on the Sphere (currently selected), and the Cube was dragged and dropped from the Hierarchy into the Sphere’s **Object To Follow** field](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/UnityObjectInspectorField.png)

<span id="default-object-references"></span>

## Default object references

If you define public [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) fields that can be [assigned in the Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/inspecting-scripts.html#object-reference-fields) in your MonoBehaviour script, you can set up default references for these fields. The default reference fields are visible in the inspector when you select the script asset in the Project window.

![A MonoBehaviour script with three AudioClip fields. The default references for these fields are shown unset.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/MonoBehaviourDefaultReferences.png)

In the example above, there are three public audio clip fields, without default references assigned. You could assign audio clips to each of the AudioClip default reference fields.

If you assign default references, they’re applied when you add your MonoBehaviour as a component to a GameObject, or when you reset an existing instance of your MonoBehaviour on a GameObject to its default values.

**Note:** There is no ongoing link between the references on MonoBehaviour instances on GameObjects and the default references. This means if you change the default references, they’re not automatically updated on existing GameObjects.

Other types of [inspector-editable fields](https://docs.unity3d.com/6000.3/Documentation/Manual/inspecting-scripts.html) that don’t inherit from `UnityEngine.Object` (for example, public string or int fields) don’t have default fields in the Inspector. Instead, they take their default values from the script itself.

### Null reference exceptions

Unity throws a `NullReferenceException` if you forget to initialize a variable that needs to be initialized in the **Inspector** window. You can handle this with `try` / `catch` blocks as shown in the following example:

``` lang-cs
using UnityEngine;
using System;
using System.Collections;

public class Example2 : MonoBehaviour 
        catch (NullReferenceException ex) 
    }
    
}
```

In this code example, the variable called `myLight` is a `Light` which you need to set in the Inspector window. If this variable is not set, then it defaults to `null`.

Attempting to change the color of the light in the `try` block causes a `NullReferenceException`. If this happens, the `catch` block code displays a message reminding you to set the Light in the Inspector.

<span id="field-name-label-conversion"></span>

## Field name to label conversion

Unity converts C# field names to labels in the **Inspector** window according to a set of rules. For example, the variable names in the examples above have been converted from `myName` to **My Name**, and from `objectToFollow` to **Object To Follow**. The rules are as follows:

-   Capitalize the first letter
-   Add a space between lowercase and uppercase characters
-   Add a space between an acronym and an uppercase character at the beginning of the next word
-   Remove any`m_` prefix
-   Remove any `k` prefix
-   Remove any `_` prefix

There are some special cases, such as `iPad` or `x64`, where these rules are not applied.

## Additional resources

-   [Introduction to Components](https://docs.unity3d.com/6000.3/Documentation/Manual/Components.html)
-   [The Inspector window](https://docs.unity3d.com/6000.3/Documentation/Manual/UsingTheInspector.html)
