---
title: "Unity 6.3 Manual: Create custom Editors with IMGUI"
page_title: "Unity - Manual: Create custom Editors with IMGUI"
source_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/editor-CustomEditors.html"
final_url: "https://docs.unity3d.com/6000.3/Documentation/Manual/editor-CustomEditors.html"
topic: "scripting"
publisher: "Unity Technologies"
fetched: "2026-08-23"
kind: "html"
---

# Create custom Editors with IMGUI

**Note**: It’s strongly recommended to use the [UI Toolkit](https://docs.unity3d.com/6000.3/Documentation/Manual/UIElements.html) to extend the [Unity Editor](https://docs.unity3d.com/6000.3/Documentation/Manual/UIE-support-for-editor-ui.html), as it provides a more modern, flexible, and scalable solution than IMGUI.

To speed up application development, create custom editors for components you commonly use. This page shows you how to create a simple script to make GameObjects always look at a point.

1.  Create a C# script and name it “LookAtPoint”.
2.  Open the script and replace its contents with the code below.
3.  Attach the script to a GameObject in your Scene.

``` lang-cs
using UnityEngine;
public class LookAtPoint : MonoBehaviour

}
```

When you enter Play mode, the GameObject that you attached the script to now orientates itself towards the coordinates you set to the “Look At Point” property. When writing Editor scripts, it’s often useful to make certain scripts execute during **Edit mode**, while your application is not running. To do this, add the `ExecuteInEditMode` attribute to the class, like this:

``` lang-cs
using UnityEngine;
[ExecuteInEditMode]
public class LookAtPoint : MonoBehaviour

}
```

Now if you move the GameObject in the Editor, or change the values of “Look At Point” in the Inspector, the GameObject updates its rotation so that it looks at the target point in world space.

### Making a Custom Editor

The above demonstrates how you can get simple scripts running during edit-time, however this alone does not allow you to create your own Editor tools. The next step is to create a **Custom Editor** for the script you just created.

When you create a script in Unity, by default it inherits from MonoBehaviour, and therefore is a component that you can attach to a GameObject. When you place a component on a GameObject, the Inspector displays a default interface that you can use to view and edit every public variable, for example: an integer, a float, or a string.

This is how the Inspector for the LookAtPoint component looks by default:

![A default Inspector with a public Vector3 field](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/NoCustomInspector.png)

**A custom editor is a separate script which *replaces* this default layout with any editor controls that you choose.**

To create the custom editor for the LookAtPoint script:

1.  Create a new C# script and name it “LookAtPointEditor”.
2.  Open the script and replace its contents with the code below.

``` lang-cs
using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(LookAtPoint))]
[CanEditMultipleObjects]
public class LookAtPointEditor : Editor 

    public override void OnInspectorGUI()
    
}
```

This class must inherit from **Editor**. The **CustomEditor** attribute informs Unity which component it should act as an editor for. The **CanEditMultipleObjects** attribute tells Unity that you can select multiple objects with this editor and change them all at the same time.

Unity executes the code in OnInspectorGUI it displays the editor in the Inspector. You can put any GUI code in here and it works in the same way as OnGUI does, but runs inside the Inspector. Editor defines the target property that you can use to access the GameObject you are inspecting.

This is how the Inspector for the LookAtPoint component looks with the new editor:

![The Look At Point component in the new editor](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/CustomInspector.png)

This looks very similar (although the “Script” field is now not present, because the editor script does not add any Inspector code to show it).

However now that you have control over how the Inspector displays in an Editor script, you can use any code you like to lay out the Inspector fields, allow the user to adjust the values, and even display graphics or other visual elements. In fact all of the Inspectors you see within the Unity Editor including the more complex Inspectors such as the terrain system and animation import settings, are all made using the same API that you have access to when creating your own custom Editors.

Here is a simple example which extends your editor script to display a message that indicates whether the target point is above or below the GameObject:

``` lang-cs
using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(LookAtPoint))]
[CanEditMultipleObjects]
public class LookAtPointEditor : Editor

    public override void OnInspectorGUI()
    
        if (lookAtPoint.vector3Value.y < (target as LookAtPoint).transform.position.y)
        
    }
}
```

This is how the Inspector for the LookAtPoint component looks with the message showing if the target point is above or below the GameObject.

![The component in the Inspector now includes information about the target’s location relative to the GameObject](https://docs.unity3d.com/6000.3/Documentation/uploads/Main/CustomInspector2.png)

You have full access to all the IMGUI commands to draw any type of interface, including rendering Scenes using a Camera within Editor windows.

### Scene View Additions

You can add extra code to the Scene View. To do this, implement OnSceneGUI in your custom editor.

OnSceneGUI works just like OnInspectorGUI except it runs in the Scene view. To help you make your own editing controls, you can use the functions defined in the [Handles](https://docs.unity3d.com/6000.3/Documentation/ScriptReference/Handles.html) class. All functions in there are designed for working in 3D Scene views.

``` lang-cs
using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(LookAtPoint))]
[CanEditMultipleObjects]
public class LookAtPointEditor : Editor

    public override void OnInspectorGUI()
    
        if (lookAtPoint.vector3Value.y < (target as LookAtPoint).transform.position.y)
        
        serializedObject.ApplyModifiedProperties();
    }

    public void OnSceneGUI()
    
    }
}
```

If you want to add 2D GUI objects (for example: GUI or EditorGUI), you need to wrap them in calls to Handles.BeginGUI() and Handles.EndGUI().
