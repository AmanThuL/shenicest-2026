---
title: "Unity 6.3 Manual: Use Property Drawers with IMGUI to customize the Inspector"
page_title: "Unity - Manual: Use Property Drawers with IMGUI to customize the Inspector"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/editor-PropertyDrawers.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/editor-PropertyDrawers.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Use Property Drawers with IMGUI to customize the Inspector

**Note**: It’s strongly recommended to use the [UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/UIElements.html) to extend the [Unity Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-support-for-editor-ui.html), as it provides a more modern, flexible, and scalable solution than IMGUI.

Property Drawers can be used to customize the look of certain controls in the **Inspector window** by using attributes on your scripts, or by controlling how a specific `Serializable` class should look.

Property Drawers have two uses:

-   Customize the GUI of every instance of a Serializable class.
-   Customize the GUI of script members with custom **Property Attributes**.

## Customize the GUI of a Serializable class

If you have a custom **Serializable** class, you can use a **Property Drawer** to control how it looks in the **Inspector**. Consider the Serializable class Ingredient in the script examples below (**Note**: These are not editor scripts. Property attribute classes should be placed in a regular script file):

**C# (example)**:

``` lang-cs
using System;
using UnityEngine;

enum IngredientUnit 
// Custom serializable class
[Serializable]
public class Ingredient

public class Recipe : MonoBehaviour

```

Using a custom Property Drawer, every appearance of the Ingredient class in the Inspector can be changed. Compare the look of the Ingredient properties in the Inspector without and with a custom Property Drawer:

![Class in the Inspector without (left) and with (right) custom Property Drawer.](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/CustomPropertyDrawer_Class.png)

You can attach the Property Drawer to a Serializable class by using the **CustomPropertyDrawer** attribute and pass in the type of the Serializable class that it’s a drawer for.

**C# (example)**:

``` lang-cs
using UnityEditor;
using UnityEngine;

// IngredientDrawer
[CustomPropertyDrawer(typeof(Ingredient))]
public class IngredientDrawer : PropertyDrawer

}
```

## Customize the GUI of script members using Property Attributes

The other use of **Property Drawer** is to alter the appearance of members in a script that have custom **Property Attributes**. Say you want to limit floats or integers in your script to a certain range and show them as sliders in the **Inspector**. Using the built-in **PropertyAttribute** called **RangeAttribute** you can do just that:

**C# (example)**:

``` lang-cs
// Show this float in the Inspector as a slider between 0 and 10
[Range(0f, 10f)]
float myFloat = 0f;
```

You can make your own **PropertyAttribute** as well. We’ll use the code for the **RangeAttribute** as an example. The attribute must extend the **PropertyAttribute** class. If you want, your property can take parameters and store them as public member variables.

**C# (example)**:

``` lang-cs
using UnityEngine;

public class MyRangeAttribute : PropertyAttribute 

}
```

Now that you have the attribute, you need to make a **Property Drawer** that draws properties that have that attribute. The drawer must extend the **PropertyDrawer** class, and it must have a **CustomPropertyDrawer** attribute to tell it which attribute it’s a drawer for.

The property drawer class should be placed in an editor script, inside a folder called Editor.

**C# (example)**:

``` lang-cs
using UnityEditor;
using UnityEngine;

// Tell the MyRangeDrawer that it is a drawer for properties with the MyRangeAttribute.
[CustomPropertyDrawer(typeof(MyRangeAttribute))]
public class RangeDrawer : PropertyDrawer

}
```

Note that for performance reasons, EditorGUILayout functions are not usable with Property Drawers.

## Default object references

If you define public [Object](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.html) fields or private ones that are marked with [SerializeField](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializeField.html), you can set up default references for these fields. The default reference fields are visible in the Inspector window when you select the script asset in the Project window.

**Note**: It is recommended to maintain each PropertyDrawer in its own file with a matching name. This ensures efficient allocation of default object references, as they can only be assigned to a single PropertyDrawer. When multiple types are present in the same file, the assigned type will either match the file name or will be the first type defined in the file.
