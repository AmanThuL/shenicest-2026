---
title: "Scripting API: Editor"
page_title: "Unity - Scripting API: Editor"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.html"
topic: "testing-tooling"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Editor

class in UnityEditor

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html" class="cl">ScriptableObject</a>

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

Derive from this base class to create a custom inspector or editor for your custom object.

``` codeExampleCS
using UnityEngine;
using System.Collections;

// This is not an editor script.
public class MyPlayer : MonoBehaviour

}
```

For example, use a custom editor to change the appearance of the script in the Inspector.  
  
You can attach the Editor to a custom component by using the [CustomEditor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CustomEditor.html) attribute.  
  
There are multiple ways to design custom Editors. If you want the Editor to support multi-object editing, you can use the [CanEditMultipleObjects](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/CanEditMultipleObjects.html) attribute. Instead of modifying script variables directly, it's advantageous to use the [SerializedObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializedObject.html) and [SerializedProperty](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializedProperty.html) system to edit them, since this automatically handles multi-object editing, undo, and Prefab overrides. If this approach is used a user can select multiple assets in the hierarchy window and change the values for all of them at once.  
  
You can either use UIElements to build your custom UI or you can use IMGUI. To create a custom inspector using UIElements, you have to override the [Editor.CreateInspectorGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.CreateInspectorGUI.html) on the [Editor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.html) class. To create a custom inspector using IMGUI, you have to override the [Editor.OnInspectorGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.OnInspectorGUI.html) on the [Editor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.html) class. If you use UIElements and have [Editor.CreateInspectorGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.CreateInspectorGUI.html) overwritten, any existing IMGUI implementation using [Editor.OnInspectorGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.OnInspectorGUI.html) on the same Editor will be ignored.  
  
Here's an example of a custom inspector:  
  
