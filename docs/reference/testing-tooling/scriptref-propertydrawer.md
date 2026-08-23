---
title: "Scripting API: PropertyDrawer"
page_title: "Unity - Scripting API: PropertyDrawer"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyDrawer.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyDrawer.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# PropertyDrawer

class in UnityEditor

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/GUIDrawer.html" class="cl">GUIDrawer</a>

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

Base class to derive custom property drawers from. Use this to create custom drawers for your own [Serializable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.IAudioGenerator.Serializable.html) classes or for script variables with custom [PropertyAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyAttribute.html)s.

PropertyDrawers have two uses:

-   Customize the GUI of every instance of a [Serializable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.IAudioGenerator.Serializable.html) class.
-   Customize the GUI of script members with custom [PropertyAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyAttribute.html)s.

If you have a custom [Serializable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Audio.IAudioGenerator.Serializable.html) class, you can use a PropertyDrawer to control how it looks in the Inspector. Consider the Serializable class Ingredient in the script below:

``` codeExampleCS
using System;
using UnityEngine;

public enum IngredientUnit 
// Custom serializable class
[Serializable]
public class Ingredient

public class Recipe : MonoBehaviour

```

Using a custom PropertyDrawer, every appearance of the Ingredient class in the Inspector can be changed.  
  
You can attach the PropertyDrawer to a Serializable class by using the [CustomPropertyDrawer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CustomPropertyDrawer.html) attribute and pass in the type of the Serializable class that it's a drawer for.  
  
You can either use UI Toolkit to build your custom PropertyDrawer or you can use IMGUI. To create a custom PropertyDrawer using UI Toolkit, you have to override the [PropertyDrawer.CreatePropertyGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyDrawer.CreatePropertyGUI.html) on the PropertyDrawer class. To create a custom PropertyDrawer using IMGUI, you have to override the [PropertyDrawer.OnGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyDrawer.OnGUI.html) on the PropertyDrawer class.  
  
**Note**: You can't run UI Toolkit inside IMGUI. This means if your custom PropertyDrawer only has a UI Toolkit implementation, it won't work inside an IMGUI custom Inspector or a parent IMGUI custom PropertyDrawer. Starting from Unity 2022.2, the default Inspector uses UI Toolkit exclusively in custom PropertyDrawers. However, you might still need to implement IMGUI if the property drawers is called from a custom Editor. Prior to 2022.2, it is recommended that you either implement both IMGUI and UI Toolkit versions of each PropertyDrawer, or make sure they are exclusively used inside custom UI Toolkit inspectors.  
  
Here's an example of a custom PropertyDrawer written using UI Toolkit:

``` codeExampleCS
using UnityEditor;
using UnityEditor.UIElements;
using UnityEngine.UIElements;

// IngredientDrawerUIE
[CustomPropertyDrawer(typeof(Ingredient))]
public class IngredientDrawerUIE : PropertyDrawer

}
```

Here's an example of custom PropertyDrawer written using IMGUI. Compare the look of the Ingredient properties in the Inspector without and with a custom PropertyDrawer:  
  
![](https://docs.unity3d.com/6000.3/Documentation/StaticFiles/ScriptRefImages/CustomPropertyDrawer_Class.png)  
*Class in the Inspector without (left) and with (right) custom PropertyDrawer.*

``` codeExampleCS
using UnityEditor;
using UnityEngine;

// IngredientDrawer
[CustomPropertyDrawer(typeof(Ingredient))]
public class IngredientDrawer : PropertyDrawer

}
```

The other use of PropertyDrawer is to alter the appearance of members in a script that have custom [PropertyAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyAttribute.html)s. Say you want to limit floats or integers in your script to a certain range and show them as sliders in the Inspector. Using the built-in [PropertyAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyAttribute.html) called [RangeAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RangeAttribute.html) you can do just that:

``` codeExampleCS
using UnityEngine;
using System.Collections;

public class ExampleClass : MonoBehaviour

```

You can make your own [PropertyAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyAttribute.html) as well. We'll use the code for the [RangeAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/RangeAttribute.html) as an example. The attribute must extend the PropertyAttribute class. If you want, your property can take parameters and store them as public member variables.

``` codeExampleCS
// This is not an editor script. The property attribute class should be placed in a regular script file.
using UnityEngine;

public class RangeAttribute : PropertyAttribute

}
```

Now that you have the attribute, you need to make a PropertyDrawer that draws properties that have that attribute. The drawer must extend the PropertyDrawer class, and it must have a [CustomPropertyDrawer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CustomPropertyDrawer.html) attribute to tell it which attribute it's a drawer for. Here's an example using IMGUI:

``` codeExampleCS
// The property drawer class should be placed in an editor script, inside a folder called Editor.

// Tell the RangeDrawer that it is a drawer for properties with the RangeAttribute.
using UnityEngine;
using UnityEditor;

[CustomPropertyDrawer(typeof(RangeAttribute))]
public class RangeDrawer : PropertyDrawer

}
```

Note that for performance reasons, EditorGUILayout functions are not usable with PropertyDrawers.  
  
**Note**: Lists and arrays are handled differently with custom drawers. When the `SerializedProperty` is passed to the `CreatePropertyGUI` method, it represents each item in the list. However, when the custom drawing is needed for the list itself, you must wrap the property accordingly.  
  
If you need your property drawer to perform cleanup tasks, such as detaching itself from editor events, you can implement the [IDisposable](https://learn.microsoft.com/en-us/dotnet/api/system.idisposable) interface. This interface allows you to define a method that will be invoked when the Editor is being destroyed, giving you the opportunity to handle any necessary cleanup operations.  
  
Additional resources: [PropertyAttribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyAttribute.html) class, [CustomPropertyDrawer](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CustomPropertyDrawer.html) class.

### Properties

| Property                                                                                                           | Description                                                                                  |
|--------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|
| [attribute](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyDrawer-attribute.html)           | The PropertyAttribute for the property. Not applicable for custom class drawers. (Read Only) |
| [fieldInfo](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyDrawer-fieldInfo.html)           | The reflection FieldInfo for the member this property represents. (Read Only)                |
| [preferredLabel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyDrawer-preferredLabel.html) | The label for this property. (Read Only)                                                     |

### Public Methods

| Method                                                                                                                   | Description                                                                   |
|--------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------|
| [CreatePropertyGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyDrawer.CreatePropertyGUI.html) | Creates custom GUI with UI Toolkit for the property.                          |
| [GetPropertyHeight](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyDrawer.GetPropertyHeight.html) | Override this method to specify how tall the GUI for this field is in pixels. |
| [OnGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/PropertyDrawer.OnGUI.html)                         | Override this method to make your own IMGUI based GUI for the property.       |

### Inherited Members
