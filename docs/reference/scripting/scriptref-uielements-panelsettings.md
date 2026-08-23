---
title: "Scripting API: UIElements.PanelSettings"
page_title: "Unity - Scripting API: PanelSettings"
source_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# PanelSettings

class in UnityEngine.UIElements

/

Inherits from:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/ScriptableObject.html" class="cl">ScriptableObject</a>

/

Implemented in:<a href="https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UnityEngine.UIElementsModule.html" class="cl">UnityEngine.UIElementsModule</a>

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

Defines a Panel Settings asset that instantiates a panel at runtime. The panel makes it possible for Unity to display UXML-file based UI in the Game view.

The UIDocument component contains a reference to a PanelSettings object. The PanelSettings contains the rendering settings for the UI, including the scale mode and the sort order. Multiple UIDocument components can point to the same PanelSettings object, which optimizes performance when using multiple UI screens in the same scene.  
For more information on the different properties of the PanelSettings object, refer to [Panel Settings properties reference](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-Runtime-Panel-Settings.html).

### Properties

| Property                                                                                                                                                 | Description                                                                                                                                                                                                                                       |
|----------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [bindingLogLevel](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-bindingLogLevel.html)                           | Sets the log level for bindings in panels using this PanelSettings asset.                                                                                                                                                                         |
| [clearColor](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-clearColor.html)                                     | Determines whether the color buffer is cleared before the panel is rendered.                                                                                                                                                                      |
| [clearDepthStencil](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-clearDepthStencil.html)                       | Determines whether the depth/stencil buffer is cleared before the panel is rendered.                                                                                                                                                              |
| [colorClearValue](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-colorClearValue.html)                           | The color used to clear the color buffer.                                                                                                                                                                                                         |
| [depthClearValue](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-depthClearValue.html)                           | The depth used to clear the depth/stencil buffer.                                                                                                                                                                                                 |
| [dynamicAtlasSettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-dynamicAtlasSettings.html)                 | Settings of the dynamic atlas.                                                                                                                                                                                                                    |
| [fallbackDpi](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-fallbackDpi.html)                                   | The DPI value that Unity uses when it cannot determine the screen DPI.                                                                                                                                                                            |
| [forceGammaRendering](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-forceGammaRendering.html)                   | Forces the UI shader to output colors in the gamma color space.                                                                                                                                                                                   |
| [match](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-match.html)                                               | Determines whether Unity uses width, height, or a mix of the two as a reference when it scales the panel area.                                                                                                                                    |
| [referenceDpi](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-referenceDpi.html)                                 | The DPI that the UI is designed for.                                                                                                                                                                                                              |
| [referenceResolution](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-referenceResolution.html)                   | The resolution the UI is designed for.                                                                                                                                                                                                            |
| [referenceSpritePixelsPerUnit](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-referenceSpritePixelsPerUnit.html) | Sprites have a Pixels Per Unit value that controls the pixel density of the sprite. For sprites that have the same Pixels Per Unit value as the Reference Pixels Per Unit value in the PanelSettings asset, the pixel density will be one to one. |
| [renderMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-renderMode.html)                                     | Determines how the panel is rendered. Defaults to PanelRenderMode.ScreenSpaceOverlay.                                                                                                                                                             |
| [scale](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-scale.html)                                               | A uniform scaling factor that Unity applies to elements in the panel before the panel transform.                                                                                                                                                  |
| [scaleMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-scaleMode.html)                                       | Determines how elements in the panel scale when the screen size changes.                                                                                                                                                                          |
| [screenMatchMode](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-screenMatchMode.html)                           | Specifies how to scale the panel area when the aspect ratio of the current resolution does not match the reference resolution.                                                                                                                    |
| [sortingOrder](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-sortingOrder.html)                                 | When the Scene uses more than one panel, this value determines where this panel appears in the sorting order relative to other panels.                                                                                                            |
| [targetDisplay](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-targetDisplay.html)                               | Set the display intended for the panel.                                                                                                                                                                                                           |
| [targetTexture](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-targetTexture.html)                               | Specifies a Render Texture to render the panel's UI on.                                                                                                                                                                                           |
| [textSettings](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-textSettings.html)                                 | Specifies a PanelTextSettings that will be used by every UI Document attached to the panel.                                                                                                                                                       |
| [textureSlotCount](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-textureSlotCount.html)                         | The maximum number of textures that UI Toolkit can bind to the shader at once.                                                                                                                                                                    |
| [themeStyleSheet](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-themeStyleSheet.html)                           | Specifies a style sheet that Unity applies to every UI Document attached to the panel.                                                                                                                                                            |
| [vertexBudget](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings-vertexBudget.html)                                 | The expected number of vertices that will be used by this panel.                                                                                                                                                                                  |

### Public Methods

| Method                                                                                                                                                         | Description                                                                                                                                                                                                                                   |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| [SetPanelChangeReceiver](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings.SetPanelChangeReceiver.html)                   | Sets a custom IPanelChangeReceiver in the panelChangeReceiver setter to receive every change event. This method is available only in development builds and the editor, as it is a debug feature to go along the profiling of an application. |
| [SetScreenToPanelSpaceFunction](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings.SetScreenToPanelSpaceFunction.html)     | Sets the function that handles the transformation from screen space to panel space. For overlay panels, this function returns the input value.                                                                                                |
| [SetScreenToPanelSpaceFunction3D](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/UIElements.PanelSettings.SetScreenToPanelSpaceFunction3D.html) | Sets the function that handles the transformation from screen space to panel space. For overlay panels, this function returns the input value.                                                                                                |

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