![](https://docs.unity3d.com/6000.3/Documentation/StaticFiles/ScriptRefImages/CustomEditorUIElements.png)  
*Custom editor in the Inspector.*

``` codeExampleCS
using UnityEditor;
using UnityEditor.UIElements;
using UnityEngine;
using UnityEngine.UIElements;
[CustomEditor(typeof(MyPlayer))]
public class MyPlayerEditor : Editor
{
    const string resourceFilename = "custom-editor-uie";
    public override VisualElement CreateInspectorGUI()
    {
        VisualElement customInspector = new VisualElement();
        var visualTree = Resources.Load(resourceFilename) as VisualTreeAsset;
        visualTree.CloneTree(customInspector);
        customInspector.styleSheets.Add(Resources.Load($"{resourceFilename}-style") as StyleSheet);
        return customInspector;
    }
}
```

The following example defines the layout of a custom inspector in uxml. The definition loads as a resource and the [VisualTreeAsset.CloneTree](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualTreeAsset.CloneTree.html) method puts the hierarchy in a [VisualElement](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.VisualElement.html) object.  
  
The InspectorWindow will instantiate an [InspectorElement](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.InspectorElement.html) containing the custom inspector. The [InspectorElement](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.InspectorElement.html) will call Bind on the custom inspector binding it to the MyPlayer object.

``` codeExampleCS
<UXML xmlns="UnityEngine.UIElements" xmlns:e="UnityEditor.UIElements">
    <VisualElement class="player-property">
        <VisualElement class="slider-row">
            <Label class="player-property-label" text="Damage"/>
            <VisualElement class="input-container">
                <SliderInt class="player-slider" name="damage-slider" high-value="100" direction="Horizontal" binding-path="damage"/>
                <e:IntegerField class="player-int-field" binding-path="damage"/>
            </VisualElement>
        </VisualElement>
        <e:ProgressBar class="player-property-progress-bar" name="damage-progress" binding-path="damage" title="Damage"/>
    </VisualElement>

    <VisualElement class="player-property">
        <VisualElement class="slider-row">
            <Label class="player-property-label" text="Armor"/>
            <VisualElement class="input-container">
                <SliderInt class="player-slider" name="armor-slider" high-value="100" direction="Horizontal" binding-path="armor"/>
                <e:IntegerField class="player-int-field" binding-path="armor"/>
            </VisualElement>
        </VisualElement>
        <e:ProgressBar class="player-property-progress-bar" name="armor-progress" binding-path="armor" title="Armor"/>
    </VisualElement>

    <e:PropertyField class="gun-field" binding-path="gun" label="Gun Object"/>
</UXML>
```

UIElements automatically updates the UI when data changes and vice-versa. To bind data and automatically update data and UI, set values for the "binding-path" attributes.  
  
Styling of the inspector is done in uss.

``` codeExampleCS
.slider-row 
.input-container 
.player-property 
.player-property-label 
.player-slider 
.player-property-progress-bar 
.player-int-field 
.gun-field 
```

Here's an example of a custom inspector using IMGUI and multi-selection:

``` codeExampleCS
using UnityEditor;
using UnityEngine;
using System.Collections;

// Custom Editor using SerializedProperties.
// Automatic handling of multi-object editing, undo, and Prefab overrides.
[CustomEditor(typeof(MyPlayer))]
[CanEditMultipleObjects]
public class MyPlayerEditor : Editor

    public override void OnInspectorGUI()
    
    // Custom GUILayout progress bar.
    void ProgressBar (float value, string label)
    
}
```

If automatic handling of multi-object editing, undo, and Prefab overrides is not needed, the script variables can be modified directly by the editor without using the [SerializedObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializedObject.html) and [SerializedProperty](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/SerializedProperty.html) system, as in the IMGUI example below.

``` codeExampleCS
using UnityEditor;
using UnityEngine;
using System.Collections;

// Example script with properties.
public class MyPlayerAlternative : MonoBehaviour

// Custom Editor the "old" way by modifying the script variables directly.
// No handling of multi-object editing, undo, and Prefab overrides!
[CustomEditor (typeof(MyPlayerAlternative))]
public class MyPlayerEditorAlternative : Editor

    // Custom GUILayout progress bar.
    void ProgressBar (float value, string label)
    
}
```

### Properties

| Property                                                                                                           | Description                                                                                                                       |
|--------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| [hasUnsavedChanges](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor-hasUnsavedChanges.html)   | This property specifies whether the Editor prompts the user to save or discard unsaved changes before the Inspector gets rebuilt. |
| [saveChangesMessage](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor-saveChangesMessage.html) | The message that displays to the user if they are prompted to save.                                                               |
| [serializedObject](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor-serializedObject.html)     | A SerializedObject representing the object or objects being inspected.                                                            |
| [target](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor-target.html)                         | The object being inspected.                                                                                                       |
| [targets](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor-targets.html)                       | An array of all the object being inspected.                                                                                       |

### Public Methods

| Method                                                                                                                       | Description                                                                                                                                                                                      |
|------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [CreateInspectorGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.CreateInspectorGUI.html)           | Implement this method to make a custom UIElements inspector.                                                                                                                                     |
| [CreatePreview](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.CreatePreview.html)                     | Implement this method to make a custom UIElements inspector preview.                                                                                                                             |
| [DiscardChanges](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.DiscardChanges.html)                   | Discards unsaved changes to the contents of the editor.                                                                                                                                          |
| [DrawDefaultInspector](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.DrawDefaultInspector.html)       | Draws the built-in Inspector.                                                                                                                                                                    |
| [DrawHeader](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.DrawHeader.html)                           | Call this function to draw the header of the editor.                                                                                                                                             |
| [DrawPreview](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.DrawPreview.html)                         | The first entry point for Preview Drawing.                                                                                                                                                       |
| [GetInfoString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.GetInfoString.html)                     | Implement this method to show asset information on top of the asset preview.                                                                                                                     |
| [GetPreviewTitle](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.GetPreviewTitle.html)                 | Override this method if you want to change the label of the Preview area.                                                                                                                        |
| [HasPreviewGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.HasPreviewGUI.html)                     | Override this method in subclasses if you implement OnPreviewGUI.                                                                                                                                |
| [OnInspectorGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.OnInspectorGUI.html)                   | Implement this function to make a custom inspector.                                                                                                                                              |
| [OnInteractivePreviewGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.OnInteractivePreviewGUI.html) | Implement to create your own interactive custom preview. Interactive custom previews are used in the preview area of the inspector and the object selector.                                      |
| [OnPreviewGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.OnPreviewGUI.html)                       | Creates a custom preview for the preview area of the Inspector, the headers of the primary Editor, and the object selector.You must implement Editor.HasPreviewGUI for this method to be called. |
| [OnPreviewSettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.OnPreviewSettings.html)             | Override this method if you want to show custom controls in the preview header.                                                                                                                  |
| [RenderStaticPreview](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.RenderStaticPreview.html)         | Override this method if you want to render a static preview.                                                                                                                                     |
| [Repaint](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.Repaint.html)                                 | Redraw any inspectors that shows this editor.                                                                                                                                                    |
| [RequiresConstantRepaint](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.RequiresConstantRepaint.html) | Checks if this editor requires constant repaints in its current state.                                                                                                                           |
| [SaveChanges](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.SaveChanges.html)                         | Performs a save action on the contents of the editor.                                                                                                                                            |
| [UseDefaultMargins](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.UseDefaultMargins.html)             | Override this method in subclasses to return false if you don't want default margins.                                                                                                            |

### Protected Methods

| Method                                                                                                                 | Description                                                           |
|------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------|
| [ShouldHideOpenButton](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.ShouldHideOpenButton.html) | Returns the visibility setting of the "open" button in the Inspector. |

### Static Methods

| Method                                                                                                                                   | Description                                                                                                                                                                                                |
|------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [CreateCachedEditor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.CreateCachedEditor.html)                       | On return previousEditor is an editor for targetObject or targetObjects. The function either returns if the editor is already tracking the objects, or destroys the previous editor and creates a new one. |
| [CreateCachedEditorWithContext](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.CreateCachedEditorWithContext.html) | Creates a cached editor using a context object.                                                                                                                                                            |
| [CreateEditor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.CreateEditor.html)                                   | Make a custom editor for targetObject or targetObjects.                                                                                                                                                    |
| [CreateEditorWithContext](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.CreateEditorWithContext.html)             | Make a custom editor for targetObject or targetObjects with a context object.                                                                                                                              |
| [DrawFoldoutInspector](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.DrawFoldoutInspector.html)                   | Draws the inspector GUI with a foldout header for target.                                                                                                                                                  |

### Messages

| Message                                                                                                        | Description                                                        |
|----------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|
| [HasFrameBounds](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.HasFrameBounds.html)     | Validates whether custom bounds can be calculated for this Editor. |
| [OnGetFrameBounds](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.OnGetFrameBounds.html) | Gets custom bounds for the target of this editor.                  |
| [OnSceneGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor.OnSceneGUI.html)             | Enables the Editor to handle an event in the Scene view.           |

### Events

| Event                                                                                                                          | Description                                                                                                       |
|--------------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| [finishedDefaultHeaderGUI](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Editor-finishedDefaultHeaderGUI.html) | An event raised while drawing the header of the Inspector window, after the default header items have been drawn. |

### Inherited Members

### Properties

| Property                                                                                         | Description                                                                            |
|--------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------|
| [hideFlags](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-hideFlags.html) | Controls whether the object is hidden, saved with the scene, and editable by the user. |
| [name](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-name.html)           | The name of the object.                                                                |

### Public Methods

| Method                                                                                                   | Description                           |
|----------------------------------------------------------------------------------------------------------|---------------------------------------|
| [GetHashCode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetHashCode.html)     | Returns the hash code for the object. |
| [GetInstanceID](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.GetInstanceID.html) | Gets the instance ID of the object.   |
| [ToString](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.ToString.html)           | Returns the name of the object.       |

### Static Methods

| Method                                                                                                                   | Description                                                                                                                                                 |
|--------------------------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [Destroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Destroy.html)                             | Removes a GameObject, component, or asset.                                                                                                                  |
| [DestroyImmediate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DestroyImmediate.html)           | Destroys the specified object immediately. Use with caution and in Edit mode only.                                                                          |
| [DontDestroyOnLoad](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.DontDestroyOnLoad.html)         | Do not destroy the target Object when loading a new Scene.                                                                                                  |
| [FindAnyObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindAnyObjectByType.html)     | Retrieves any active loaded object of Type T.                                                                                                               |
| [FindFirstObjectByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindFirstObjectByType.html) | Retrieves the first active loaded object of Type type.                                                                                                      |
| [FindObjectsByType](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.FindObjectsByType.html)         | Retrieves a list of all loaded objects of Type type and sorts the results according to sortMode.                                                            |
| [Instantiate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.Instantiate.html)                     | Clones the object original and returns the clone.                                                                                                           |
| [InstantiateAsync](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object.InstantiateAsync.html)           | Captures a snapshot of the original object that's related to another GameObject and obtains an AsyncInstantiateOperation instance of the resulting objects. |
| [CreateInstance](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.CreateInstance.html)     | Creates an instance of a scriptable object.                                                                                                                 |

### Operators

| Operator                                                                                             | Description                                                             |
|------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------|
| [bool](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_Object.html)    | Determines whether the object exists.                                   |
| [operator !=](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_ne.html) | Compares if two objects refer to a different object.                    |
| [operator ==](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Object-operator_eq.html) | Compares two object references to see if they refer to the same object. |

### Messages

| Message                                                                                                      | Description                                                                                          |
|--------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|
| [Awake](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.Awake.html)           | Called when an instance of ScriptableObject is created.                                              |
| [OnDestroy](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnDestroy.html)   | This function is called when the scriptable object will be destroyed.                                |
| [OnDisable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnDisable.html)   | This function is called when the scriptable object goes out of scope.                                |
| [OnEnable](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnEnable.html)     | This function is called when the object is loaded.                                                   |
| [OnValidate](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.OnValidate.html) | Editor-only function that Unity calls when the script is loaded or a value changes in the Inspector. |
| [Reset](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.Reset.html)           | Reset to default values.                                                                             |
